# Código e Matemática

#### Já estou com o dedo no cu mesmo, por que não formalizar essa bagaça com um rigor acadêmico digno de publicação em periódicos de _computer science_?

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define N 10          // Número de heurísticas (features)
#define EPOCHS 5000   // Número de iterações de treinamento
#define ETA 0.01      // Taxa de aprendizado
#define BATCH_SIZE 32 // Tamanho do lote para Stochastic Gradient Descent

// Função de ativação sigmoide
double sigmoid(double x) {
    return 1.0 / (1.0 + exp(-x));
}

// Derivada da função de ativação sigmoide
double sigmoid_derivative(double x) {
    double s = sigmoid(x);
    return s * (1 - s);
}

// Função para inicializar pesos aleatoriamente
void initialize_weights(double weights[N]) {
    srand(time(NULL));
    for (int i = 0; i < N; i++) {
        weights[i] = ((double)rand() / RAND_MAX) * 0.2 - 0.1; // Inicializando com valores pequenos
    }
}

// Função para realizar uma iteração de treinamento
void train_epoch(double weights[N], double features[BATCH_SIZE][N], double labels[BATCH_SIZE]) {
    for (int batch = 0; batch < BATCH_SIZE; batch++) {
        double weighted_sum = 0;
        // Forward pass
        for (int i = 0; i < N; i++) {
            weighted_sum += weights[i] * features[batch][i];
        }
        double prediction = sigmoid(weighted_sum);

        // Backward pass
        double error = labels[batch] - prediction;
        for (int i = 0; i < N; i++) {
            weights[i] += ETA * error * sigmoid_derivative(weighted_sum) * features[batch][i];
        }
    }
}

int main() {
    double weights[N]; // Pesos das conexões
    // Simulação de dados de entrada (heurísticas) e saída (destino correto)
    double training_features[EPOCHS][BATCH_SIZE][N];
    double training_labels[EPOCHS][BATCH_SIZE];

    // Geração de dados de treinamento simulados (a ser substituído por dados reais)
    srand(time(NULL));
    for (int epoch = 0; epoch < EPOCHS; epoch++) {
        for (int batch = 0; batch < BATCH_SIZE; batch++) {
            for (int i = 0; i < N; i++) {
                training_features[epoch][batch][i] = ((double)rand() / RAND_MAX) * 2 - 1; // Valores entre -1 e 1
            }
            training_labels[epoch][batch] = (training_features[epoch][batch][0] + training_features[epoch][batch][3] > 0) ? 1.0 : 0.0; // Função lógica simples como exemplo
        }
    }

    // Inicializando pesos
    initialize_weights(weights);

    // Treinamento do modelo (Stochastic Gradient Descent)
    for (int epoch = 0; epoch < EPOCHS; epoch++) {
        train_epoch(weights, training_features[epoch], training_labels[epoch]);

        // Cálculo da perda (Binary Cross-Entropy como exemplo)
        double loss = 0;
        for (int batch = 0; batch < BATCH_SIZE; batch++) {
            double weighted_sum = 0;
            for (int i = 0; i < N; i++) {
                weighted_sum += weights[i] * training_features[epoch][batch][i];
            }
            double prediction = sigmoid(weighted_sum);
            loss += -(training_labels[epoch][batch] * log(prediction + 1e-8) + (1 - training_labels[epoch][batch]) * log(1 - prediction + 1e-8));
        }
        loss /= BATCH_SIZE;
        printf("Epoch %d: Loss = %.8f\n", epoch, loss);
    }

    printf("Treinamento finalizado.\n");

    // Exemplo de inferência com um novo conjunto de heurísticas
    double new_heuristics[N];
    for (int i = 0; i < N; i++) {
        new_heuristics[i] = ((double)rand() / RAND_MAX) * 2 - 1;
    }
    double final_weighted_sum = 0;
    for (int i = 0; i < N; i++) {
        final_weighted_sum += weights[i] * new_heuristics[i];
    }
    double final_prediction = sigmoid(final_weighted_sum);
    printf("Inferência com novas heurísticas: %.6f (Destino: %s)\n", final_prediction, (final_prediction > 0.5) ? "Setor A" : "Setor B");

    return 0;
}
```

### Modelos:



