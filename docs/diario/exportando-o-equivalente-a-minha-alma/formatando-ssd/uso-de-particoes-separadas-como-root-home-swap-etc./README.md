# Uso de Partições Separadas (como  root, home, swap, etc.)

* Ao separar as partições, você pode otimizar a utilização de diferentes áreas do SSD para tipos de dados específicos.&#x20;

> Por exemplo, ao colocar o diretório `home` em uma partição separada da partição `/`, pode evitar a mistura de blocos de memória e a fragmentação de setores inteiros, implementando essa heuristica.

* A separação das partições permite organizar melhor os dados e evitar que a partição raiz fique excessivamente cheia.&#x20;
* Se a partição raiz (onde o sistema operacional e os arquivos de configuração ficam) estiver cheia, o SSD pode ter que mover dados para "blocos" menos eficientes afetando o desempenho.

```

    # Definir os parâmetros de partição (nome, tipo e tamanho relativo)
    declare -A PARTITIONS=(
        ["Cortex-Boot-EFI"]="ef00 512M"
        ["Cerebellum-Boot"]="8300 1G"
        ["root"]="8300 $((VG_SIZE_MB * 20 / 100))M"
        ["var"]="8300 $((VG_SIZE_MB * 5 / 100))M"
        ["tmp"]="8300 $((VG_SIZE_MB * 2 / 100))M"
        ["usr"]="8300 $((VG_SIZE_MB * 34 / 100))M"
        ["swap"]="8200 $((VG_SIZE_MB * 5 / 100))M"
        ["home"]="8300 0"
    )
```

> Todas as flags usadas aqui são do sgdisk, onde usei um algoritmo de compressão entrópica para executar a formatação incial

Repare que aqui umas das lógicas que usei para garantia de 100% de uso do meu espaço foram valores relativos, onde eu pré-defini as variaveis com as seguintes linhas:

{% code overflow="wrap" %}
```
    DISK_SIZE_BYTES=$(blockdev --getsize64 $DISK) # Consifo o balor do ssd em bytes
    VG_SIZE_MB=$((DISK_SIZE_BYTES / 1024 / 1024 - 1536)) # Converto para Megabytes subtraindo o reservado para boot e EFI
```
{% endcode %}
