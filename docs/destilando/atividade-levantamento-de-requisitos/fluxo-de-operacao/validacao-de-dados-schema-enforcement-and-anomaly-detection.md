---
description: >-
  Assim que o código de barras lido chega ao  servidor, a primeira coisa que ele
  faz é tentar verificar se essa informação faz sentido e se encaixa no que ele
  já sabe.
---

# VALIDAÇÃO DE DADOS (SCHEMA ENFORCEMENT AND ANOMALY DETECTION)

* **Explicação Detalhada:** No momento em que o Coletor lê um código de barras, o servidor age como se estivesse consultando sua memória de longo prazo (o datastore, que pode ser um sistema distribuído como Cassandra ou CockroachDB, capaz de armazenar uma grande quantidade de dados em vários computadores ao mesmo tempo). Ele verifica se já existe alguma informação sobre esse pacote no banco de dados.
  * **Cassandra e CockroachDB:** São bancos de dados NoSQL (que não seguem a estrutura tradicional de tabelas) projetados para serem altamente escaláveis e resilientes, capazes de lidar com grandes volumes de dados distribuídos em vários servidores.
* **Paralelo Cerebral:** Essa consulta à memória de longo prazo é como você reconhecer um objeto ou uma pessoa que já viu antes.
* **Paralelo HPC:** Usar um cluster distribuído permite que a busca pelos dados seja feita de forma muito rápida, aproveitando o poder de vários computadores trabalhando juntos.
*   **Implementação (Conceitual):**

    {% code overflow="wrap" %}
    ```mongodb
    \documentclass{article}
    \usepackage{amsmath}
    \begin{document}
    \section*{Validação de Dados (Pseudocódigo)}
    \textbf{Ao receber leitura do Coletor:}
    \begin{enumerate}
        \item Consultar Banco de Dados (Cassandra/CockroachDB) com o código de barras.
        \item \textbf{Se} registro encontrado:
            \begin{itemize}
                \item Prosseguir para a próxima etapa (Inferência).
            \end{itemize}
        \item \textbf{Senão} (registro não encontrado):
            \begin{itemize}
                \item Criar novo objeto "Pacote".
                \item Aplicar esquema de validação (JSON Schema/Protocol Buffers) para os dados recebidos.
                    \begin{itemize}
                        \item \textbf{Se} dados inválidos:
                            \begin{itemize}
                                \item Rejeitar requisição e retornar erro ao Coletor.
                            \end{itemize}
                        \item \textbf{Senão}:
                            \begin{itemize}
                                \item Executar algoritmo de inferência inicial (Random Forest) para sugerir setor de destino.
                                \item Definir TTL adaptativo para revisão futura (se necessário).
                                \item Prosseguir para a próxima etapa (Inferência).
                            \end{itemize}
                    \end{itemize}
            \end{itemize}
    \end{enumerate}
    \section*{Esquemas de Validação (Exemplos)}
    \textbf{JSON Schema (Amostra):}
    \begin{verbatim}
    {
      "type": "object",
      "properties": {
        "codigo_barras": { "type": "string" },
        "peso": { "type": "number" },
        "dimensoes": {
          "type": "object",
          "properties": {
            "altura": { "type": "number" },
            "largura": { "type": "number" },
            "profundidade": { "type": "number" }
          },
          "required": ["altura", "largura", "profundidade"]
        }
      },
      "required": ["codigo_barras", "peso", "dimensoes"]
    }
    \end{verbatim}
    \textbf{Protocol Buffers (Amostra):}
    \begin{verbatim}
    syntax = "proto3";
    message Pacote {
      string codigo_barras = 1;
      float peso = 2;
      message Dimensao {
        float altura = 1;
        float largura = 2;
        float profundidade = 3;
      }
      Dimensao dimensao = 3;
    }
    \end{verbatim}
    \end{document}
    ```
    {% endcode %}
* **Fluxograma (Paralelo Mental):**

{% @mermaid/diagram content="graph TD
    A["Leitura do Coletor (Input Sensor)"] --> B{"Pacote Já Existe no DB?"}
    B -- Sim --> C["Prosseguir para Inferência"]
    B -- Não --> D["Criar Novo Pacote"]
    D --> E{"Validar Dados (JSON Schema/ProtoBufs)?"}
    E -- Inválido --> F["Rejeitar Requisição/Erro"]
    E -- Válido --> G["Inferência Inicial (Random Forest)"]
    G --> H["Definir TTL Adaptativo"]
    H --> C
" %}

* **Paralelo Mental:** A verificação da existência do pacote é como acessar uma memória já existente. A aplicação do esquema de validação é análoga aos filtros sensoriais do seu cérebro, que descartam informações que não fazem sentido ou estão fora do padrão esperado.
