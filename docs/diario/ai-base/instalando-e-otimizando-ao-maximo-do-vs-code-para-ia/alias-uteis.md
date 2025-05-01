---
icon: '0'
---

# Alias Uteis

Esse daqui é mais uma automação, cole no bashrc e ele sempre lhe dara um scanner quando inciar ao custo de alguns segudos

{% code overflow="wrap" %}
```bash
OUTPUT="/tmp/system_scan_$(date +%s).json"

echo "{" > "$OUTPUT"

# ✅ INFORMAÇÕES GERAIS DO SISTEMA
echo '"system_info":' >> "$OUTPUT"
hostnamectl --json=pretty >> "$OUTPUT"
echo "," >> "$OUTPUT"

# ✅ CPU & FREQ
echo '"cpu": {' >> "$OUTPUT"
lscpu | awk -F: '{print "\"" $1 "\": \"" $2 "\","}' | sed '$ s/,$//' >> "$OUTPUT"
echo "}," >> "$OUTPUT"

# ✅ INFO DE MEMÓRIA
echo '"memory": {' >> "$OUTPUT"
free -m | awk '/Mem:/ {printf "\"total_MB\": \"%s\", \"used_MB\": \"%s\", \"free_MB\": \"%s\"", $2, $3, $4}' >> "$OUTPUT"
echo "}," >> "$OUTPUT"

# ✅ KERNEL E SISTEMA
echo '"kernel": {' >> "$OUTPUT"
uname -a | awk '{print "\"full\": \"" $0 "\""}' >> "$OUTPUT"
echo "}," >> "$OUTPUT"

# ✅ SISTEMA DE ARQUIVOS
echo '"filesystems":' >> "$OUTPUT"
lsblk -J -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL >> "$OUTPUT"
echo "," >> "$OUTPUT"

# ✅ USO DE DISCO
echo '"disk_usage":' >> "$OUTPUT"
df -h --output=source,fstype,size,used,avail,pcent,target -x tmpfs -x devtmpfs | tail -n +2 | jq -Rn '
  [inputs | split(" ") | map(select(length > 0))] |
  map({"device": .[0], "fstype": .[1], "size": .[2], "used": .[3], "avail": .[4], "used_pct": .[5], "mount": .[6]})
' >> "$OUTPUT"
echo "," >> "$OUTPUT"

# ✅ INFORMAÇÕES DE ENERGIA E BATERIA
echo '"power": {' >> "$OUTPUT"
upower -i $(upower -e | grep BAT) 2>/dev/null | grep -E "state|to\ full|percentage|capacity" | sed 's/^[ \t]*//' | awk -F: '{print "\"" $1 "\": \"" $2 "\","}' | sed '$ s/,$//' >> "$OUTPUT"
echo "}," >> "$OUTPUT"

# ✅ GPU
echo '"gpu_info":' >> "$OUTPUT"
lspci -nnk | grep -iA3 VGA | jq -Rs '.' >> "$OUTPUT"
echo "," >> "$OUTPUT"


echo "}" >> "$OUTPUT"

echo -e "\n✅ Scanner completo! Arquivo gerado em: $OUTPUT"
echo "Use esse JSON para alimentar uma LLM e gerar recomendações inteligentes de otimização!"
EOF
```
{% endcode %}
