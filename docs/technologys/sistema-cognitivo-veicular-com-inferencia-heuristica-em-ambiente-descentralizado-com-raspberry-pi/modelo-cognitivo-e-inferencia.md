# Modelo Cognitivo e Inferência

### **3.1 Representação Matemática e Lógica de Transição**

> Se você está se perguntando que porra essa runa satânica quer dizer, saiba que isso é mais uma representação para autistas sem amor materno como eu entender, então pode pular se se sentir inseguro em relação a inteligência.

Os estados são discretos e as transições são determinísticas, baseadas em regras, ou seja, elas descrevem o comportamento de um sistema cognitivo, onde os estados (as situações ou condições atuais do sistema) mudam de acordo com observações e regras pré-estabelecidas, em que ao invés de tentar entender todas as possibilidades, arrasto a entropia para resultados definiveis.

> É um campo tipo a gravidade, mas ao invés de arrastar o pequeno pro grande, arrasta o desconhecido pro conhecido, em que a contande de aglutinação são regras relacionais baseadas em Bayes. Isso mesmo, a consciência é apenas um motor um bayesiano que chuta o que vai acontecer, e as emoções são valores escalares entre o que você espera e acontece!

&#x20;Aqui, o objetivo é criar uma lógica determinística, ou seja, onde as transições entre estados são completamente definidas por condições claras e imutáveis.

$$
S(t) = f(Oᵢ, H, C)
$$

#### **O que cada elemento significa:**

1. **S(t): Estado no tempo t: R**epresenta a condição atual do sistema em um momento específico. Por exemplo, "parado", "em trânsito", "em manutenção".
2. **Oᵢ: Observador i:** Refere-se ao agente que está monitorando ou gerando dados para o sistema (por exemplo, termostatos, rastreador e outros que coletam informações).
3. **H: Histórico confirmado:** É o conjunto de eventos ou estados anteriores que já foram validados e armazenados pelo sistema (em trânsito só pode ir depois de abastecido e zerado só depois de ter vindo de viagem).
4. **C: Condições lógicas/heurísticas** São as regras ou critérios que determinam como o sistema deve interpretar os dados e tomar decisões (em nenhum momento zerado vem antes de em transito, por exemplo).

Em termos simples, a fórmula indica que o estado atual (**S(t)**) é uma função que depende de três componentes principais: os observadores ativos (**Oᵢ**), os dados validados do passado (**H**) e as regras lógicas (**C**) que guiam o sistema.

***

A inferência ou "colapso de estado" acontece quando o sistema valida que um novo estado pode ser adotado. A regra para isso é:

$$
Precondicoes(Sₙ) ⊆ H ⇒ Sₙ₊₁
$$



**Explicação:**

* **Precondições(Sₙ)**: Requisitos mínimos necessários para um estado **Sₙ**. Por exemplo, para o estado "em trânsito", talvez seja necessário que o histórico confirme que a carga foi carregada.
* **⊆ H**: Significa que as precondições devem estar completamente inclusas no histórico confirmado (ou seja, o sistema valida que todos os eventos necessários já ocorreram).
* **Sₙ₊₁ é colapsável**: Uma vez que os requisitos estão atendidos, o sistema pode "colapsar" ou consolidar o novo estado **Sₙ₊₁**, avançando de forma irreversível para ele.

***

Uma implementação concreta da lógica de validação pode ser:

{% code overflow="wrap" %}
```python
# Função de validação de transição (exemplo)
def transicao_validada(observador_atual, estado_atual, historico):
    estado_anterior_requerido = precondicoes[estado_atual]['estado_anterior']
    observadores_validos = precondicoes[estado_atual]['observadores']
    
    # Verifica se o estado anterior necessário está confirmado no histórico
    estado_anterior_confirmado = any(log['estado'] == estado_anterior_requerido for log in historico)
    
    return estado_anterior_confirmado and (observador_atual in observadores_validos)
```
{% endcode %}

Onde a função `transicao_validada` verifica se a transição de um estado atual para um próximo estado é válida, com base em certas condições pré-estabelecidas. Aqui está o passo a passo:

1.  **Parâmetros da Função:**

    * `observador_atual`: Representa o agente que está lendo o QR code.

    > No caso, isso poderia ser feito pelo login cadastrado no smartphone do usario que lê.

    * `estado_atual`: O estado atual do sistema (por exemplo, "parado", "em trânsito").

    > Qualquer usuario que não pertença a transição pode ler para fins de consulta, sem colapsar o estado do caminhão.

    * `historico`: É uma lista contendo registros de eventos ou estados anteriores confirmados.

    > O equivalente ao ego do caminhão.
2. **Pré-condições por Estado:**
   * A variável `precondicoes` é a tabela de cruzamentos que contém informações sobre quais pré-requisitos cada estado necessita para ser validado. Cada estado possui:
     * Um `estado_anterior` que deve estar confirmado no histórico na coluna ordem de magnitude.
     * Uma lista de `observadores` permitidos para validar a transição, onde a próxima magnitude altera o estado do caminhão.
3. **Verificação do Estado Anterior no Histórico:**
   * A função usa uma verificação (`any()`) para garantir que o estado anterior necessário esteja presente no histórico. O histórico armazena registros de estados passados, e a verificação garante que a transição só ocorra se o estado anterior requerido foi efetivamente confirmado.
4. **Validação do Observador:**
   * A função também verifica se o `observador_atual` pertence à lista de `observadores_validos` permitidos para validar aquela transição específica.
5. **Retorno da Função:**
   * A transição é validada apenas se:
     * O estado anterior necessário foi confirmado no histórico (`estado_anterior_confirmado == True`).
     * O observador atual está na lista de observadores válidos.

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
