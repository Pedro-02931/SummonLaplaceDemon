# Função de Perda (Loss)

Para medir o desempenho do modelo, usamos a função de erro quadrático médio:

$$L = \frac{1}{m} \sum_{j=1}^{m} (y_j - \hat{y}_j)^2$$

{% code overflow="wrap" %}
```c
double loss =0;
for (int batch = 0; batch < BATCH_SIZE; batch++) {
    double weight_sum = 0;
    for (int i = 0; i < N; i++) {
        weighted_sum += weights[i] * training_features[epoch][batch][i];
    }
    double prediction = sigmoid(weight_sum);
    loss += pow(labels[batch] - prediction, 2);
}
loss /= BATCH_SIZE;
printf(Epoch %d: Loss = %.8f\n", eoch, loss);
```
{% endcode %}

* **L (Loss):** Essa é a "perda", uma medida de quão ruim o modelo está performando. Quanto menor a perda, melhor o modelo está.
* $$\frac{1}{m}$$**:** Aqui, m é o número total de exemplos de treinamento que você usou para treinar a rede. Essa parte serve para calcular a média do erro em todos os exemplos.
* $$\sum_{j=1}^{m}$$**:** Outro somatório, dessa vez para todos os exemplos de treinamento.
* $$(y_j - \hat{y}_j)^2$$ **(Y 'j' menos Y chapéu 'j' elevado ao quadrado):** Para cada exemplo de treinamento (j), calcula a diferença entre a saída correta (y\_j) e a predição da rede ( $$\hat{y}_j$$), e eleva essa diferença ao quadrado. Elevar ao quadrado serve para dar mais peso aos erros maiores e para garantir que o erro seja sempre positivo.
