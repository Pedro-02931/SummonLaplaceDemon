# Backpropagation

**###**&#x20;

O ajuste dos pesos segue a derivada da função de perda em relação aos pesos:

$$\frac{\partial L}{\partial w_i} = -2 (y - \hat{y}) \cdot \sigma'(z) \cdot x_i$$

{% code overflow="wrap" %}
```c
double weighted_sum = 0;        // Forward pass
for (int i = 0; i < N; i++) {
    weighted_sum += weights[i] * features[batch][i];
}
double prediction = sigmoid(weighted_sum);
double error = labels[batch] - prediction;
double partial_derivative_L_wi = -2.0 * error * sigmoid_derivative(weighted_sum) * features[batch][i];
```
{% endcode %}

$$w_i \leftarrow w_i - \eta \frac{\partial L}{\partial w_i}$$

{% code overflow="wrap" %}
```c
// Backward pass (Erro Quadrático Médio)
double error = labels[batch] - prediction;
for (int i = 0; i < N; i++) {
    weights[i] += weights[i] - ETA  * partial_derivate;
}
```
{% endcode %}



* $$\frac{\partial L}{\partial w_i}$$ **(Derivada parcial de L em relação a w 'i'):** Essa é a parte mais "cabeça" da matemática. Essa notação representa a derivada parcial da função de perda (L) em relação a um peso específico (w\_i). Em termos simples, ela te diz o quão sensível a perda é a uma pequena mudança naquele peso. É a direção que você precisa seguir para diminuir a perda.
* $$-2 (y - \hat{y}) \cdot \sigma'(z) \cdot x_i$$**(Menos dois multiplicado por y menos y chapéu multiplicado por sigma linha de z multiplicado por x 'i'):** Essa é a fórmula específica para calcular essa derivada no caso da função de perda de erro quadrático médio e da função de ativação sigmoide.
* $$w_i \leftarrow w_i - \eta \frac{\partial L}{\partial w_i}$$ **(Peso 'i' recebe Peso 'i' menos eta multiplicado pela derivada parcial de L em relação a w 'i'):** Essa é outra forma de atualizar os pesos, usando diretamente a derivada da função de perda. O sinal de menos aqui indica que estamos indo na direção oposta ao gradiente (a direção que diminui a perda).
