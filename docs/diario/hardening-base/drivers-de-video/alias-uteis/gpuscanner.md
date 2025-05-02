# gpuScanner

Essa função pode ser usada para mapear as opções do meu uhd 620 Graphin

{% code overflow="wrap" %}
```bash
#!/bin/bash

# Larguras de colunas
COL1_WIDTH=50
COL2_WIDTH=30
TOTAL_WIDTH=$((COL1_WIDTH + COL2_WIDTH + 7))

# Funções de formatação
print_table_row() {
  printf "│ %-*s │ %-*s │\n" "$COL1_WIDTH" "$1" "$COL2_WIDTH" "$2"
}

print_table_header() {
  printf "├%s┼%s┤\n" "$(printf '─%.0s' $(seq 1 $COL1_WIDTH))" "$(printf '─%.0s' $(seq 1 $COL2_WIDTH))"
  printf "│ %-*s │ %-*s │\n" "$COL1_WIDTH" "Arquivo / Parâmetro" "$COL2_WIDTH" "Valor"
  printf "├%s┼%s┤\n" "$(printf '─%.0s' $(seq 1 $COL1_WIDTH))" "$(printf '─%.0s' $(seq 1 $COL2_WIDTH))"
}

print_table_footer() {
  printf "└%s┴%s┘\n" "$(printf '─%.0s' $(seq 1 $COL1_WIDTH))" "$(printf '─%.0s' $(seq 1 $COL2_WIDTH))"
}

print_title_box() {
  local title="$1"
  printf "┌%s┐\n" "$(printf '─%.0s' $(seq 1 $((TOTAL_WIDTH - 2))))"
  printf "│ %-*s │\n" "$((TOTAL_WIDTH - 4))" "$title"
  printf "└%s┘\n" "$(printf '─%.0s' $(seq 1 $((TOTAL_WIDTH - 2))))"
}

# Parte 1: GPUs e suas interfaces
echo "�� GPU Frequências e Estados — /sys/class/drm/card*/"
for card in /sys/class/drm/card*/; do
  [ -d "$card" ] || continue
  print_title_box "GPU: ${card%/}"
  print_table_header

  for file in gt_RP0_freq_mhz gt_RP1_freq_mhz gt_RPn_freq_mhz gt_cur_freq_mhz; do
    path="$card/$file"
    if [[ -f "$path" ]]; then
      value=$(cat "$path" 2>/dev/null)
      print_table_row "$file" "$value MHz"
    fi
  done
  print_table_footer

  # Interfaces (HDMI, eDP, etc)
  for output in "$card"-*; do
    [ -e "$output" ] || continue
    print_title_box "GPU: ${output}"
    print_table_header
    print_table_footer
  done
done

# Parte 2: Parâmetros do driver i915
echo
echo "📁 Parâmetros do driver i915 — /sys/module/i915/parameters/"
print_title_box "Módulo: i915"
print_table_header

for param in /sys/module/i915/parameters/*; do
  name=$(basename "$param")
  if [[ -f "$param" ]]; then
    value=$(cat "$param" 2>/dev/null | tr -d '\n')
    print_table_row "$name" "$value"
  fi
done
print_table_footer
```
{% endcode %}

Após isso, torne-o executavel com `chmod +x`  adiciona o source para ele .bashrc

```
alias gpuScanner="/opt/laplaceD/gpu.scanner"
```
