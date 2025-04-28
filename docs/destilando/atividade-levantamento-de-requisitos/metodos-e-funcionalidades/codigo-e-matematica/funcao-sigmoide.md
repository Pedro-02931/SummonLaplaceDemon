# Função Sigmoide

A ativação de um neurônio na rede é dada pela função sigmoide:

$$\sigma(x) = \frac{1}{1 + e^{-x}}$$\


```c
double sigmoid(double x) {
    return 1.0 / (1.0  exp(-x));
}
```

E sua derivada, usada para retropropagação:

$$\sigma'(x) = \sigma(x) (1 - \sigma(x))$$

```c
double sigmoid_derivative(double x) {
    double s = sigmoid(x);
    return s * (1 -s);
}
```

\


* $$\sigma(x)$$**(Sigma de x):** Pensa nisso como o interruptor do neurônio (aquela unidade básica do seu cérebro digital). Ele pega um sinal de entrada (x) e decide se o neurônio vai "ligar" ou "desligar". O resultado dessa função sempre fica entre 0 e 1, como se fosse a probabilidade do neurônio disparar.
* $$\frac{1}{1 + e^{-x}}$$**:** Essa é a mágica da coisa.
* **1:** Uma constante matemática, só pra dar um toque na fórmula.
* **e (Número de Euler):** Outra constante matemática cabulosa, tipo 2.71828... Ela aparece em um monte de fenômenos naturais e também em crescimento e decaimento. Aqui, ela ajuda a dar essa forma de "S" na função sigmoide.
* **-x:** O sinal negativo aqui inverte o valor de x, e o x é a soma ponderada das entradas que o neurônio recebe. Quanto maior o x, menor fica $$e^{-x}$$, fazendo o resultado de $$\sigma(x)$$ se aproximar de 1 (neurônio "ligado"). Quanto menor o x, maior fica $$e^{-x}$$, fazendo $$\sigma(x)$$ se aproximar de 0 (neurônio "desligado").
* $$\sigma'(x)$$ **(Sigma linha de x):** Essa é a derivada da função sigmoide. Em termos simples, ela te diz o quão sensível o neurônio é a pequenas mudanças na entrada x. É crucial para o aprendizado da rede.
* $$\sigma(x) (1 - \sigma(x))$$**(Sigma de x multiplicado por um menos sigma de x):** Essa é a fórmula para calcular a derivada da sigmoide de forma eficiente, usando o próprio valor da sigmoide.
