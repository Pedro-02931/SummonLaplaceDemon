# Cálculo da Soma Ponderada

Cada entrada ( $$x_i$$ ) é multiplicada por um peso ( $$w_i$$ ) e somada ao viés ( b ):

$$z = \sum_{i=1}^{N} w_i x_i + b$$

```c
double weighted_sum = 0;
for (int i = 0; i < N; i++) {
    weight_sum += weights[i] * features[batch][i];
```

O valor de ativação do neurônio, depois de passar pela função sigmoide:

$$a = \sigma(z) = \frac{1}{1 + e^{-z}}$$

```c
double prediction = sigmoid(weight_sum);
```

* **(Z):** Essa é a soma ponderada das entradas do neurônio. É o resultado de pegar cada input (x\_i), multiplicar pelo seu respectivo peso (w\_i) e somar tudo, adicionando um viés (b) no final. Pensa nisso como a quantidade total de "sinal" que o neurônio tá recebendo.
* $$\sum_{i=1}^{N}$$ **(Somatório de 'i' igual a 1 até 'N'):** Esse símbolo de "E" gordo (Sigma) significa que você vai somar várias coisas. O $i$ é um índice que vai de 1 até N, onde N é o número total de entradas que o neurônio recebe.
* $$w_i$$ **(Peso 'i'):** Cada conexão entre neurônios tem um "peso". Esse peso indica a força dessa conexão. Se o peso for alto, a entrada correspondente tem mais influência na decisão do neurônio. Se for baixo, tem menos. Pensa nisso como a importância que você dá para cada pedacinho de informação antes de tomar uma decisão.
* $$x_i$$ **(Entrada 'i'):** Cada neurônio recebe várias entradas (x). Essas entradas podem ser os valores dos dados que você tá processando (as características do pacote) ou as saídas de outros neurônios na rede.
* **b (Viés):** O viés é como um "grauzinho extra" de ativação que o neurônio tem. Ele permite que o neurônio dispare mesmo que a soma ponderada das entradas seja zero. Pensa nisso como um humor pré-definido do neurônio.
* **a (Ativação):** Essa é a saída final do neurônio, depois que a soma ponderada (z) passa pela função sigmoide ( $$\sigma$$). É o valor que esse neurônio vai enviar para os próximos neurônios na rede.
