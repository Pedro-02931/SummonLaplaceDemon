# /boot → Kernel/Initramfs (ext4)

```bash
UUID=...   /boot   ext4   defaults,noatime,errors=remount-ro  0 1
```

* **`ext4`**: Sistema confiável, simples e bem testado. Ideal para partições críticas.
* **`errors=remount-ro`**: Se houver falha, monta em modo somente leitura para preservar dados.

> _Lógica_: isolando o boot evita que uma falha na raiz quebre a inicialização.
