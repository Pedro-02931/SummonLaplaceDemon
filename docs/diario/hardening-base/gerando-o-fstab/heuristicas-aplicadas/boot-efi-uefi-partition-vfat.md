# /boot/efi → UEFI Partition (vfat)

{% code overflow="wrap" %}
```bash
UUID=...   /boot/efi   vfat   defaults,noatime,uid=0,gid=0,umask=0077,shortname=winnt  0 1
```
{% endcode %}

* **`vfat`**: FAT32 é obrigatório para ESP (EFI System Partition).
* **`umask=0077`**: Permissões restritas → segurança (somente root pode acessar).
* **`shortname=winnt`**: Compatibilidade com nomes curtos estilo Windows.

> _Eletronicamente_: pequena, rara escrita. Mantida simples por padrão UEFI.
