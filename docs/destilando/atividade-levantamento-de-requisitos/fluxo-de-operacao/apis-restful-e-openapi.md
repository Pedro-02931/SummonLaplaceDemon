---
description: >-
  As APIs RESTful são uma forma padrão que diferentes sistemas usam para
  conversar pela internet. O OpenAPI é como um manual que explica como essa
  conversa funciona.
---

# APIs RESTful E OPENAPI

* **APIs RESTful (Representational State Transfer): A "LÍNGUA UNIVERSAL" DA WEB**
  * **O Que É:** Pense nas APIs RESTful como a forma mais comum e organizada para um aplicativo web (como o Dashboard que você usa no navegador) conversar com um servidor. É como se eles seguissem um conjunto de regras bem definidas para fazer "pedidos" (requests) e receber "respostas" (responses) pela internet.
  * **Como Funciona (Passo a Passo):**
    1. **Recursos:** A API RESTful organiza as informações em "recursos" (como se fossem objetos). No seu caso, um "pacote" seria um recurso.
    2. **Verbos HTTP:** Para interagir com esses recursos, a API RESTful usa "verbos" HTTP (como se fossem ações):
       * `GET`: Para pedir informações (por exemplo, "me mostre os dados do pacote X").
       * `POST`: Para enviar novas informações (por exemplo, "crie um novo pacote com esses dados").
       * `PUT`: Para atualizar informações existentes (por exemplo, "mude o status do pacote X para 'entregue'").
       * `DELETE`: Para apagar informações (por exemplo, "remova o pacote X do sistema").
    3. **Endpoints:** Cada recurso tem um "endereço" único chamado "endpoint" (como `/api/v1/pacotes`). Para fazer um pedido, o aplicativo cliente (o Dashboard) envia uma mensagem (request) para esse endpoint usando um dos verbos HTTP. O servidor então processa esse pedido e envia de volta uma resposta (response) com as informações solicitadas ou o resultado da ação.
  * **No Seu Servidor:** O Dashboard usa a API RESTful do seu servidor para pedir informações sobre os pacotes, para criar novos pacotes (se um operador digitar os dados manualmente), para atualizar informações (se um erro for corrigido) e possivelmente para gerar relatórios.
  * **Paralelo Cerebral:** Imagine você pedindo informações para alguém (o Dashboard pedindo para o servidor). Você usa uma linguagem específica (HTTP) para fazer seu pedido (o verbo e o endpoint) e espera uma resposta de volta.
* **OpenAPI: O "MANUAL DE INSTRUÇÕES" DA API**
  * **O Que É:** O OpenAPI (antigamente chamado de Swagger) é como um manual completo que descreve todos os detalhes de uma API RESTful. Ele explica quais são os endpoints disponíveis, quais verbos HTTP podem ser usados em cada endpoint, qual o formato dos dados que podem ser enviados e recebidos, e outras informações importantes para que os desenvolvedores de outros aplicativos (como o Dashboard) saibam exatamente como usar a sua API.
  * **Como Funciona (Passo a Passo):** O OpenAPI usa um formato padronizado (geralmente YAML ou JSON) para descrever a API. Esse arquivo de descrição pode ser usado por ferramentas para gerar automaticamente documentação interativa, código de cliente (para facilitar a vida dos desenvolvedores do Dashboard) e até mesmo validar se a API está funcionando corretamente.
  * **No Seu Servidor:** Ao usar o OpenAPI, você facilita muito a vida dos desenvolvedores que precisam integrar o Dashboard com o seu servidor. Eles podem usar a documentação gerada automaticamente para entender como fazer os pedidos e como os dados são estruturados.
  * **Paralelo Cerebral:** Pense nisso como ter um diagrama detalhado de todas as portas de comunicação do seu cérebro, explicando exatamente o que você precisa "dizer" em cada porta para obter a resposta que você quer.

