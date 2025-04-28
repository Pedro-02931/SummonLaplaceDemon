# Arquitetura Física e Lógica

### 2.1 Componentes de Hardware e Mapea:

Dado que tenho uma patologia fodida com otimização e documentação de coisas inuteis, decidi focar no mais baixo custo possível em que atravé´s de um hardware minimo, um roteado e um conjunto de sensores consigo criar uma entidade viva fazendo paralelos sobre como a nossa mente funciona:

| **Componente**        | **Função no Sistema**                                           | **Equivalente Cognitivo (Análogo)** |
| --------------------- | --------------------------------------------------------------- | ----------------------------------- |
| Raspberry Pi 4/Zero¹  | Centro de Inferência / LAN Hub / Proc.                          | Córtex Pré-frontal                  |
| QR Code               | Consulta e alteração de estado                                  | Nervos Sensoriais                   |
| "Roteador" Caseiro/4G | Sincronia entre redes e conexão entre sensores internos.        | Sistema Nervoso Periférico          |
| Memória Interna       | Armazenamento Local (Logs, Estados)                             | Hipocampo (Registro de eventos)     |
| Celular/Tablet        | Interface com o Motorista permitindo a exibição do estado atual | Interface Sensório-Motora           |
| Sensores              | Módulo de Integridade Física                                    | Propriocepção                       |

> A escolha entre Pi 4 (mais potente) e Pi Zero (mais leve/barato) foi mais para exemplificação. A ideia é rodar o android ou Linux para execução de tarefas, em que a compilação para o hardware padronizado permitiria a conexão entre tudo conectado, desde o núcleo que é o hardware até o exoesqueleto que são os termostatos e o smartphone .

O Raspberry Pi atua como um ponto de acesso Wi-Fi, criando uma LAN interna para comunicação direta com o qualquer tela que consiga reproduzir o estado do computador de bordo numa tela.

**2.2 Topologia de Rede e Fluxo Cognitivo Interno**

A topologia de rede foca na comunicação local primária e na redundância externa:

{% @mermaid/diagram content="flowchart TD
    subgraph "LAN Interna (Veículo)"
        C[Celular do Motorista] -- Wi-Fi --> B(Raspberry Pi Hub)
    end

    subgraph "Núcleo Cognitivo (Software)"
        style B fill:#f9f,stroke:#333,stroke-width:2px
        B --> QR[QR Code]
        QR[QR Code] --> INFERENCE{Motor de Inferência}
        INFERENCE --> SM[Gerenciador de Estados]
        SM --> HB[Banco de Heurísticas]
        HB --> CQ[Colapso de Qualia/Estado]
        CQ --> B
    end

    B -- "Internet 4G (Redundância)" --> D[(Central de Monitoramento / Backup)]

    linkStyle 0 stroke-width:2px, stroke:blue;
    linkStyle 1 stroke-width:2px, stroke:green;
    linkStyle 2,3,4,5,6 stroke-width:1px, stroke:#333, stroke-dasharray:5 5;
    linkStyle 7 stroke-width:2px, stroke:red, stroke-dasharray:2 2;
" %}

> _Este diagrama refina a topologia inicial, detalhando o fluxo lógico dentro do Raspberry Pi, que opera como o centro cognitivo. A cognição acontece localmente; a internet (via Módulo 4G) é usada para monitoramento(`I`), não para a tomada de decisão, onde tudo deve ser feito pelo QR Code._

**2.3 Ciclo de Estado Cognitivo e Dados do QR Code**

As transições entre estados (magnitudes) são eventos discretos, validados por observadores específicos e pré-condições. O cruzamento entre essas condições garante estados únicos

| **Nome**    | **Magnitude** | **Responsável pela Leitura** | **Função Principal**                    | **Dados modificados**                                           |
| ----------- | ------------- | ---------------------------- | --------------------------------------- | --------------------------------------------------------------- |
| Docas       | 0             | Equipe das docas             | Diagnóstico operacional, calibragem     | Atualiza dados relacionados a sensores e manutenção de veículos |
| Expedição   | 1             | Equipe de Expedição          | Abastecimento, formulário, início ciclo | cruza carga, nota fiscal e garante o abastecimento              |
| Central     | 2             | Motorista                    | Confirmação de viagem/rota              | Confirma formulário, estado dos sensores e aceita a viagem      |
| Restaurante | 3             | Parceiro de Entrega/Final    | Finalização ciclo, ativa nova rota      | Zera tabela e direciona para próxima rota                       |

* **Dados Codificados no QR:** Podem incluir um **Formulário** (preenchido no abastecimento, editável apenas pela equipe de doca - Magnitude 1) e um **Link de Visualização** (somente leitura após confirmação da Magnitude 2).
* **Irreversibilidade:** O sistema é projetado para que, após o colapso final de um ciclo (e.g., Magnitude 3), não haja reversão simples, garantindo a integridade da sequência de eventos. O "Colapso de Qualia" (termo do diagrama interno) representa essa transição significativa e validada de estado.

>
>
> ### **Filosofia do Motor de Inferência**
>
> * Sistema atua como uma **máquina de Turing**, com base em uma fita de estados sequenciais (Parado, Carregado, Em Manutenção, Em Trânsito).
> * A **leitura do QR Code** ativa um observador (`O₁`, `O₂`, etc.), e este define a transição possível.
> * **Caminhão como entidade cognitiva**: Colapsa seu estado com base no observador que o inspeciona.
> * **Comparação com a mente humana**:
>   * A consciência simula o que vai acontecer (ego).
>   * O corpo, na realidade, transforma o ruído branco em experiências (qualias), que são renderizadas com base em sua ordem e quantidade.
>   * Pro QR Code, tanto faz todos os estados possíveis, ele só pode colapsar no anterior e próximo, mas não consegue pensar e tudo.
>   * A duvida existencial não é um dilema exclusivamente humano, mas uma constante cósmica, há apenas ordens de grandezas diferentes, e de acordo com Godel, não há como matematicamente definir o estado consciência, mas fico puto quando penso na vaca da minha ex!
>
> > _"Eu não acredito em Deus, mas se houver um milagre na minha vida, começo a processar o conceito de Deus."_
