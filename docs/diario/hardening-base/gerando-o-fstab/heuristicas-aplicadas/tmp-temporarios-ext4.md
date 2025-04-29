# /tmp → Temporários (ext4)

```bash
UUID=...   /tmp   ext4   defaults,noatime,nosuid,nodev,commit=15  0 2
```

* **`nosuid,nodev`**: Segurança → impede execução de binários ou uso de dispositivos.
* **`commit=15`**: Escrita rápida, dados duram pouco → menor tempo na RAM.

> _Lógica_: temporários isolados e voláteis, com regras de segurança para evitar exploração.
