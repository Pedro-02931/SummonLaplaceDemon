# Utilização de Btrfs e Ext4

**Btrfs:**

* O Btrfs(B-tree File System) é um sistema de arquivos moderno que oferece características como cópias em gravação (copy-on-write), snapshots, compressão de dados, e deduplicação.&#x20;
* Essas características podem aumentar a eficiência de armazenamento e melhorar a resiliência do sistema.&#x20;
*   Para SSDs, o uso de Btrfs pode otimizar o gerenciamento de espaço livre e reduzir a fragmentação, o que pode ajudar na manutenção do desempenho ao longo do tempo.

    > Ou seja, apesar de ter apenas 220GB reais, o meu desempenho pode equivaler a 300GB virtualizados!
* O Btrfs lida de forma mais eficiente com a maneira como os dados são gravados e apagados no SSD, minimizando o desgaste de células de memória flash.&#x20;
* Esse sistema implementa um "garbage collection" que otimiza o uso do espaço e prolonga a vida útil do SSD evitando buscas desnecessárias e desgaste excessivo.

**Ext4:**

* O Ext4, por outro lado, é um sistema de arquivos mais simples, mas extremamente estável e amplamente compatível.&#x20;
* Embora não ofereça os recursos avançados do Btrfs, ele ainda é uma excelente escolha para partições de sistema que não exigem tanta flexibilidade.&#x20;
* O Ext4 também tem suporte a TRIM, que é fundamental para a manutenção do desempenho e da vida útil do dispositivo.

***

```

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
```

* Dado que por algum motivo cósmico gosto de pegar o caminho mais dificil, decidi usar validadores para executar cada configuração (não sei pq fiz, mas funcionou redondo  ¯\\\_(ツ)\_/¯)
* Repare que o /home e /root carregam o btrfs
