# alias zero

```bash
alias zero='
    read DISK;
    sudo wipefs -a "$DISK";
    sudo sgdisk --zap-all "$DISK";
    sudo dd if=/dev/zero of="$DISK";
    sudo partprobe "$DISK";
    sleep 2;
    sudo udevadm settle;
'
```

O objetivo aqui é zerar o disco que estou trabalhando em que ele solicita a unidade (mano, é o pai que tá fazendo, e faço `sudo rm -rf / --no-preserve-root` para testar backup, então não preciso de echo me orientando ( ͡\~ ͜ʖ ͡°))

### Explicando comandos

* `read DISK`: Coleta o ponteiro do SSD que quero trabalhar antes de zerá-lo e a RAM registra temporariamente;
* `sudo wipefs -a "$DISK"`: Remove todas as assinaturas de sistemas de arquivo do meu disco;
  * Ele escaneia os primeiros blocos do dispositivo para identificar metadados de sistemas de arquivos como EXT4, NTFS, BTRFS, etc., e os sobrescreve com zeros, eliminando vestígios da estrutura anterior.
  * Ele impacta diretamente os registros da unidade de armazenamento e manipula os primeiros setores, apagando os identificadores do sistema de arquivos.&#x20;
  * No caso de SSDs, o controlador interno pode marcar os blocos como "invalidados", otimizando futuras operações de escrita.
*   `sudo sgdisk --zap-all "$DISK"`: Apaga todas as partições existentes no disco;

    * Atua na tabela de partições GPT, removendo completamente suas entradas.&#x20;

    > Se usado em um disco com MBR, pode resultar na perda de acesso às partições sem a necessidade de formatação explícita.

    * No disco rígido tradicional, isso impacta os setores de **registro de partições** (LBA 0 e LBA 1).&#x20;
    * Em SSDs, os blocos associados à estrutura de partições são regravados, podendo desencadear operações internas de TRIM pelo firmware.
* `sudo dd if=/dev/zero of="$DISK"`: Sobrescreve os primeiros setores do disco com zeros, eliminando vestígios de dados (sim, redundante, mas sou paranoico ¯\\\_(ツ)\_/¯)
  * Funciona como um utilitário de leitura/gravação de baixo nível.&#x20;
  * Ele copia um fluxo de bytes `/dev/zero` (fonte de zeros infinitos) para o disco-alvo.&#x20;
  * O argumento `bs=1M count=1024` indica que ele escreve 1024 blocos de 1 MB.
  * O impacto no hardware depende do tipo de armazenamento:
    * Em **HDDs**, os setores físicos são substituídos por zeros, garantindo que qualquer dado anterior seja irrecuperável por métodos convencionais.
    * Em **SSDs**, o efeito pode ser otimizado pelo controlador interno, que pode interpretar a operação e marcar os blocos como "livres" em vez de realmente gravar zeros em cada célula NAND, acelerando o processo.
* `sudo partprobe "$DISK"`: Força o kernel do sistema a reexaminar as alterações na tabela de partições.
  * O sistema operacional mantém um cache da estrutura de partições e garante que o kernel detecte as mudanças e atualize sua visão do dispositivo.
* `sleep 2`: Garante que todas as operações anteriores tenham tempo para serem concluídas.
* `sudo udevadm settle`: Espera que todos os eventos do subsistema de dispositivos sejam processados, garantindo que as mudanças no disco sejam completamente reconhecidas.
  * Ele escuta notificações do kernel e aguarda até que todas as operações pendentes relacionadas ao disco estejam finalizadas.
  * O comando pode interagir diretamente com o firmware do dispositivo de armazenamento, garantindo que qualquer reorganização interna tenha sido processada antes de permitir novas operações.
