# Page 2

{% code overflow="wrap" %}
```bash
# ---------------------------------------------
# Atualiza os repositórios e instala os pacotes necessários.
# Inclui compiladores, Python, bibliotecas científicas e utilitários.
# ---------------------------------------------
echo "📦 Instalando pacotes base..."
apt update && apt install -y \
  build-essential clang cmake ninja-build gfortran \
  python3 python3-dev python3-pip python3-venv \
  libopenblas-dev liblapack-dev libomp-dev libeigen3-dev \
  wget curl git software-properties-common \
  gdb
  # build-essential: Este é um meta-pacote que instala um conjunto de pacotes considerados essenciais para compilar software. Ele inclui compiladores (como GCC e G++), a biblioteca make e outras ferramentas básicas de desenvolvimento.
  # clang É outro compilador para as linguagens C, C++, Objective-C e outras. É conhecido por sua velocidade de compilação e mensagens de erro mais claras do que o GCC em alguns casos. 
  # cmake É uma ferramenta de "construção" que ajuda a gerenciar o processo de compilação de software, especialmente projetos grandes e complexos. Ele gera os arquivos necessários para compilar o código em diferentes plataformas.
  # ninja-build: É um sistema de construção pequeno e focado em velocidade. Ele lê os arquivos de construção gerados por ferramentas como cmake e executa as etapas de compilação da forma mais rápida possível. 
  # gfortran: É o compilador GNU para a linguagem Fortran. 
  #-> Para que serve o fortran?
  # python3-dev: Contém os arquivos de cabeçalho e as bibliotecas estáticas necessárias para compilar extensões para Python escritas em outras linguagens, como C ou C++. Acronimos: -dev significa development (desenvolvimento). Por que para harmonia de ia? Muitas bibliotecas de IA de alto desempenho (como NumPy, SciPy e TensorFlow) têm partes escritas em C ou C++ para otimizar a velocidade. python3-dev é necessário para compilar essas extensões a partir do código fonte.
  # python3-venv: Fornece ferramentas para criar ambientes virtuais Python isolados. Isso permite que você tenha diferentes projetos com dependências diferentes sem que elas entrem em conflito. Acronimos: venv é uma abreviação de "virtual environment" (ambiente virtual).
  # libopenblas-dev: Contém os arquivos de desenvolvimento para a biblioteca OpenBLAS, que é uma implementação otimizada da BLAS (Basic Linear Algebra Subprograms). BLAS é um conjunto de rotinas básicas para realizar operações de álgebra linear, como multiplicação de matrizes e vetores. Acronimos: BLAS (Basic Linear Algebra Subprograms). Por que para harmonia de ia? A álgebra linear é a base matemática de muitos algoritmos de IA e Machine Learning. OpenBLAS fornece implementações altamente otimizadas dessas operações, cruciais para o desempenho de tarefas como treinamento de redes neurais. O sufixo -dev indica que este pacote inclui os arquivos necessários para compilar software que usa a OpenBLAS.
  # liblapack-dev: Contém os arquivos de desenvolvimento para a biblioteca LAPACK (Linear Algebra PACKage). LAPACK é uma biblioteca de rotinas numéricas escritas em Fortran e C para resolver problemas comuns de álgebra linear, como sistemas de equações lineares, problemas de autovalores e decomposição de valores singulares. Acronimos: LAPACK (Linear Algebra PACKage). Por que para harmonia de ia? Assim como o BLAS, o LAPACK fornece ferramentas matemáticas essenciais para muitos algoritmos de IA, e ter os arquivos de desenvolvimento permite que outros softwares se vinculem e utilizem suas funcionalidades otimizadas.
  # libomp-dev: Contém os arquivos de desenvolvimento para a biblioteca OpenMP (Open Multi-Processing). OpenMP é uma API que suporta programação paralela multi-plataforma em linguagens como C, C++ e Fortran. Ela permite que um programa execute diferentes partes de seu código simultaneamente em múltiplos núcleos de um processador, acelerando a execução. Acronimos: OpenMP (Open Multi-Processing). Por que para harmonia de ia? O treinamento de modelos de IA pode ser computacionalmente intensivo. OpenMP permite aproveitar o poder de processadores multi-core para acelerar esses processos, tornando o desenvolvimento e a experimentação mais rápidos. 
  # libeigen3-dev: Contém os arquivos de desenvolvimento para a biblioteca Eigen, que é uma biblioteca de álgebra linear escrita em C++ para vetores, matrizes, solvers numéricos e tópicos relacionados. É amplamente utilizada em projetos que exigem alto desempenho em cálculos numéricos. Acronimos: Não é um acrônimo, é o nome da biblioteca. Por que para harmonia de ia? Eigen é uma biblioteca moderna e eficiente para operações de álgebra linear em C++. Muitos projetos de IA que utilizam C++ como linguagem principal ou para partes de alto desempenho podem se beneficiar do Eigen. O "3" no nome indica a versão principal da biblioteca.
  # gdb: É o GNU Debugger, uma ferramenta poderosa para depurar programas escritos em várias linguagens, incluindo C, C++ e Python (com extensões). Acronimos: GNU Debugger. Por que para harmonia de ia? Quando problemas ou erros ocorrem no seu código de IA, gdb permite inspecionar o estado do programa em tempo de execução, ajudando a identificar e corrigir bugs.

# ---------------------------------------------
# Define variáveis de ambiente com flags otimizadas para CPUs Intel (ex: Skylake).
# Melhoram o desempenho na compilação de C/C++.
# ---------------------------------------------
CFLAGS="-march=skylake -mtune=skylake -O3 -pipe -fopenmp -flto"
export CFLAGS
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-Wl,-O1,--as-needed"
export MAKEFLAGS="-j$(nproc)"

# ---------------------------------------------
# Cria um ambiente virtual Python no diretório do usuário.
# ---------------------------------------------
echo "📦 Criando ambiente Python virtual..."
PY_ENV="/home/pmota/.vscode_ai_env""$PY_ENV"
sudo python3 -m venv "$PY_ENV"
chown -R pmota:pmota "$PY_ENV"
# python3 -m venv: Chama o módulo venv do Python 3. O módulo venv é usado para criar ambientes virtuais leves e isolados.

# ---------------------------------------------
# Ativa o ambiente virtual e instala os pacotes otimizados para IA.
# Inclui: numpy, scipy, scikit-learn-intelex, PyTorch (CPU), onnxruntime, transformers, Jupyter etc.
# ---------------------------------------------
echo "🤖 Instalando AI stack otimizada..."python3 -m venv ~/myenv          # Cria o ambiente
source ~/myenv/bin/activate      # Ativa o ambiente
pip install --upgrade pip setuptools wheel
pip install --no-cache-dir numpy scipy pandas scikit-learn-intelex torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu intel-openmp onnxruntime transformers sentence-transformers jupyterlab ipython autopep8 flake8 pylint
source ~/myenv/bin/activate && \
pip install --no-cache-dir numpy scipy pandas scikit-learn-intelex && \
pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu && \
pip install --no-cache-dir intel-openmp onnxruntime transformers sentence-transformers jupyterlab ipython autopep8 flake8 pylint
# Primeiro instale todas as outras dependências
pip install --no-cache-dir numpy scipy pandas scikit-learn-intelex \
torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu \
intel-openmp transformers sentence-transformers \
jupyterlab ipython autopep8 flake8 pylint

# Depois tente instalar o ONNX Runtime com uma versão específica
pip install onnxruntime==1.16.3  # Versão conhecida por funcionar com Python 3.11
# Instalar os pacotes restantes que faltaram
pip install --no-cache-dir transformers sentence-transformers


# ---------------------------------------------
# Cria um script com variáveis globais de desempenho para bibliotecas numéricas.
# Este script será carregado automaticamente em cada shell.
# ---------------------------------------------
echo "⚙️ Aplicando variáveis globais de desempenho..."
sudo bash -c 'cat <<EOF > /etc/profile.d/python-ai.sh
export OMP_NUM_THREADS=$(nproc)
export MKL_NUM_THREADS=$(nproc)
export OPENBLAS_NUM_THREADS=$(nproc)
export NUMEXPR_NUM_THREADS=$(nproc)
export TF_NUM_INTRAOP_THREADS=$(nproc)
export TF_NUM_INTEROP_THREADS=2
export PATH="$PY_ENV/bin:\$PATH"
EOF'
sudo chmod +x /etc/profile.d/python-ai.sh

# ---------------------------------------------
# Aplica ajustes de memória no sistema via sysctl.
# Melhora desempenho em cargas de trabalho científicas.
# ---------------------------------------------
echo "🧠 Aplicando ajustes de memória..."
# Crie o arquivo temporariamente em sua home
cat <<EOF > ~/99-python-ai.conf
vm.overcommit_memory=1
vm.swappiness=10
vm.dirty_ratio=15
vm.dirty_background_ratio=3
EOF

# Mova para o diretório correto com sudo
sudo mv ~/99-python-ai.conf /etc/sysctl.d/99-python-ai.conf

# Aplique as configurações
sudo sysctl -p /etc/sysctl.d/99-python-ai.conf

# ---------------------------------------------
# Instala o VSCode caso não esteja presente.
# Adiciona o repositório oficial da Microsoft e instala o pacote.
# ---------------------------------------------
echo "💻 Instalando VSCode..."
sudo apt install -y wget gpg && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg >/dev/null && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null && sudo apt update && sudo apt install -y code

# ---------------------------------------------
# Cria o comando personalizado ai-vscode que ativa o ambiente Python
# com variáveis de threads antes de iniciar o VSCode.
# ---------------------------------------------
echo "🧪 Criando comando ai-vscode e launcher..."
sudo bash -c 'cat <<"EOF" > /usr/local/bin/ai-vscode
#!/bin/bash
source ~/.vscode_ai_env/bin/activate
export OMP_NUM_THREADS=4
export MKL_NUM_THREADS=4
export TF_NUM_INTRAOP_THREADS=4
export TF_NUM_INTEROP_THREADS=2
exec /usr/bin/code "$@"
EOF'
sudo chmod +x /usr/local/bin/ai-vscode

# ---------------------------------------------
# Cria um atalho no menu do sistema para abrir o VSCode otimizado.
# ---------------------------------------------
USER_HOME=$(getent passwd "$(logname)" | cut -d: -f6)
mkdir -p "$USER_HOME/.local/share/applications"
cat > "$USER_HOME/.local/share/applications/ai-vscode.desktop" <<'EOF'
[Desktop Entry]
Name=AI-Optimized VSCode
Comment=VSCode com otimizações para IA em CPU Intel
Exec=/usr/local/bin/ai-vscode %F
Icon=com.visualstudio.code
Type=Application
Terminal=false
StartupWMClass=Code
Categories=Development;IDE;
EOF
chown "$(logname):$(id -gn $(logname))" "$USER_HOME/.local/share/applications/ai-vscode.desktop"


# ---------------------------------------------
# Instala extensões úteis no VSCode para Python, IA e produtividade.
# ---------------------------------------------
echo "🔌 Instalando extensões VSCode..."
which code || echo "VS Code não está no PATH"
sudo -u "$(logname)" bash -c '
  code --install-extension ms-python.python
  code --install-extension ms-toolsai.jupyter
  code --install-extension VisualStudioExptTeam.vscodeintellicode
  code --install-extension IntelCorp.vscode-intel-extension-for-python
  code --install-extension TabNine.tabnine-vscode
  
'
sudo -u "$(logname)" code --install-extension ms-toolsai.jupyter

# ---------------------------------------------
# Define configurações padrão do VSCode para usar o ambiente Python virtual.
# Ativa linting, formatação e integração com notebooks.
# ---------------------------------------------
USER_HOME=$(getent passwd "$(logname)" | cut -d: -f6)
sudo -u "$(logname)" mkdir -p "$USER_HOME/.config/Code/User"
sudo -u "$(logname)" bash -c "cat > '$USER_HOME/.config/Code/User/settings.json' <<'EOF'
{
  \"python.languageServer\": \"Pylance\",
  \"python.defaultInterpreterPath\": \"$PY_ENV/bin/python\",
  \"python.linting.enabled\": true,
  \"python.formatting.provider\": \"autopep8\",
  \"jupyter.alwaysTrustNotebooks\": true,
  \"jupyter.notebookFileRoot\": \"\${workspaceFolder}\"
}
EOF"
sudo chown -R "$(logname):$(id -gn $(logname))" "$USER_HOME/.config/Code"

# ---------------------------------------------
# Cria um projeto de exemplo com Makefile e código C + Python.
# Permite compilar código C com OpenMP e comparar com Python+NumPy.
# ---------------------------------------------

# ---------------------------------------------
# Mensagem final de sucesso e instruções.
# ---------------------------------------------
echo "✅ Ambiente completo configurado!"
echo "➡️ Para começar: 'cd ~/ai_project && make'"
echo "🧠 Use o atalho no menu: 'AI-Optimized VSCode' ou comando: ai-vscode"

```
{% endcode %}
