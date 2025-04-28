# ESQUEMAS DE VALIDAÇÃO

Esses esquemas garantem que a informação recebida esteja no formato correto e contenha todos os dados necessários.

* **JSON Schema e Protocol Buffers:** São como "contratos" que definem a estrutura esperada para os dados. Se os dados recebidos não seguirem esse contrato, o servidor sabe que algo está errado. O JSON Schema é mais usado para APIs web (como a comunicação com o Dashboard), enquanto o Protocol Buffers é mais eficiente para comunicação entre sistemas internos (como entre o Coletor e o servidor).
* **Time-To-Live (TTL) Adaptativo:** Para pacotes incomuns, o TTL define um prazo para que esses dados sejam revisados. Se não forem, o sistema pode assumir que há um erro e tomar alguma ação (como sinalizar para um operador humano). É como se o seu cérebro marcasse informações estranhas para uma revisão posterior.
* **Algoritmo de Inferência Inicial (Random Forest):** Para pacotes novos, o servidor usa um modelo de aprendizado de máquina simples (Random Forest é um algoritmo rápido e eficiente) para fazer uma primeira estimativa do destino mais provável. É como um "palpite educado" baseado em padrões que o sistema já aprendeu.
