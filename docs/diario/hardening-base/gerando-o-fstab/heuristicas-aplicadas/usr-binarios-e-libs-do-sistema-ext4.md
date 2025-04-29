# /usr → Binários e libs do sistema (ext4)

{% code overflow="wrap" %}
```bash
UUID=...   /usr   ext4   noatime,errors=remount-ro,commit=120  0 1
```
{% endcode %}

* **`commit=120`**: Poucas mudanças mesmo quando gravável → menos desgaste.

> _Lógica_: Reforça imutabilidade da base do sistema. Ideal para segurança e contenção de ataques.
