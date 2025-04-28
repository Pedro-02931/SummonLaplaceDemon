---
icon: lightbulb
---

# Sistema Cognitivo Veicular com Inferência Heurística em Ambiente Descentralizado com Raspberry Pi

> Em homenagem a Chico, amigo frio e distante, mas um pai simbólico ~~e sei que não é bem um livro como prometi em um dos nossos primeiros assuntos, mas é uma tecnologia do tipo I de Kardashev~~

Este sistema propõe uma fusão robusta de cognição artificial distribuída na borda com heurísticas de estado eficientes, utilizando QR Codes físicos como gatilhos de transição verificáveis por humanos.&#x20;

O uso do Raspberry Pi como centro cognitivo e hub de comunicação local reduz drasticamente os custos computacionais (O(1)), a dependência de conectividade externa e aumenta a resiliência operacional.&#x20;

A arquitetura assíncrona dedicada e sem dependência de sistemas externos para processamento de decisão, foca em:&#x20;

* Colapso de estado com mínimo custo
* Infraestrutura de hardware reduzida
* Comunicação local primária via LAN
* Upload para a nuvem para rastreio&#x20;

A implementação modular permite escalabilidade, baixo custo de manutenção e integração flexível com dispositivos móveis, sendo ideal para ambientes logísticos onde a conectividade é intermitente e a robustez e a validação local são essenciais.

***

## Calculos de Comparação

Para calcular a economia em termos numéricos e percentuais, precisamos comparar diretamente o consumo de recursos (como tempo de processamento, carga no sistema e uso de dados) entre os dois modelos:&#x20;

* **Sistema tradicional de monitoramento contínuo(atual)**
* **Sistema baseado em eventos/QR Codes(minha proposta)**

***

#### **1. Monitoramento Contínuo: O(n)**

* **Complexidade:**\
  O sistema tradicional verifica todos os sensores ou registros continuamente. Isso implica que, para **n** sensores, são realizadas **n operações** por ciclo.
* **Cenário de Referência:**
  * Imagine que existem **50 sensores** no sistema.
  * Cada sensor é verificado continuamente em um ciclo de 1 segundo (como exemplo).
  * Tempo total de verificação por ciclo = **50 sensores × 1 ms/sensor = 50 ms por ciclo**.
* **Carga em 1 Hora:**\
  Um ciclo ocorre a cada segundo, então há **3600 ciclos por hora**.
  * Consumo total = **50 ms × 3600 ciclos = 180.000 ms (ou 180 segundos)** por hora.

***

#### **2. Sistema Baseado em Eventos/QR Codes: O(1)**

* **Complexidade:**\
  Aqui, o sistema só realiza verificações no momento em que um evento ocorre, como a leitura de um QR Code ou uma atualização de estado.
* **Cenário de Referência:**
  * Supomos **10 leituras de QR Code por hora** (um número realista em muitas operações).
  * Cada leitura leva entre **7-25 ms** para ser processada.
  * Tempo total de processamento por hora = **10 leituras × 25 ms = 250 ms** (considerando o maior tempo possível por leitura).

***

#### **Comparação: Economia em Números**

* **Sistema Tradicional:** Consome **180.000 ms (ou 180 segundos)** por hora.
* **Sistema Baseado em Eventos:** Consome **250 ms por hora**.
* **Diferença em Milissegundos:**\
  180.000 ms - 250 ms = **179.750 ms economizados por hora**.

***

#### **Economia em Porcentagem**

A economia percentual é calculada como:

$$
\text{Economia (%)} = \frac{\text{Tempo Tradicional - Tempo Baseado em Eventos}}{\text{Tempo Tradicional}} \times 100
$$

Substituindo os valores:

$$\text{Economia (%)} = \frac{180.000 - 250}{180.000} \times 100 \approx 99,86%$$\


***

* O **sistema baseado em eventos/QR Codes** reduz drasticamente o consumo de recursos, economizando cerca de **99,86% do tempo de processamento** em comparação ao sistema tradicional de monitoramento contínuo.
* E fiz isso no meu primeiro curso tecnico, quem tá correndo devagar agora?
