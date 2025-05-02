# Page 3

```
#!/bin/bash

# Exporta a variável para evitar prompts interativos do APT
export DEBIAN_FRONTEND=noninteractive

echo "INFO: Configurando repositórios APT..."
# 1. Configurar repositórios e atualizar
sudo sed -i.bak "s/main/main contrib non-free non-free-firmware/" /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list
sudo -E apt update -yq
sudo -E apt full-upgrade -yq

echo "INFO: Instalando pacotes essenciais para GPU Intel e utilitários..."
# 2. Instalar componentes essenciais (usando -E para preservar DEBIAN_FRONTEND)
sudo -E apt install -yq --no-install-recommends \
    intel-media-va-driver i965-va-driver vulkan-tools intel-gpu-tools \
    mesa-utils libva-drm2 libva-wayland2 libvulkan1 gstreamer1.0-vaapi \
    libmfx1 intel-opencl-icd linux-firmware libva-utils \
    hdparm usbutils ethtool network-manager tlp

echo "INFO: Configurando opções do driver i915..."
# 3. Configurar driver i915
sudo mkdir -p /etc/modprobe.d
echo "options i915 enable_guc=3 enable_fbc=1 enable_psr=0 enable_dc=4 enable_ppgtt=3" | sudo tee /etc/modprobe.d/i915.conf
echo "options i915 enable_rc6=7 fastboot=1" | sudo tee -a /etc/modprobe.d/i915.conf
sudo update-initramfs -u

echo "INFO: Criando diretório e script de ambiente para VS Code..."
# 4. Ambiente de performance para VS Code
sudo mkdir -p /opt/vscode-env
# Tenta usar o usuário logado, pode precisar de ajuste se $USER for root
sudo chown "$(logname)":"$(logname)" /opt/vscode-env
sudo tee /opt/vscode-env/gpu-tunning.sh > /dev/null <<'ENVEOF'
export ANV_QUEUE_THREAD_DISABLE=1
export INTEL_DEBUG="noirc,nofbc,notrace,nohuc"
export MESA_GLSL_CACHE_MAX_SIZE="512MB"
export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/intel_icd.x86_64.json"
# Condicionais para Wayland e OpenVINO
[ -n "$WAYLAND_DISPLAY" ] && export DXVK_ASYNC=1 DXVK_HUD="compiler" DXVK_STATE_CACHE_PATH="$HOME/.local/share/dxvk-cache"
[ -f /opt/intel/openvino_2023/setupvars.sh ] && source /opt/intel/openvino_2023/setupvars.sh && export TF_ENABLE_ONEDNN_OPTS=1 OPENVINO_VERBOSE=1
ENVEOF
sudo chmod +x /opt/vscode-env/gpu-tunning.sh

echo "INFO: Criando wrapper para VS Code..."
# 5. Wrapper do VSCode
sudo tee /usr/local/bin/code > /dev/null <<'VSCODEEOF'
#!/bin/bash
# Carregar variáveis específicas antes de executar o VS Code
source /opt/vscode-env/gpu-tunning.sh
# Executa o binário original do VS Code com os argumentos recebidos
exec /usr/bin/code "$@"
VSCODEEOF
sudo chmod +x /usr/local/bin/code

echo "INFO: Modificando atalho do VS Code (.desktop)..."
# 6. Modificar o .desktop file para usar o wrapper
DESKTOP_FILE="/usr/share/applications/code.desktop"
if sudo test -f "$DESKTOP_FILE"; then # Verifica existência com sudo
    sudo cp "$DESKTOP_FILE" "$DESKTOP_FILE.bak"
    sudo sed -i 's|^Exec=/usr/bin/code|Exec=/usr/local/bin/code|g' "$DESKTOP_FILE"
else
    echo "AVISO: Arquivo $DESKTOP_FILE não encontrado. Pulando modificação do atalho."
fi

echo "INFO: Baixando e instalando OpenVINO..."
# 7. Instalar OpenVINO via .deb
OPENVINO_DEB_URL="https://storage.openvinotoolkit.org/repositories/openvino/packages/2023.1.0/linux/l_openvino_toolkit_debian12_2023.1.0.12185.47b736f56ed_amd64.deb"
OPENVINO_DEB_PATH="/tmp/openvino_install.deb"
# wget não precisa de sudo geralmente
wget -qO "$OPENVINO_DEB_PATH" "$OPENVINO_DEB_URL"
# Instalar dependências primeiro (usando -E)
sudo -E apt install -yq --no-install-recommends libtbb-dev
# Instalar o pacote .deb
sudo dpkg -i "$OPENVINO_DEB_PATH"
# Tentar corrigir dependências quebradas se o dpkg falhar (usando -E)
sudo -E apt --fix-broken install -yq
# Remover o .deb baixado (precisa de sudo se /tmp for restrito ou wget rodou como root)
sudo rm -f "$OPENVINO_DEB_PATH"
# Adicionar setupvars ao bashrc para todos os usuários (novos shells)
echo "source /opt/intel/openvino_2023/setupvars.sh" | sudo tee -a /etc/bash.bashrc

echo "INFO: Criando serviço systemd para tuning dinâmico da GPU..."
# 8. Serviço de tuning dinâmico da GPU para VS Code
sudo tee /etc/systemd/system/intel-gpu-vscode-tuner.service > /dev/null <<'SERVICEEOF'
[Unit]
Description=Dynamic Intel GPU Tuning for VS Code
After=graphical.target

[Service]
ExecStart=/bin/bash -c '\
  default_freq_mhz=$(cat /sys/class/drm/card0/gt_max_freq_mhz 2>/dev/null || echo 0); \
  while sleep 5; do \
    if pgrep -x code >/dev/null; then \
      if [ -w /sys/class/drm/card0/power_dpm_force_performance_level ] && [ -w /sys/class/drm/card0/gt_max_freq_mhz ]; then \
        current_level=$(cat /sys/class/drm/card0/power_dpm_force_performance_level); \
        if [ "$current_level" != "manual" ]; then \
           echo manual > /sys/class/drm/card0/power_dpm_force_performance_level; \
           echo 1050 > /sys/class/drm/card0/gt_max_freq_mhz; \
           echo "INFO (Tuner Service): VS Code detected, applying performance profile."; \
        fi; \
        # Mantém o loop interno enquanto o VSCode estiver rodando
        while pgrep -x code >/dev/null; do sleep 10; done; \
        # Restaura quando VSCode fecha
        echo auto > /sys/class/drm/card0/power_dpm_force_performance_level; \
        if [ "$default_freq_mhz" -gt 0 ]; then echo "$default_freq_mhz" > /sys/class/drm/card0/gt_max_freq_mhz; fi; \
        echo "INFO (Tuner Service): VS Code closed, restoring default profile."; \
      else \
        echo "WARN (Tuner Service): Cannot write to GPU sysfs files. Skipping tuning."; \
        sleep 30; \
      fi; \
    fi; \
  done'
Restart=always
User=root
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=multi-user.target
SERVICEEOF

echo "INFO: Recarregando systemd e habilitando o serviço de tuning..."
# 9. Recarregar systemd, habilitar e iniciar o serviço
sudo systemctl daemon-reload
sudo systemctl enable --now intel-gpu-vscode-tuner.service

echo "INFO: Atualizando cache de bibliotecas..."
# 10. Atualizar cache ld
sudo ldconfig

echo "INFO: Configurando variáveis de ambiente globais..."
# 11. Configurar variáveis de ambiente em /etc/environment
echo "export LIBVA_DRIVER_NAME=i965" | sudo tee -a /etc/environment > /dev/null
echo "export VDPAU_DRIVER=va_gl" | sudo tee -a /etc/environment > /dev/null
echo "export MESA_VK_WSI_PRESENT_MODE=immediate" | sudo tee -a /etc/environment > /dev/null

echo "INFO: Executando verificações finais..."
# 12. Verificações (erros são redirecionados para /dev/null para não poluir a saída)
if command -v vainfo &> /dev/null; then
    echo "--- Verificação VA-API ---"
    sudo vainfo 2>/dev/null | grep -E "VAProfileHEVC|VAProfileH264|Driver version"
else
    echo "AVISO: Comando 'vainfo' não encontrado. Pulando verificação VA-API."
fi

if command -v vulkaninfo &> /dev/null; then
    echo "--- Verificação Vulkan ---"
    sudo vulkaninfo --summary 2>/dev/null | grep -E "GPU id|apiVersion|driverName"
else
    echo "AVISO: Comando 'vulkaninfo' não encontrado. Pulando verificação Vulkan."
fi

if command -v intel_gpu_top &> /dev/null; then
    echo "--- Verificação intel-gpu-tools ---"
    sudo intel_gpu_top -V 2>/dev/null
else
    echo "AVISO: Comando 'intel_gpu_top' não encontrado. Pulando verificação."
fi

echo "-----------------------------------------------------"
echo "Configuração concluída com sucesso!"
echo "É ALTAMENTE RECOMENDADO reiniciar o sistema para que todas as alterações (kernel modules, environment) tenham efeito."
echo "-----------------------------------------------------"

# Fim do script
```
