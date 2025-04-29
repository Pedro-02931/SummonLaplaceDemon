---
icon: '1'
---

# Automatizando Criação

* A ideia aqui é deixar essa tabela universal para todos os dispositivo, onde através de valores relativos, capturo os IDs das partições criadas pós instalação.
*   O objetivo aqui é aplicar de forma granular e automatizada, as melhores configurações para cada partição em relação ao seu uso esperado, onde controlo o que é escrito, na frequência, como, etc, assim otimizando a vida útil do SSD, mesmo que há um custo de processamento.

    > Aplicação de compressão é útil, mas tem o preço de 2%, e quando os siberianos mineradores de BitCoins choram por isso, porém o fato de reduzir escritas no SSD pode extender em quase 40%, então as onças pintudas agradecem!
* Aqui o script coleta os ids das partições, e por cruzamento, define a configuração ideal, usando a partição como chave

{% code overflow="wrap" %}
```bash
get_uuid() {
    blkid -s UUID -o value "$1"
}

DISK="/dev/sda"
    cat <<EOF > /etc/fstab
# /etc/fstab - Gerado automaticamente

UUID=$(get_uuid ${DISK}3)   /               btrfs   defaults,noatime,compress=zstd,commit=120,ssd,space_cache=v2,autodefrag  0 1
UUID=$(get_uuid ${DISK}1)   /boot/efi       vfat    defaults,noatime,uid=0,gid=0,umask=0077,shortname=winnt                 0 1
UUID=$(get_uuid ${DISK}2)   /boot           ext4    defaults,noatime,errors=remount-ro                                     0 1
UUID=$(get_uuid ${DISK}8)   /home           btrfs   defaults,noatime,compress=zstd,commit=60,ssd,space_cache=v2,autodefrag  0 2
UUID=$(get_uuid ${DISK}6)   /usr            ext4    noatime,errors=remount-ro,commit=120                                 0 1
UUID=$(get_uuid ${DISK}4)   /var            ext4    defaults,noatime,data=journal,commit=30                                 0 2
UUID=$(get_uuid ${DISK}5)   /tmp            ext4    defaults,noatime,nosuid,nodev,commit=15                                 0 2
UUID=$(get_uuid ${DISK}7)   none            swap    sw                                                                     0 0
```
{% endcode %}
