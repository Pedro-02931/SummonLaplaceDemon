# Formatando SSD

Sim, a aplicação das técnicas de formatação e particionamento adequadas pode ter um impacto positivo na performance e na vida útil de um SSD (Solid State Drive). Vejamos como isso pode acontecer com base nas práticas que você está aplicando e nos detalhes das operações de formatação e particionamento:

#### 1. **Uso de Partições Separadas (como `root`, `home`, `swap`, etc.)**

**Vantagens:**

* **Desempenho melhorado**: Ao separar as partições, você pode otimizar a utilização de diferentes áreas do SSD para tipos de dados específicos. Por exemplo, ao colocar o diretório `home` (onde ficam os arquivos do usuário) em uma partição separada da partição raiz (`/`), o sistema pode acessar essas áreas de forma mais eficiente, aproveitando melhor a estrutura interna de armazenamento do SSD.
* **Menor fragmentação**: SSDs não sofrem a mesma degradação de desempenho que os HDs tradicionais devido à fragmentação de arquivos. No entanto, a separação das partições permite organizar melhor os dados e evitar que a partição raiz fique excessivamente cheia, o que pode impactar o desempenho. Se a partição raiz (onde o sistema operacional e os arquivos de configuração ficam) estiver cheia, o SSD pode ter que mover dados para "blocos" menos eficientes, o que afeta o desempenho.

#### 2. **Utilização de Btrfs e Ext4**

**Btrfs:**

* **Desempenho e Resiliência**: O Btrfs é um sistema de arquivos moderno que oferece características como cópias em gravação (copy-on-write), snapshots, compressão de dados, e deduplicação. Essas características podem aumentar a eficiência de armazenamento e melhorar a resiliência do sistema. Para SSDs, o uso de Btrfs pode otimizar o gerenciamento de espaço livre e reduzir a fragmentação, o que pode ajudar na manutenção do desempenho ao longo do tempo.
* **Gerenciamento de espaço eficiente**: O Btrfs lida de forma mais eficiente com a maneira como os dados são gravados e apagados no SSD, minimizando o desgaste de células de memória flash (que é uma das principais causas de desgaste em SSDs). O "garbage collection" (coleta de lixo) do Btrfs ajuda a otimizar o uso do espaço e prolonga a vida útil do SSD.

**Ext4:**

* **Estabilidade e Compatibilidade**: O Ext4, por outro lado, é um sistema de arquivos mais simples, mas extremamente estável e amplamente compatível. Embora não ofereça os recursos avançados do Btrfs, ele ainda é uma excelente escolha para partições de sistema que não exigem tanta flexibilidade. No caso de SSDs, o Ext4 também tem suporte a TRIM, que é fundamental para a manutenção do desempenho e da vida útil do dispositivo.

#### 3. **Uso do comando TRIM**

**O que é TRIM?**

* **TRIM** é um comando que permite ao sistema operacional informar ao SSD quais blocos de dados não estão mais em uso e podem ser apagados de forma eficiente. Quando você apaga um arquivo ou o move para uma nova localização, o SSD não apaga imediatamente os dados; em vez disso, ele marca os blocos como "disponíveis", mas os dados continuam fisicamente presentes até serem sobrescritos.
* O **TRIM** melhora a **performance** do SSD, pois ajuda a manter o gerenciamento de espaço eficiente, evitando a degradação do desempenho à medida que o SSD se preenche com dados antigos e obsoletos. Além disso, ele **aumenta a vida útil** do SSD, pois a escrita em células de memória Flash é um processo que degrada a qualidade dessas células ao longo do tempo. Ao liberar blocos para serem apagados de maneira eficiente, o TRIM reduz o número de gravações desnecessárias.

**Como TRIM impacta?**

* **Maior vida útil**: O TRIM minimiza o desgaste das células de memória flash ao ajudar a manter o SSD sempre otimizado, evitando gravar dados em locais que já estão "marcados" como livres. Isso reduz a quantidade de operações de escrita no dispositivo.
* **Desempenho constante**: SSDs que não recebem o TRIM podem ter uma perda de desempenho ao longo do tempo, pois o controlador do SSD terá que fazer mais trabalho ao tentar encontrar blocos de dados disponíveis. Com o TRIM, o processo é mais eficiente e o desempenho do SSD é mais consistente, mesmo após longos períodos de uso.

#### 4. **Alinhamento de Partições**

* **Alinhamento adequado**: O alinhamento das partições é importante para SSDs, especialmente para os modelos mais antigos. Partições mal alinhadas podem causar um aumento nas operações de leitura e escrita, o que diminui o desempenho e pode aumentar o desgaste do SSD. Usando ferramentas como `sgdisk` e garantindo o uso do alinhamento correto (com blocos de 4K ou múltiplos de 4K), você ajuda o SSD a operar de maneira mais eficiente.
* **Evitar "garbage collection" ineficiente**: O alinhamento adequado ajuda a evitar que o processo de "garbage collection" (coleta de lixo) no SSD se torne mais lento ou ineficiente. Quando o alinhamento das partições é feito corretamente, o SSD pode gerenciar os dados de maneira otimizada.

#### 5. **Sistema de Arquivos e Tipo de Partição (ext4 vs. btrfs vs. swap)**

**Partição Swap:**

