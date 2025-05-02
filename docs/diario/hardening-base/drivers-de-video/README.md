---
icon: high-definition
---

# Drivers de Video

{% code overflow="wrap" %}
```bash
# 1. Corrigir as fontes APT removendo entradas duplicadas
sudo sed -i.bak '/^deb.*main.*/s/ main/ contrib non-free non-free-firmware/' /etc/apt/sources.list
sudo sed -i '/bookworm-backports/d' /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list

# 2. Atualizar e instalar pacotes essenciais
sudo apt update && sudo apt install -y \
  firmware-misc-nonfree \
  intel-media-va-driver \
  i965-va-driver \
  intel-opencl-icd \
  libmfx1 \
  gstreamer1.0-vaapi \
  intel-gpu-tools \
  mesa-utils \
  vulkan-tools

# 3. Instalar drivers Mesa atualizados do backports
sudo apt -t bookworm-backports install -y \
  mesa-vulkan-drivers \
  libgl1-mesa-dri \
  libva-mesa-driver

# 4. Configurar variáveis críticas
echo "export LIBVA_DRIVER_NAME=i965" | sudo tee -a /etc/environment
echo "export VDPAU_DRIVER=va_gl" | sudo tee -a /etc/environment

# 5. Reiniciar serviços gráficos
sudo systemctl restart display-manager

# 6. Verificar instalação
glxinfo | grep "OpenGL renderer"
vainfo
vulkaninfo | grep "GPU id"

# 1. Boot via USB Live (se sistema não iniciar)
# - Use imagem Debian Live com ambiente gráfico
# - Monte partição raiz:
sudo mount /dev/sda3 /mnt

# 2. Remover configurações problemáticas
sudo chroot /mnt  # Acessar sistema danificado

# 3. Reverter drivers gráficos
apt purge -y \
  mesa-vulkan-drivers \
  intel-media-va-driver \
  i965-va-driver \
  intel-opencl-icd

apt install -y --reinstall \
  mesa-va-drivers \
  mesa-vulkan-drivers \
  libgl1-mesa-dri \
  libegl-mesa0

# 4. Remover configurações de risco
rm -f /etc/modprobe.d/i915.conf
sed -i '/LIBVA_DRIVER_NAME/d' /etc/environment
sed -i '/VDPAU_DRIVER/d' /etc/environment

# 5. Forçar versões estáveis
apt install -y \
  mesa-va-drivers=22.3.6-1+deb12u1 \
  mesa-vulkan-drivers=22.3.6-1+deb12u1 \
  libgl1-mesa-dri=22.3.6-1+deb12u1

# 6. Atualizar initramfs
update-initramfs -u -k all

# 7. Reiniciar
reboot# 1. Boot via USB Live (se sistema não iniciar)
# - Use imagem Debian Live com ambiente gráfico
# - Monte partição raiz:
sudo mount /dev/sda3 /mnt

# 2. Remover configurações problemáticas
sudo chroot /mnt  # Acessar sistema danificado

# 3. Reverter drivers gráficos
apt purge -y \
  mesa-vulkan-drivers \
  intel-media-va-driver \
  i965-va-driver \
  intel-opencl-icd

apt install -y --reinstall \
  mesa-va-drivers \
  mesa-vulkan-drivers \
  libgl1-mesa-dri \
  libegl-mesa0

# 4. Remover configurações de risco
rm -f /etc/modprobe.d/i915.conf
sed -i '/LIBVA_DRIVER_NAME/d' /etc/environment
sed -i '/VDPAU_DRIVER/d' /etc/environment

# 5. Forçar versões estáveis
apt install -y \
  mesa-va-drivers=22.3.6-1+deb12u1 \
  mesa-vulkan-drivers=22.3.6-1+deb12u1 \
  libgl1-mesa-dri=22.3.6-1+deb12u1

# 6. Atualizar initramfs
update-initramfs -u -k all

# 7. Reiniciar
reboot

sudo apt install -y libva-utils vulkan-utils intel-gpu-tools

# 2. Verificar aceleração de vídeo VA-API
vainfo  # Agora funcionará

# 3. Configurar driver VA-API correto para Kabylake
echo "export LIBVA_DRIVER_NAME=i965" | sudo tee -a /etc/environment

# 4. Forçar prioridade da GPU Intel no Vulkan
sudo mkdir -p /etc/vulkan/icd.d/
echo '{"file_format_version":"1.0.0","ICD":{"library_path":"/usr/lib/x86_64-linux-gnu/libvulkan_intel.so","api_version":"1.3.261"}}' | sudo tee /etc/vulkan/icd.d/intel_icd.x86_64.json

# 5. Atualizar configuração do driver i915
echo "options i915 enable_guc=2 enable_fbc=1 enable_psr=0" | sudo tee /etc/modprobe.d/i915.conf
sudo update-initramfs -u
echo "deb http://security.debian.org/debian-security bookworm-security main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo nano /etc/tlp.conf
# Ativar recomendações pós-instalação
sudo apt install -y \
  tlp-rdw \
  smartmontools \
  powertop

# Configurar parâmetros de energia
sudo tee -a /etc/tlp.conf <<EOF
CPU_SCALING_GOVERNOR_ON_AC=performance
CPU_SCALING_GOVERNOR_ON_BAT=powersave
ENERGY_PERF_POLICY_ON_AC=performance
EOF

# Aplicar configurações
sudo tlp start
# 1. Habilitar repositórios necessários
sudo sed -i 's/main/main contrib non-free non-free-firmware/' /etc/apt/sources.list
sudo apt update

# 2. Instalar dependências essenciais manualmente
sudo apt install -y \
  hdparm \
  rfkill \
  usbutils \
  ethtool \
  network-manager

# 3. Instalar TLP com recomendações opcionais
sudo apt install -y --no-install-recommends tlp

# 4. Configurar e iniciar o TLP
sudo systemctl enable tlp
sudo systemctl start tlp

# 5. Verificar status
sudo tlp-stat -s
 sudo apt install -y     vulkan-tools   intel-gpu-tools   mesa-utils   libvulkan1   libva-wayland2   libva-drm2
 
 sudo apt install initramfs-tools -y
sudo update-initramfs -u
 
 
 #!/bin/bash

# 1. Criar script de monitoramento condicional
sudo tee /usr/local/bin/intel_gpu_vscode_tuner.sh >/dev/null <<'EOF'
#!/bin/bash

# Valores padrão de segurança
DEFAULT_GPU_FREQ=$(cat /sys/class/drm/card0/gt_max_freq_mhz | awk '{print $1}')
DEFAULT_RC6=$(cat /sys/module/i915/parameters/enable_rc6)
DEFAULT_RC6_MASK=$(cat /sys/module/i915/parameters/enable_rc6_mask)

# Função para aplicar perfomance máxima
apply_perf_profile() {
    echo "manual" > /sys/class/drm/card0/power_dpm_force_performance_level
    echo 1050 > /sys/class/drm/card0/gt_max_freq_mhz
    echo 1 > /sys/module/i915/parameters/enable_rc6
    echo 8 > /sys/module/i915/parameters/enable_rc6_mask
}

# Função para restaurar padrões
restore_defaults() {
    echo "auto" > /sys/class/drm/card0/power_dpm_force_performance_level
    echo $DEFAULT_GPU_FREQ > /sys/class/drm/card0/gt_max_freq_mhz
    echo $DEFAULT_RC6 > /sys/module/i915/parameters/enable_rc6
    echo $DEFAULT_RC6_MASK > /sys/module/i915/parameters/enable_rc6_mask
}

# Loop principal de monitoramento
while true; do
    if pgrep -x "code" >/dev/null; then
        apply_perf_profile
        while pgrep -x "code" >/dev/null; do
            sleep 10
        done
        restore_defaults
    fi
    sleep 5
done
EOF

# 2. Criar serviço systemd
sudo tee /etc/systemd/system/intel-gpu-vscode-tuner.service >/dev/null <<EOF
[Unit]
Description=Dynamic Intel GPU Tuning for VS Code
After=graphical.target

[Service]
ExecStart=/usr/local/bin/intel_gpu_vscode_tuner.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# 3. Configurar permissões e iniciar serviço
sudo chmod +x /usr/local/bin/intel_gpu_vscode_tuner.sh
sudo systemctl daemon-reload
sudo systemctl enable --now intel-gpu-vscode-tuner.service

# 4. Verificar status
systemctl status intel-gpu-vscode-tuner.service --no-pager
```
{% endcode %}
