# Casos de Uso (Detalhes Integrados)

### **Expedição (Magnitude 0 → 1)**

Essa é a **primeira fase** do ciclo, marcada pela preparação inicial do caminhão para o transporte:

* **QR Code é lido pela equipe de doca:** Um QR Code é escaneado pela equipe responsável pela logística. Este código contém um **payload**, ou seja, informações que incluem um formulário editável que contém os campos que devem ser preenchidos sobre a carga.
* **Validação pelo sistema local (Raspberry Pi):** O Raspberry Pi verifica se as **pré-condições do estado Mecânica (Magnitude 0)** estão atendidas. Isso pode incluir conferências como calibração do caminhão e funcionamento dos sensores/termostatus.
* **Colapso para Magnitude 1:** Após validação, o sistema muda de estado para Magnitude 1, que significa que a expedição está pronta.
* **Registro local:** O sistema realiza o hashing do QR Code (gerando uma "impressão digital única") e registra um timestamp (marcação temporal) para garantir rastreamento futuro.
* **LAN Wi-Fi ativada:** A rede local do Raspberry Pi é ativada, permitindo comunicação com o **celular do motorista** para confirmar os próximos passos.
* **Upload redundante agendado:** Os dados são preparados para envio à central via internet, mas isso ocorre de maneira assíncrona e não bloqueia o processo local.

#### **2. Confirmação de Viagem (Magnitude 1 → 2)**

A transição para Magnitude 2 ocorre quando o transporte é oficialmente iniciado:

* **QR Code lido pelo motorista:** O motorista autorizado lê um QR Code específico para esta transição. O payload inclui um **link de visualização (read-only)**, com informações detalhadas sobre a viagem, mas sem permissão de edição.
* **Validação pelo sistema:** O sistema verifica se as pré-condições de **Magnitude 1** foram confirmadas. Por exemplo, pode conferir que o QR da expedição foi lido corretamente e as condições da carga foram atendidas.
* **Colapso para Magnitude 2:** Após validação, o sistema muda de estado para Magnitude 2, indicando que a viagem foi oficialmente iniciada.
* **Registro local:** Assim como na etapa anterior, o sistema armazena um registro local da transição para garantir rastreabilidade.
* **Transmissão de dados:** Os dados redundantes sobre a transição (exemplo: confirmação da viagem) são enviados para a central via conexão 4G, mas de forma não bloqueante.

#### **3. Reentrega / Restaurante (Magnitude 2 → 3)**

Esta é a **fase final do ciclo**, ocorrendo quando a carga chega ao destino:

* **QR Code lido pelo parceiro final/restaurante:** O parceiro final (exemplo: restaurante) escaneia um QR Code. Essa leitura confirma a chegada da carga ao destino.
* **Validação pelo sistema:** O sistema verifica se as pré-condições de **Magnitude 2** estão atendidas. Isso pode incluir a confirmação da viagem pelo motorista e a integridade da carga.
* **Colapso para Magnitude 3:** Após validação, o sistema muda de estado para Magnitude 3, encerrando o ciclo da operação.
* **Registro local:** Um registro adicional é feito, consolidando o fim do ciclo.
* **Ação de próxima rota:** Caso aplicável, o sistema pode acionar lógicas para determinar a próxima rota ou missão, usando interfaces como HMI (Human-Machine Interface) ou comunicação com a central.
* **Modo de espera ou recalibração:** Após o ciclo, o sistema entra em modo de espera ou inicia uma recalibração, preparando-se para o próximo ciclo de operação.
