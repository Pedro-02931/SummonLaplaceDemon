---
icon: wrench
---

# Métodos e Funcionalidades

{% @mermaid/diagram content="classDiagram
    class Servidor {
        +ouvirRequisicoes(protocolo: string, endpoint: string): void
        +validarDadosPacote(codigo: string): Pacote
        +sugerirDestino(dadosPacote: Pacote): Setor
        +processarFeedback(erro: boolean, dadosCorrigidos: Pacote): void
        +atualizarModeloIA(erro: boolean, exemplo: Pacote): void
        +armazenarDados(dadosPacote: Pacote): string // Retorna ID do pacote
        +consultarPedidos(query: object): Collection<Pedido>
        +gerenciarSeguranca(autenticacao: Credencial): Sessao
        +interfaces(credencial: Credencial): Collection<APIEndpoint>
        +gerarEmbedding(texto: string, modelo: string): Vetor
        +transmitirEmbedding(vetor: Vetor, destino: string, protocolo: string): void
    }

    class Coletor {
        +autenticar(credencial: Credencial): Sessao
        +lerCodigoBarras(): string
        +baixarDadosPacote(codigo: string, endpoint: string): Pacote
        +enviarFeedbackServidor(correto: boolean, dadosCorretos: Pacote, endpoint: string): void
    }

    class Dashboard {
        +autenticar(credencial: Credencial): Sessao
        +buscarPedido(consulta: string, endpoint: string): Collection<Pedido>
        +filtrarPedidos(filtro: object, endpoint: string): Collection<Pedido>
        +baixarEmbeddings(APIservidor: string, modelo: string): ArquivoVetor
        +consultarChatIA(heuristica: string, embedding: Vetor, modelo: string): RespostaChat
        +gerarRelatorioAutomatico(formato: string, filtros: object): ArquivoRelatorio
    }

    Servidor --> Coletor : Retorna Dados do Pacote (JSON, Protocol Buffers)
    Servidor --> Dashboard : Disponibiliza Informações (GraphQL, REST)
    Coletor --> Servidor : Envia Feedback de Correção (gRPC, MQTT)
    Dashboard --> Servidor : Consulta e Filtra Pedidos (REST, gRPC)
    Dashboard --> Servidor : Baixa Embeddings do Servidor (HTTP)
    Servidor --> Dashboard : Transmite Embeddings (WebSockets, HTTP Streaming)
    Dashboard --> ChatIA : Usa Embeddings Localmente (Consulta Vetorial)
" %}



**Metodo de Treinamento (Servidor)**

{% @mermaid/diagram content="graph TD

    %% Entrada dos Dados
    Pacote["Pacote Recebido"] -->|"Serializado e Enfileirado"| Mensageria["Fila de Mensagens (Kafka/RabbitMQ)"]
    Mensageria -->|"Consumido por Worker"| PreProcessamento["Módulo de Pré-Processamento"]
    PreProcessamento -->|"Extração de Features"| Vetorizacao["Módulo de Vetorização (TF-IDF, Word2Vec, Doc2Vec)"]
    Vetorizacao -->|"Alimentando Modelo"| ModeloInferencia["Modelo de Inferência (RNN/Transformer)"]
    ModeloInferencia -->|"Predição do Destino"| DestinoSugerido["Destino Sugerido"]
    ModeloInferencia -.->|"Registro da Predição e Contexto"| BancoDadosInferencias[["Banco de Dados de Inferências"]]

    %% Confirmação ou Correção
    DestinoSugerido -->|"Feedback Positivo"| SinalFeedbackPositivo["Sinal de Feedback Positivo"]
    DestinoSugerido -->|"Feedback Negativo (Correção Manual)"| SinalFeedbackNegativo["Sinal de Feedback Negativo"]
    SinalFeedbackNegativo -->|"Dados Corrigidos"| BancoErros[["Banco de Dados de Erros e Correções"]]
    BancoErros -->|"Realimenta para Treino"| PreProcessamento

    %% Treinamento Contínuo
    BancoDadosInferencias -->|"Lote de Dados"| Otimizador["Otimizador do Modelo (Adam, SGD)"]
    Otimizador -->|"Atualiza Pesos"| ModeloInferencia

    %% Conversão para Embeddings e Transferência para Dashboard
    BancoDadosInferencias -->|"Dados Textuais"| ProcessadorEmbeddings["Conversão para Embeddings (Sentence Transformers)"]
    ProcessadorEmbeddings -->|"Geração de Arquivo Vetorial"| EmbeddingArquivo["Arquivo de Embeddings (formato FAISS, Annoy)"]
    EmbeddingArquivo -->|"Publicado em Endpoint"| ServidorAPI["API do Servidor para Embeddings"]
    ServidorAPI -->|"Baixado pelo Dashboard"| DashboardNotebook["Dashboard no Notebook"]

    %% Processamento Local no Notebook
    DashboardNotebook -->|"Carrega Embeddings Localmente"| MotorLLM["LLM Local no Notebook (ex: Llama, Mistral)"]
    MotorLLM -->|"Utiliza Mecanismo de Busca Semântica"| ChatIA["Chat LLM Integrado no Dashboard"]
    MotorLLM -->|"Geração de Insights e Sumarizações"| Relatorio["Relatório Inteligente"]
" %}
