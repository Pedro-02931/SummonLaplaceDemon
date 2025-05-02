# Segunda Camada

```
# Segunda camada mais agressiva e paranoica
# Edita o GRUB (nano ou vim)
sudo nano /etc/default/grub

# Localiza a linha GRUB_CMDLINE_LINUX e ADICIONE:
i915.enable_psr=1 i915.enable_rc6=1 i915.enable_guc=2 i915.enable_fbc=1 i915.enable_dc=4 i915.disable_power_well=0

# Atualiza o GRUB
sudo update-grub

# Reinicia
sudo reboot now
```