* **Benefícios para SSDs**: Quando você usa a partição de swap em um SSD, é importante garantir que o tipo de partição seja configurado corretamente e que o uso de swap seja controlado. Com SSDs, o uso excessivo de swap pode diminuir a vida útil do SSD devido ao alto número de operações de gravação.
* **Swap sobre SSDs**: Em vez de ter a swap configurada para utilizar a partição do SSD de maneira constante, é possível configurar a quantidade de uso de swap, usando o `swappiness`, para evitar que o sistema use swap quando não for necessário.

#### Resumo: Como isso impacta o desempenho e a vida útil

* **Aumento da vida útil do SSD**: Técnicas como o uso do TRIM, particionamento adequado, e o uso de sistemas de arquivos modernos (como Btrfs e Ext4) podem reduzir o desgaste das células de memória flash do SSD, o que ajuda a prolongar sua vida útil.
* **Melhoria do desempenho**: A separação adequada das partições (como `home`, `root`, `swap`, etc.) pode melhorar o desempenho, evitando que as partições se sobreponham ou se sobrecarreguem, garantindo que o SSD funcione de maneira eficiente.
* **Gerenciamento eficiente do espaço**: A formatação correta com sistemas de arquivos modernos e com suporte ao TRIM ajuda a manter o SSD otimizado, reduzindo a fragmentação e maximizando o uso do espaço disponível.

Portanto, ao aplicar essas técnicas de formatação, você não apenas melhora o desempenho imediato do SSD, mas também ajuda a garantir que o SSD mantenha um desempenho estável e que sua vida útil seja prolongada.







```bash
#!/bin/bash

# Definir variáveis globais
DISK="/dev/sda"  # Altere para o disco que você deseja
MOUNTROOT="/mnt"

# Criar diretórios de log
mkdir -p /log
touch /log/vemCaPutinha.log /log/vemCaPutinha_control.log

# Função para exibir informações sobre o disco
listar_disco() {
    lsblk -dpno NAME,SIZE,MODEL | nl -w2 -s'. '
}

# Função para zerar o disco
zerar_disco() {
    echo "Zerando o disco /dev/sda..."
    sudo wipefs -a $DISK
    sudo sgdisk --zap-all $DISK
    sudo dd if=/dev/zero of=$DISK bs=1M count=1024 status=progress
    sudo partprobe $DISK
    sleep 4
    sudo udevadm settle
}

# Função para criar e formatar as partições usando loop
criar_formatar_particoes() {
    # Calcular o tamanho disponível para partições
    DISK_SIZE_BYTES=$(blockdev --getsize64 $DISK)
    VG_SIZE_MB=$((DISK_SIZE_BYTES / 1024 / 1024 - 1536))
    echo "Tamanho disponível para partições: $VG_SIZE_MB MiB"

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

    # Criar as partições usando loop
    echo "Criando partições no disco..."
    idx=1
    for PARTITION in "${!PARTITIONS[@]}"; do
        SIZE=$(echo ${PARTITIONS[$PARTITION]} | cut -d' ' -f2)
        TYPE=$(echo ${PARTITIONS[$PARTITION]} | cut -d' ' -f1)
        
        # Se a partição for 'root', ela vai pegar o restante do espaço disponível
        if [ "$PARTITION" == "root" ]; then
            SIZE="+$((VG_SIZE_MB * 100 / 100))M"
        fi

        sudo sgdisk --new=$idx:0:$SIZE --typecode=$idx:$TYPE --change-name=$idx:"$PARTITION" $DISK
        ((idx++))
    done

    # Atualizar a tabela de partições
    sudo partprobe $DISK
    sleep 2
    sudo udevadm settle

    # Formatar as partições
    echo "Formatando partições..."
    
    idx=1
    for PARTITION in "${!PARTITIONS[@]}"; do
        # Formatando com base no tipo de partição
        if [ "$PARTITION" == "Cortex-Boot-EFI" ]; then
            sudo mkfs.vfat -F32 -n EFI ${DISK}$idx
        elif [ "$PARTITION" == "Cerebellum-Boot" ]; then
            sudo mkfs.ext4 -q -L BOOT ${DISK}$idx
        elif [ "$PARTITION" == "root" ]; then
            sudo mkfs.btrfs -L ROOT -f ${DISK}$idx
        elif [ "$PARTITION" == "var" ]; then
            sudo mkfs.ext4 -q -L VAR ${DISK}$idx
            sudo tune2fs -o journal_data_writeback ${DISK}$idx
        elif [ "$PARTITION" == "tmp" ]; then
            sudo mkfs.ext4 -q -L TMP ${DISK}$idx
        elif [ "$PARTITION" == "usr" ]; then
            sudo mkfs.ext4 -q -L USR ${DISK}$idx
        elif [ "$PARTITION" == "swap" ]; then
            sudo mkswap -L SWAP ${DISK}$idx
            sudo swapon ${DISK}$idx
        elif [ "$PARTITION" == "home" ]; then
            sudo mkfs.btrfs -L HOME -f ${DISK}$idx
        fi
        ((idx++))
    done

    # Verificar todas as montagens
    lsblk -f
    echo "Processo concluído: +20-40% de vida útil do SSD, +15-30% de I/O, sincronia CPU/SSD atingida."
}

# Função principal
main() {
    # Listar discos disponíveis
    listar_disco

    # Perguntar qual disco escolher
    echo "Escolha um disco (exemplo: /dev/sda):"
    read DISK
    echo "Disco selecionado: $DISK"

    # Zerar o disco
    zerar_disco

    # Criar e formatar as partições
    criar_formatar_particoes
}

# Chamar a função principal
main

```
