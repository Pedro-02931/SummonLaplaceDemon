# CONFIGURANDO UHD 620

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


```
{% endcode %}
