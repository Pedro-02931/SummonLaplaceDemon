# /var → Dados variáveis (log, cache, pacotes) (ext4)

{% code overflow="wrap" %}
```bash
UUID=...   /var   ext4   defaults,noatime,data=journal,commit=30  0 2
```
{% endcode %}

* **`data=journal`**: Escrita em _journal mode_ → consistência máxima (inclusive dados, não só metadados).
* **`commit=30`**: Escrita mais frequente, já que logs e pacotes mudam bastante.

> _Lógica_: Protege logs e estado de sistemas, mesmo após queda de energia.
