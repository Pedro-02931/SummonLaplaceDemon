---
description: >-
  Para garantir que apenas pessoas e sistemas autorizados possam acessar os
  dados e funcionalidades do seu servidor, são usados mecanismos de segurança
  robustos.
---

# OAUTH 2.0 E JWT

* **OAuth 2.0: O "PORTEIRO ELETRÔNICO" PARA APLICATIVOS**
  * **O Que É:** O OAuth 2.0 é um sistema que permite que um aplicativo (como o Dashboard) acesse informações ou execute ações em outro serviço (o seu servidor) em nome de um usuário, sem precisar que o aplicativo tenha acesso direto à senha desse usuário. É como um porteiro eletrônico que verifica se o aplicativo tem permissão para entrar.
  * **Como Funciona (Passo a Passo):**
    1. **Pedido de Autorização:** Quando o Dashboard quer acessar os dados do servidor em nome de um usuário, ele pede permissão para esse usuário.
    2. **Concessão da Permissão:** O usuário (se estiver logado no servidor ou em algum sistema que pode autorizar o acesso) concede a permissão para o Dashboard.
    3. **Recebimento do Token:** O Dashboard recebe um "token" (uma espécie de chave de acesso temporária) do servidor.
    4. **Acesso com o Token:** Para acessar os dados do usuário, o Dashboard usa esse token nas suas requisições para o servidor. O servidor verifica o token e, se ele for válido, permite o acesso.
  * **No Seu Servidor:** O OAuth 2.0 garante que apenas usuários autorizados (que fizeram login no Dashboard e concederam permissão) possam acessar e manipular os dados dos pacotes.
  * **Paralelo Cerebral:** Imagine diferentes áreas do seu cérebro (aplicativos). Para uma área acessar a informação de outra, ela precisa de uma "autorização" (token) do "porteiro" (sistema de autenticação) que garante que ela tem permissão para fazer isso.
* **JWT (JSON Web Token): O "CARTÃO DE IDENTIFICAÇÃO DIGITAL"**
  * **O Que É:** O JWT é um formato seguro para transmitir informações entre o cliente (Dashboard) e o servidor. Ele funciona como um cartão de identificação digital que o servidor pode verificar para garantir que a requisição é legítima e veio de um cliente autorizado.
  * **Como Funciona (Passo a Passo):** O JWT é um pequeno pedaço de informação codificado em formato JSON. Ele contém informações sobre o usuário, quando o token foi criado, quando ele expira e uma assinatura digital para garantir que ele não foi adulterado. Quando o Dashboard faz um pedido para o servidor, ele envia esse token junto. O servidor verifica a assinatura e, se tudo estiver certo, sabe que pode confiar na requisição.
  * **No Seu Servidor:** O JWT é frequentemente usado em conjunto com o OAuth 2.0 para gerenciar a autenticação e autorização das requisições do Dashboard.
  * **Paralelo Cerebral:** Pense nisso como um passe que o Dashboard precisa mostrar para o seu cérebro (servidor) cada vez que ele quer acessar alguma área protegida. O passe tem informações que comprovam a identidade e as permissões do Dashboard.
