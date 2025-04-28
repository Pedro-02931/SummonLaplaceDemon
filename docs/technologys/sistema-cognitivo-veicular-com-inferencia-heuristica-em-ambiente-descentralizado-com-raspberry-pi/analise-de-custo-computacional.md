# Análise de Custo Computacional

### Complexidade do Processo

A complexidade computacional mede o desempenho de um sistema em relação à quantidade de recursos (como tempo ou processamento) que ele precisa à medida que a escala aumenta, mas em resumo, segue a comparação:

* **Tradicional (Monitoramento Contínuo): O(n)** Em sistemas tradicionais, o monitoramento contínuo verifica constantemente o estado de todos os elementos do sistema, como sensores, dispositivos ou logs.
  * **O(n)** significa que o tempo ou esforço necessário cresce linearmente à medida que o número de variáveis monitoradas aumenta.
  * Por exemplo, se houver 100 sensores, cada um será verificado continuamente, resultando em 100 operações.
* **Arquitetura Baseada em Eventos/QR: O(1)** Na arquitetura proposta, a abordagem baseada em eventos (como leitura de QR Codes) só processa informações quando um evento relevante ocorre.
  * **O(1)** significa que o tempo ou esforço necessário é constante, independentemente do número de variáveis ou elementos no sistema.
  * Por exemplo, mesmo que existam 100 sensores, o sistema só verifica estados quando um QR Code é lido ou outro evento específico ocorre.

| **Sistema**          | **Média de Processos Simultâneos** | **Custo de CPU (est.)**  | **Dependência Nuvem** |
| -------------------- | ---------------------------------- | ------------------------ | --------------------- |
| Nuvem Centralizada   | 8-10 por caminhão                  | 15-20% do servidor       | Alta (Decisão)        |
| **Sistema Proposto** | **1-2 locais + sync eventual**     | **<5% no Raspberry Pi**¹ | Baixa (Monitoramento) |

> _Estimativa conservadora, carga real provavelmente menor devido à natureza baseada em eventos._

#### **Benefício da Arquitetura Baseada em Eventos**

* **Menor Carga de Processamento:** Em vez de monitorar continuamente, o sistema só realiza verificações quando é acionado por um evento, reduzindo o consumo de recursos.
  * O sistema não processa informações desnecessárias ou redundantes, pois só reage a eventos relevantes. Isso reduz ainda mais o uso de CPU e energia.
* **Eficiência Local:** Todas as decisões críticas são processadas localmente, sem depender de servidores centralizados ou cloud computing para validação contínua.
  * O uso de QR Codes para acionar estados garante que o sistema seja acionado apenas em pontos-chave, como na leitura de um QR pelo motorista ou pela equipe de logística.

### **Modelo Computacional Detalhado das Funções**

#### **Leitura e Processamento Inicial do QR Code:**

* $$T_{QR} = t_{decode} + t_{hash} + t_{validacao_inicial}$$
  * $$t_{decode}$$ **= (Decodificação da imagem/payload):** Tempo necessário para decodificar o QR Code. Depende da qualidade da imagem e do leitor usado. Geralmente, leva de **5 a 15 ms**.
  * $$t_{hash}$$ = **(Geração de hash do payload):** Tempo para criar um hash (uma espécie de "impressão digital") do conteúdo do QR Code. Isso é usado para verificar a integridade ou identificar o QR. Leva cerca de **1 a 5 ms**.
  * $$t_{validacaoInicial}$$ = **(Verificação de formato/assinatura):** Tempo para validar o formato ou assinatura básica do QR Code, garantindo que ele seja legível e confiável. Também leva de **1 a 5 ms**.**(Verificação de formato/assinatura):** Tempo para validar o formato ou assinatura básica do QR Code, garantindo que ele seja legível e confiável. Também leva de **1 a 5 ms**.
  * **Total:** \~7-25 ms

#### **Colapso Heurístico / Inferência de Estado:**

* $$C_{inferencia} = O(1) * H_{local}$$
  * **O(1):** Refere-se à complexidade constante da operação. Isso significa que o tempo necessário para realizar a inferência não aumenta com o tamanho dos dados.
  * $$H_{local}$$ **(Consulta em tabela hash/DB local):** O sistema consulta uma tabela hash ou banco de dados local para verificar o estado atual e inferir o próximo estado. Essa operação é extremamente rápida, com tempo típico de **menos de 5 ms**.

**Transmissão Redundante (Assíncrona):**

* $$T_{upload} = T_{compressao} + (Bytes / Velocidade_{upload}) + Latencia_{rede}$$
* $$T_{compressao}$$**:** Tempo para comprimir os dados antes de enviá-los. Isso reduz o tamanho do payload (dados a serem enviados). Geralmente leva de **5 a 10 ms**.
* $$Bytes / Velocidade_{upload}$$**:** Tempo necessário para enviar os dados, que depende do tamanho do payload (em KB) e da velocidade de upload da rede (como 4G). Para pacotes pequenos, isso varia entre **100 e 500 ms**.
* $$Latencia_{rede}$$: **:** Atraso causado pela rede, que também depende da qualidade da conexão.

> Essa transmissão é **assíncrona**, ou seja, não bloqueia as operações locais do sistema. O sistema continua funcionando enquanto os dados são enviados

**Ciclo de Execução Típico (Diagrama de Sequência):**

{% @mermaid/diagram content="sequenceDiagram
    participant U as Usuário (Motorista/Equipe)
    participant LQR as Leitor QR
    participant RPi as Raspberry Pi (Sistema Local)
    participant COG as Cognição (Motor Inferência)
    participant HMI as Celular (Interface Local)
    participant NET as Rede 4G
    participant CEN as Central (Monitoramento)

    U->>LQR: Escaneia QR Code
    LQR->>RPi: Envia dados do QR
    RPi->>COG: Solicita processamento/inferência (ID, Obs, QR Data)
    COG->>COG: Verifica Precondições (Histórico Local)
    alt Transição Válida
        COG->>RPi: Confirma Novo Estado (S?+?)
        RPi->>HMI: Atualiza Interface (via LAN Wi-Fi)
        RPi-->>NET: Envia Log Criptografado (Assíncrono)
        NET-->>CEN: Monitoramento de Rotas e Carga
    else Transição Inválida
        COG->>RPi: Rejeita Transição / Mantém Estado (S?)
        RPi->>HMI: Notifica Falha/Status (via LAN Wi-Fi)
    end
    HMI->>U: Mostra Estado Atual / Feedback" %}



```
```
