#!/bin/bash

echo "🚀 Instalando daemon bayesiano fodástico..."

BIN_PATH="/usr/local/bin/bayes_opt.sh"
SERVICE_PATH="/etc/systemd/system/bayes_opt.service"

# 1. Script principal (o bicho feio todo)
cat <<'EOF' > "$BIN_PATH"
#!/bin/bash


BASE_DIR="/etc/bayes_mem"

LOG_DIR="/var/log/bayes_mem"

TREND_LOG="$BASE_DIR/cpu_trend.log"

HISTORY_FILE="$BASE_DIR/cpu_history"

MAX_HISTORY=5

MAX_TDP=15

CORES_TOTAL=$(nproc --all)


initialize_directories() {

    mkdir -p "$BASE_DIR" "$LOG_DIR"

    [[ -f "$HISTORY_FILE" ]] || touch "$HISTORY_FILE"

    [[ -f "$TREND_LOG" ]] || touch "$TREND_LOG"

}


faz_o_urro() {

    local new_val="$1"

    local history_arr=()

    local sum=0 avg=0

    [[ -f "$HISTORY_FILE" ]] && mapfile -t history_arr < "$HISTORY_FILE"

    history_arr+=("$new_val")

    (( ${#history_arr[@]} > MAX_HISTORY )) && history_arr=("${history_arr[@]: -$MAX_HISTORY}")

    for val in "${history_arr[@]}"; do sum=$((sum + val)); done

    avg=$((sum / ${#history_arr[@]}))

    printf "%s\n" "${history_arr[@]}" | sudo tee "$HISTORY_FILE" >/dev/null

    echo "$avg"

}


get_cpu_usage() {

    local stat_hist_file="${BASE_DIR}/last_stat"

    local cpu_line prev_line usage=0

    cpu_line=$(grep -E '^cpu ' /proc/stat)

    prev_line=$(cat "$stat_hist_file" 2>/dev/null || echo "$cpu_line")

    echo "$cpu_line" | sudo tee "$stat_hist_file" >/dev/null

    read -r _ pu pn ps pi _ <<< "$prev_line"

    read -r _ cu cn cs ci _ <<< "$cpu_line"

    local prev_total=$((pu + pn + ps + pi))

    local curr_total=$((cu + cn + cs + ci))

    local diff_idle=$((ci - pi))

    local diff_total=$((curr_total - prev_total))

    (( diff_total > 0 )) && usage=$(( (100 * (diff_total - diff_idle)) / diff_total ))

    echo "$usage"

}


determine_policy_key_from_avg() {

    local avg_load=$1 key="000"

    if (( avg_load >= 90 )); then key="100"

    elif (( avg_load >= 80 )); then key="080"

    elif (( avg_load >= 60 )); then key="060"

    elif (( avg_load >= 40 )); then key="040"

    elif (( avg_load >= 20 )); then key="020"

    elif (( avg_load >= 5 )); then key="005"

    elif (( avg_load >= 0 )); then key="000"

    fi

    echo "$key"

}


apply_cpu_governor() {

    local key="$1"

    declare -A MAP=(

        ["000"]="powersave"

        ["005"]="powersave"

        ["020"]="powersave"

        ["040"]="powersave"

        ["060"]="performance"

        ["080"]="performance"

        ["100"]="performance"

    )

    local cpu_gov="${MAP[$key]:-powersave}"

    local last_gov_file="${BASE_DIR}/last_gov"

    local cooldown_file="${BASE_DIR}/gov_cooldown"

    local now=$(date +%s)

    local last_gov="none"

    [[ -f "$last_gov_file" ]] && last_gov=$(cat "$last_gov_file")

    local last_change=0

    [[ -f "$cooldown_file" ]] && last_change=$(date -r "$cooldown_file" +%s)

    local delta=$((now - last_change))


    # local dynamic_cd=$(calc_impact_cooldown 1.0)


    if [[ "$cpu_gov" != "$last_gov" ]]; then

        echo "🔄 Aplicando governor $cpu_gov"

        for policy in /sys/devices/system/cpu/cpufreq/policy*; do

            echo "$cpu_gov" | sudo tee "$policy/scaling_governor" >/dev/null

        done

        echo "$cpu_gov" | sudo tee "$last_gov_file" >/dev/null

        sudo touch "$cooldown_file"

    else

        echo "⚠ Governor atual ou cooldown ativo: $cpu_gov (${delta}s)"

    fi

}


apply_tdp_profile() {

    local key="$1" tdp_pair

    declare -A MAP=(

        ["000"]="3 0" ["005"]="$((MAX_TDP * 30 / 100)) $((MAX_TDP * 0))" 

        ["020"]="$((MAX_TDP * 50 / 100)) $((MAX_TDP * 10 / 100))" 

        ["040"]="$((MAX_TDP * 70 / 100)) $((MAX_TDP * 20 / 100))" 

        ["060"]="$((MAX_TDP * 80 / 100)) $((MAX_TDP * 30 / 100))" 

        ["080"]="$((MAX_TDP * 90 / 100)) $((MAX_TDP * 40 / 100))" 

        ["100"]="$MAX_TDP $((MAX_TDP * 50 / 100))"

    )

    tdp_pair="${MAP[$key]}"

    [[ -z "$tdp_pair" ]] && { echo "❌ Perfil TDP inválido"; return 1; }


    read target_max target_min <<< "$tdp_pair"

    local now=$(date +%s)

    local current_power="${target_min} ${target_max}"

    local last_power_file="${BASE_DIR}/last_power"

    local cooldown_file="${BASE_DIR}/power_cooldown"

    local last_power="none" last_change=0 delta


    [[ -f "$last_power_file" ]] && last_power=$(cat "$last_power_file")

    [[ -f "$cooldown_file" ]] && last_change=$(date -r "$cooldown_file" +%s)

    delta=$((now - last_change))


    # echo "🌡  Temp=$(get_temp)°C | ΔCarga=$(get_load_variance) | Cooldown=${dynamic_cd}s"

    if [[ "$current_power" != "$last_power" ]]; then

        echo "⚡ Aplicando TDP: MIN=${target_min}W | MAX=${target_max}W"

        echo $((target_min * 1000000)) > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw 2>/dev/null

        echo $((target_max * 1000000)) > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw 2>/dev/null

        echo "$current_power" > "$last_power_file"

        touch "$cooldown_file"

    else

        echo "✅ TDP já aplicado (MIN=${target_min}, MAX=${target_max})"

    fi

}


apply_zram_config() {

    local key="$1" streams_alg streams alg

    declare -A MAP=(

        ["000"]="0 0" ["005"]="$((CORES_TOTAL * 15 / 100)) zstd" 

        ["020"]="$((CORES_TOTAL * 30 / 100)) lz4hc" 

        ["040"]="$((CORES_TOTAL * 45 / 100)) lz4" 

        ["060"]="$((CORES_TOTAL * 60 / 100)) lzo" 

        ["080"]="$((CORES_TOTAL * 50 / 100)) lzo" 

        ["100"]="$CORES_TOTAL lzo-rle"

    )

    streams_alg="${MAP[$key]}" && streams="${streams_alg% *}" alg="${streams_alg#* }"

    local last_streams_file="${BASE_DIR}/last_zram_streams"

    local last_alg_file="${BASE_DIR}/last_zram_algorithm"

    local cooldown_file="${BASE_DIR}/cooldown_zram"

    local current_streams=0 current_alg="none"


    [[ -f "$last_streams_file" ]] && current_streams=$(cat "$last_streams_file")

    [[ -f "$last_alg_file" ]] && current_alg=$(cat "$last_alg_file")


    if (( streams != current_streams || alg != current_alg )); then

        local now=$(date +%s)

        local last_change=0 delta

        [[ -f "$cooldown_file" ]] && last_change=$(date -r "$cooldown_file" +%s)

        delta=$((now - last_change))


        echo "🔧 Reconfigurando ZRAM: Streams=$streams Alg=$alg"

        for dev in /dev/zram*; do swapoff "$dev" 2>/dev/null; done

        sleep 0.3

        modprobe -r zram 2>/dev/null

        modprobe zram num_devices="$streams"

        for i in /dev/zram*; do

            echo 1 > "/sys/block/$(basename "$i")/reset"

            echo "$alg" > "/sys/block/$(basename "$i")/comp_algorithm"

            echo 1G > "/sys/block/$(basename "$i")/disksize"

            mkswap "$i" && swapon "$i"

        done

        echo "$streams" > "$last_streams_file"

        echo "$alg" > "$last_alg_file"

        touch "$cooldown_file"

    else

        echo "✅ ZRAM já configurado"

    fi

}


apply_all() {

    local current_usage=$(get_cpu_usage)

    local avg_usage=$(faz_o_urro "$current_usage")

    local policy_key=$(determine_policy_key_from_avg "$avg_usage")

    echo -e "\n🔄 $(date) | Uso: ${current_usage}% | Média: ${avg_usage}% | Perfil: ${policy_key}%"

    apply_cpu_governor "$policy_key"

    apply_tdp_profile "$policy_key"

    apply_zram_config "$policy_key"

}


main() {

    initialize_directories

    echo "🟢 Iniciando OTIMIZADOR BAYESIANO"

    while true; do

        {

            echo "🧾 Último perfil aplicado: $(date)"

            apply_all

        } >> "$LOG_DIR/bayes.log"

        sleep 5

    done

}


main



EOF

chmod +x "$BIN_PATH"

# 2. Service systemd
cat <<EOF > "$SERVICE_PATH"
[Unit]
Description=Daemon Bayesiano de Otimização de CPU e ZRAM
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
ExecStart=$BIN_PATH
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

echo "🔧 Recarregando systemd..."
systemctl daemon-reexec
systemctl daemon-reload

echo "✅ Habilitando serviço no boot..."
systemctl enable --now bayes_opt.service

echo "📡 Status do serviço:"
systemctl status bayes_opt.service --no-pager
