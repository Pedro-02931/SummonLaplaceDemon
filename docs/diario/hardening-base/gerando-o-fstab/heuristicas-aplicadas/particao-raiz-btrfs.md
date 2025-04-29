# / → Partição raiz (btrfs)

{% code overflow="wrap" %}
```bash
UUID=...   /   btrfs   defaults,noatime,compress=zstd,commit=120,ssd,space_cache=v2,autodefrag  0 1
```
{% endcode %}

* **`btrfs`**: Sistema de arquivos moderno com suporte a snapshots, checksums, compressão e balanceamento. Ideal para sistemas dinâmicos.
*   **`compress=zstd`**: Reduz o volume físico de dados escritos (menos desgaste no SSD), com compressão veloz e eficiente&#x20;

    > custo de 2% de uso de CPU, mas a economia de 40% de disco (trade-off gostoso)&#x20;
*   **`commit=120`**: Dados ficam até 2 minutos na RAM antes de ir pro disco → menos I/O → maior vida útil do SSD.

    > Linux com KDE consome apenas 2GB de RAM, então deixar 16 GB livres é que nem transar com a EX, é perigoso, mas a sensação de poder é boa kkkkk
* **`noatime`**: Não atualiza metadados de acesso → menos escrita desnecessária.
* **`ssd`**: Informa ao Btrfs que o disco é SSD → otimiza layout e leitura paralela.
* **`space_cache=v2`**: Acelera a montagem do sistema.
* **`autodefrag`**: Fragmentações pequenas são corrigidas dinamicamente.

> Menos escrita = menos ciclos P/E (program/erase) = SSD vive mais.

***

####
