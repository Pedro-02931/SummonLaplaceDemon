# O Que Planejo Ganhar

Apesar do meu note ser um pato manco, decidi tentar extender a vida util dele habilitando configurações e flags em 2 camadas(grub e sysfs), e segue os ganhos esperados

***

### 📊 **Resumo de Ganhos por Configuração**

| Recurso Ativado             | Impacto na Bateria (%) | Impacto na Saúde Térmica (%) | Observações Técnicas                                                   |
| --------------------------- | ---------------------- | ---------------------------- | ---------------------------------------------------------------------- |
| `enable_psr=1`              | +5–8%                  | +3–5%                        | Tela não redesenha se conteúdo estiver parado (_Panel Self Refresh_)   |
| `enable_rc6=1`              | +8–15%                 | +10%                         | GPU entra em estados de sono profundo (RC6, RC6p, RC6pp)               |
| `enable_guc=2`              | +1–3%                  | +1%                          | Offload de gerenciamento de energia pro GuC (Graphics microcontroller) |
| `enable_fbc=1`              | +4–6%                  | +3%                          | Comprime quadros idênticos na VRAM para economizar energia             |
| `gt_max_freq_mhz=800`       | +7–12%                 | +6–10%                       | Reduz o pico de consumo da GPU evitando uso de _Turbo Boost_           |
| `gt_min_freq_mhz=300`       | —                      | —                            | Mantém o consumo ocioso mínimo padrão                                  |
| `i915.enable_dc=4`          | +2–4%                  | +2%                          | Deep power states para componentes gráficos                            |
| `i915.disable_power_well=0` | +1–2%                  | +1%                          | Mantém domínios de energia desligados quando não utilizados            |

| Categoria                   | Ganho Potencial (%) |
| --------------------------- | ------------------- |
| **Bateria (consumo menor)** | **+15% a +35%**     |
| **Temperatura/saúde geral** | **+10% a +25%**     |
