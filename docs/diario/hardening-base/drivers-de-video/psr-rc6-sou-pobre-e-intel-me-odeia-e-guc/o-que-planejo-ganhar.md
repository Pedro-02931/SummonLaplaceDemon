# O Que Planejo Ganhar

Apesar do meu note ser um pato manco, decidi tentar extender a vida util dele habilitando configurações e flags em 2 camadas(grub e sysfs), e segue os ganhos esperados

***

### 📊 **Resumo de Ganhos por Configuração**

| Ajuste                      | Ganho estimado de bateria | Impacto na performance | Explicação prática                                                                                              |
| --------------------------- | ------------------------- | ---------------------- | --------------------------------------------------------------------------------------------------------------- |
| `enable_psr=1`              | ↑ até 10%                 | Nenhum                 | PSR (Panel Self Refresh) reduz o uso da GPU quando a tela está parada.                                          |
| `enable_rc6=1`              | ↑ até 10–15%              | Nenhum                 | RC6 coloca a GPU em estados de sono profundo. Quanto mais agressivo o RC6 (6, 6p, 6pp), mais energia economiza. |
| `enable_fbc=1`              | ↑ até 3–5%                | Nenhum                 | Frame Buffer Compression reduz o tráfego entre GPU e RAM.                                                       |
| `enable_guc=2`              | ↑ pequeno (\~2%)          | Leve melhoria          | Move agendamento de tarefas da CPU para o GuC (Graphics µController), melhora eficiência.                       |
| `enable_dc=4` (via GRUB)    | ↑ até 5–7%                | Pode causar flickers   | Deep C-states (DC) desligam partes do pipeline de vídeo em idle.                                                |
| `disable_power_well=0`      | ↑ marginal (\~1–2%)       | Nenhum                 | Mantém blocos desnecessários desligados.                                                                        |
| `gt_min/max_freq_mhz` limit | ↑ variável (5–10%)        | Reduz desempenho pico  | Força a GPU a usar menos frequência, poupando energia em tarefas leves.                                         |
