# Comparação com Tecnologias Atuais

| **Tecnologia**       | **Computação**           | **Conectividade**    | **Custo** | **Latência** | **Robustez Offline** |
| -------------------- | ------------------------ | -------------------- | --------- | ------------ | -------------------- |
| TMS baseado em nuvem | Centralizada             | 4G/Nuvem (Constante) | Médio     | Média        | Baixa                |
| RFID + Servidor      | Parcialmente distribuído | Requer Infra RFID    | Alto      | Alta         | Média                |
| **Este Modelo**      | **Local + Redundância**  | **LAN (Wi-Fi) + 4G** | **Baixo** | **Baixa**    | **Alta**             |

### **Explicando a Tabela:**

### **TMS baseado em nuvem**:

* **Computação**: Centralizada, ou seja, todo o processamento ocorre em servidores na nuvem ~~e de quebra fodendo a porra do planeta~~.
* **Conectividade**: Depende de uma conexão constante com a internet (4G/nuvem).
* **Custo**: Médio, devido à infraestrutura de servidores e conectividade constante.
* **Latência**: Média, pois há atrasos na comunicação com a nuvem.
* **Robustez Offline**: Baixa, já que o sistema não funciona bem sem internet.
* **RFID + Servidor**:
  * **Computação**: Parcialmente distribuída, com servidores locais e infraestrutura RFID.
  * **Conectividade**: Requer infraestrutura específica para RFID.
  * **Custo**: Alto, devido ao preço dos leitores RFID e tags.
  * **Latência**: Alta, pois a comunicação entre dispositivos pode ser lenta.
  * **Robustez Offline**: Média, já que parte do processamento pode ser local.
* **Meu Modelo (Local + Redundância)**:
  * **Computação**: Local, para lidar com falta de conexão em areas afastadas.
  * **Conectividade**: Usa LAN (Wi-Fi) para comunicação local e 4G para sincronização externa.
  * **Custo**: Baixo, graças ao uso de hardware acessível (como Raspberry Pi e QR Codes).
  * **Latência**: Baixa, pois o processamento ocorre localmente.
  * **Robustez Offline**: Alta, já que o sistema funciona mesmo sem internet.

#### **Vantagens do Seu Modelo**

* **Baixo consumo energético**: O hardware usado (como Raspberry Pi) consome muito menos energia do que servidores ou sistemas RFID.
* **Robustez offline**: O sistema continua operando mesmo sem conexão 4G ou internet, garantindo confiabilidade em ambientes remotos.
* **Processamento local de alta responsividade**: Decisões são tomadas rapidamente, sem depender de servidores externos, reduzindo atrasos.
* **Modularidade e expansão**: Novos estados ou heurísticas podem ser adicionados facilmente via atualizações de software.
* **Custo reduzido**: O uso de hardware comercial off-the-shelf (COTS) como Raspberry Pi e QR Codes minimiza os custos.
