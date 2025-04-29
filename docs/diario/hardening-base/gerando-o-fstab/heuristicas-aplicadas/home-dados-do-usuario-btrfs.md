# /home → Dados do usuário (btrfs)

{% code overflow="wrap" %}
```bash
UUID=...   /home   btrfs   defaults,noatime,compress=zstd,commit=60,ssd,space_cache=v2,autodefrag  0 2
```
{% endcode %}

* Mesmos parâmetros da raiz, mas com `commit=60` (menos buffering do que na `/`) → equilíbrio entre segurança de dados e desempenho.

> _Lógica_: snapshots permitem recuperar arquivos apagados, autodefrag mantém acesso rápido a arquivos editados com frequência.
