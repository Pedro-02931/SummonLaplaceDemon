# Primeira Camada

**� RESUMO TÉCNICO (O QUE ESSAS PORRAS SIGNIFICAM)**

1. **PSR (Panel Self Refresh)**
   * **O que faz?** Economiza energia quando a tela tá parada (útil pra ver porno/codar).
   * **Configuramos:** `enable_psr=1` (ligado).
2. **RC6 (Render C-State 6)**
   * **O que faz?** Coloca a GPU em sono profundo quando não tá em uso.
   * **Configuramos:** `enable_rc6=1` (ligado).
3. **GuC (Graphics microController)**
   * **O que faz?** Um firmware que ajuda a GPU a não ser tão inútil.
   * **Configuramos:** `enable_guc=2` (modo equilibrado).
4. **Frequências da GPU**
   * **Mínima (300 MHz):** Economiza bateria quando tá parado.
   * **Máxima (800 MHz):** Evita que esquente muito (já que 1000 MHz é demais pra essa batata).

***

#### **✅ O QUE DEU CERTO**

* **Duas camadas de configuração funcionaram:**
  1. **`sysfsutils`** (configuração persistente).
  2. **GRUB** (opções de boot pra garantir).
* **Resultados esperados:**
  * Bateria dura mais (PSR + RC6).
  * Performance estável sem superaquecer (frequência limitada a 800 MHz).
  * Menos travamentos (GuC ativo).

***

#### **🛠️ COMO TESTAR SE TÁ TUDO OK**

```bash
# PSR, RC6(Sou Pobre e Intel Me Odeia) e GuC
# Instala o pacote (se não tiver)
sudo apt install sysfsutils -y

# Cria o arquivo de configuração
sudo tee /etc/sysfs.conf <<'EOF'
# Configurações i915 para economia de energia
module/i915/enable_psr = 1
module/i915/enable_rc6 = 1
module/i915/enable_guc = 2
module/i915/enable_fbc = 1

# Frequências GPU (UHD 620)
class/drm/card0/gt_min_freq_mhz = 300
# Aqui decidi limitar para um valor abaixo do overclock desse fusca
class/drm/card0/gt_max_freq_mhz = 800 
EOF

# Reinicia o serviço
sudo systemctl restart sysfsutils
```
