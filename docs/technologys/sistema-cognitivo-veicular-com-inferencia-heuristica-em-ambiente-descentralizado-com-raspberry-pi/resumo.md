# Resumo

Este artigo apresenta uma arquitetura de inferência cognitiva embarcada para caminhões, minimalista e eficiente, utilizando heurísticas de estados baseadas em observação e transições de magnitude, acionadas pela leitura de QR Codes físicos.&#x20;

O sistema utiliza um Raspberry Pi (atuando como Córtex Pré-frontal análogo) não apenas como núcleo de processamento local (O(1) para verificação de estado) e hub de rede LAN/Wi-Fi (ponto de acesso para comunicação direta com o motorista), mas também como o centro da cognição local, eliminando a dependência de cloud computing para decisões críticas.

&#x20;A comunicação segura com dispositivos móveis (celular do motorista) e o computador de bordo (Raspberry PI) é facilitada localmente, com replicação redundante e criptografada de dados para uma central externa via internet (4G),  encaminhado os dados relacionados ao estado do caminhão, carga e sensores com uma taxa de atualização calculada em função da necessidade de sincronização.&#x20;

A inferência, baseada na leitura de QR Codes que podem conter dados de formulários (editáveis apenas na origem funcionando como check-in) e links de visualização, ativa transições de estado interpretadas pelo sistema cognitivo com custo computacional mínimo, focando no colapso de estado validado e irreversível após a finalização.&#x20;

Este modelo é comparado a sistemas tradicionais, demonstrando ganhos em economia de energia, latência, robustez offline e modularidade de decisão.
