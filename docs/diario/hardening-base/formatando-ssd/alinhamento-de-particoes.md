---
icon: '2'
---

# Alinhamento de Partições

* Partições mal alinhadas podem causar um aumento nas operações de leitura e escrita, o que diminui o desempenho e pode aumentar o desgaste do SSD.&#x20;
*   Usando ferramentas como `sgdisk` e garantindo o uso do alinhamento correto (com blocos de 4K ou múltiplos de 4K), você ajuda o SSD a operar de maneira mais eficiente.

    > * Se as partições não estiverem alinhadas corretamente, pode haver **leitura e escrita adicionais**, o que **reduz o desempenho** e **aumenta o desgaste** do SSD.
    > * O SSD pode **ler e gravar dados diretamente nos blocos de memória**, evitando a necessidade de realizar múltiplos acessos para cada operação de leitura ou escrita.
    > * O alinhamento correto minimiza a quantidade de operações de escrita e **ajuda a distribuir o uso da célula de memória de forma mais eficiente**.
* Quando o alinhamento das partições é feito corretamente, o SSD pode gerenciar os dados de maneira otimizada, principalmente no "garbage collector".

***

```
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

```

#### Explicação Técnica

* **sgdisk**: Esta ferramenta é usada para manipular tabelas de partições GUID (GPT). No exemplo, `sgdisk` é utilizado para criar novas partições no disco especificado, definindo o tipo de partição e atribuindo um nome a ela. Isso é essencial para a organização correta do espaço em disco.
* **partprobe**: Após a criação ou modificação das partições, `partprobe` é chamado para notificar o kernel do Linux sobre as mudanças feitas na tabela de partições. Isso garante que o sistema operacional reconheça e utilize as novas partições sem a necessidade de reiniciar.
* **udevadm settle**: Este comando aguarda até que todos os eventos de udev sejam processados após a notificação de mudanças nas partições. Isso assegura que o sistema esteja ciente e que todos os dispositivos estejam em um estado estável antes de continuar com outras operações.
