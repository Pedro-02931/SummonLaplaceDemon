# Formatando SSD

Aqui eu decidi implementar tecnicas de formatação bem especificas voltando mais para a modularidade de partições do que para um monolito padrão como feito no sistema tradicional.

O objetivo aqui é basicamente otimizar a vida util do meu SSD fazendo um ritual usando as tecnologias mais recentes de forma inteligente e otimizada para cada partição e seu propóstio, mas em resumo, segue os ganhos teóricos:

| **Dimensão**                                 | **Método Tradicional**                                                                                                               | **Método Otimizado**                                                                                                                     |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Desempenho Geral**                         | Menor eficiência em operações de leitura e escrita devido ao alinhamento inadequado das partições.                                   | Melhor desempenho, especialmente em operações de leitura e gravação aleatória, devido ao alinhamento adequado (4K ou múltiplos).         |
| **Vida Útil do SSD**                         | Maior desgaste, pois o SSD realiza mais operações de escrita para compensar o alinhamento incorreto.                                 | Maior vida útil, pois o desgaste é distribuído de forma mais equilibrada, com menos operações de escrita e leitura desnecessárias.       |
| **Eficiência de I/O**                        | Ineficiente, com maior overhead em I/O, devido a blocos de memória não alinhados.                                                    | Mais eficiente, com menor latência em I/O, graças ao alinhamento correto das partições.                                                  |
| **Tempo de Acesso (latência)**               | Maior latência, já que as operações de leitura e escrita podem exigir mais tempo devido ao alinhamento incorreto.                    | Menor latência, já que o SSD consegue acessar dados diretamente de blocos alinhados, otimizando o tempo de resposta.                     |
| **Uso de Espaço no SSD**                     | Maior fragmentação de espaço, com blocos mal alocados, o que pode reduzir a eficiência de armazenamento.                             | Uso mais eficiente do espaço, com blocos de dados bem distribuídos, minimizando a fragmentação e melhor aproveitamento do armazenamento. |
| **Taxa de Transferência (leitura/gravação)** | Menor taxa de transferência, pois o SSD pode precisar realizar mais operações para completar uma única tarefa de leitura ou escrita. | Taxas de transferência mais altas devido ao acesso direto aos blocos de memória e ao melhor uso do barramento.                           |
| **Desempenho com SSDs de Alta Performance**  | Não aproveita ao máximo o potencial do SSD, especialmente em modelos mais rápidos e com maior durabilidade.                          | Maximiza o potencial dos SSDs de alta performance, aproveitando ao máximo a velocidade e a resistência.                                  |

***

#### **Resumo das Melhoria**:

* **Desempenho de leitura e gravação**: Pode melhorar significativamente (de 15% a 30%) devido ao alinhamento e melhor uso dos blocos do SSD.
* **Vida útil**: O desgaste é muito reduzido (potencial de aumento de 20% a 40% na longevidade do SSD).
* **Eficiência de I/O e latência**: Melhora de 10% a 25% na eficiência de I/O, com uma redução da latência (tempo de acesso), otimizando as operações de leitura e gravação.
