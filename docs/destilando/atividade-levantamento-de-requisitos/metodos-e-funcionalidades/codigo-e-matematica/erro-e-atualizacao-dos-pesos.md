# Erro e Atualização dos Pesos

O erro é dado pela diferença entre a saída esperada ( y ) e a predição da rede ( $$\hat{y}$$  ):

$$\text{erro} = y - \hat{y}$$

```c
double error = labels[batch] - prediction;
```

Os pesos são atualizados usando a regra do gradiente descendente:\
$$w_i \leftarrow w_i + \eta \cdot \text{erro} \cdot \sigma'(z) \cdot x_i$$

```c
for (int i = 0; i < N; i++) {
    weights[i] += ETA * error * sigmoid_derivative(weight_sum) * features[batch][i];
}
```

onde ( $$\eta$$ ) é a taxa de aprendizado.

* **erro:** Essa variável representa o quão errada a predição da rede foi. É a diferença entre o que a rede deveria ter previsto (y) e o que ela realmente previu ( $$\hat{y}$$).
* **y:** Essa é a saída correta, o "rótulo" que diz qual era o destino certo para o pacote.
* $$\hat{y}$$ **(Y chapéu):** Essa é a predição da rede, o palpite que ela deu sobre o destino do pacote.
* $$ $w_i \leftarrow w_i + \eta \cdot \text{erro} \cdot \sigma'(z) \cdot x_i$ $$ **(Peso 'i' recebe Peso 'i' mais eta multiplicado por erro multiplicado por sigma linha de z multiplicado por entrada 'i'):** Essa é a regra mágica de como a rede aprende. Os pesos ( $$w_i$$) são ajustados para tentar reduzir o erro na próxima vez.
  * $$\leftarrow$$ **(Seta para a esquerda):** Significa "recebe o valor de". O peso antigo é atualizado com o novo valor calculado.
  * $$\eta$$ **(Eta):** Essa é a taxa de aprendizado, controlando o quão grande é o ajuste nos pesos.
  * $$\sigma'(z)$$ **(Sigma linha de z):** A derivada da sigmoide, que te diz o quão sensível o neurônio foi à entrada.
  * $$x_i$$ **(Entrada 'i'):** A entrada original que contribuiu para essa ativação.
