# Learning with RMS
## Índice
- [Descrição do projeto](#descrição-do-projeto)
- [Documentação](#documentação)
- [Como executar o projeto](#como-executar-o-projeto)
- [Como usar o projeto](#como-usar-o-projeto)
- [Nossa Licença](#nossa-licença)
- [Autores do projeto](#autores-do-projeto)

## Descrição do projeto
Projeto desenvolvido pela equipe **RMS**. Consiste em um site que usa uma API (Interface de Programação de Aplicação) de inteligência artificial para ajudar o usuário a aprender sobre qualquer uma das oito matérias disponíveis no site: matemática, biologia, química, física, sociologia, história, geografia e filosofia. O Projeto conta com um Banco de Dados bem elaborado, e funcionalidades que focam na progressão, memorização e aprendizado com conhecimentos novos.

## Documentação
[Clique aqui](https://docs.google.com/document/d/1izZK09LhH47nnzx-YutZVEfgHb3UA8K0Xxm6GaqLIPg/edit?usp=sharing) para acessar a documentação do projeto, incluindo os requisitos funcionais (tanto prontos quanto removidos) e o histórico dos testes unitários.

## Como executar o projeto
Segue um passo-a-passo de como executar o projeto em sua máquina. Antes de tudo, certifique-se que de **estar em um computador**, e que ele tenha como sistema operacional o **Windows 10**. Certifique-se também que sua máquina tenha pelo menos **900MB de armazenamento disponível, 4GB de memória RAM** (informações disponíveis nas configurações do computador), e o devido **acesso à internet**.
<hr>

### Passo 1: Download dos arquivos necessários
- Na página onde você atualmente se encontra, clique no botão verde onde está escrito "< > Code" e, em seguida, clique na opção "Download ZIP".
- Depois, vá até o local onde o arquivo acabou de ser baixado (provavelmente na pasta "Downloads" de seu computador), e localize o mesmo; ele deve estar com o título ``Projeto-POO-main``.
- Clique com o botão direito do mouse por cima do arquivo e selecione a opção "Extrair Tudo...", e depois clique em "Extrair". Se quiser, você pode mover a pasta gerada para um outro lugar em seu computador, porém, não se esqueça de registrar a localização nova.
- [Clique aqui](https://dlcdn.apache.org/netbeans/netbeans-installers/23/Apache-NetBeans-23-bin-windows-x64.exe) para baixar o aplicativo necessário para abrir o projeto, o ``Apache NetBeans versão 23``.
- [Clique aqui](https://adoptium.net/) para acessar o site ``Adoptium``. Em seguida, clique no botão roxo escuro onde está escrito "Latest LTS Release". Um arquivo chamado ``OpenJDK21U-jdk_x64_windows_hotspot_21.0.5_11.msi`` começará a ser baixado.
<hr>

### Passo 2: Instalação do Kit de Desenvolvimento Java
- Vá até o local onde o arquivo ``OpenJDK21U-jdk_x64_windows_hotspot_21.0.5_11.msi`` foi baixado. Na pasta, inicie (clique duas vezes) o mesmo.
- Na nova janela, clique em "Next".
- Depois, marque a opção "I accept the terms in the Licence Agreement", e em seguida clique em "Next >" mais uma vez.
- Depois, clique novamente em "Next", e em seguida no X vermelho onde do lado está escrito "Set or overide JAVA_HOME variable". Após isso, clique em "Will be installed on local hard drive", e depois em "Next".
- Depois, clique em "Install", em seguida em "Sim" na janela que abrir, e por fim em "Finish".
<hr>

### Passo 3: Instalação do NetBeans
- Vá até o local onde o arquivo ``Apache-NetBeans-23-bin-windows-x64.exe`` foi baixado. Na pasta, inicie o mesmo.
- Em seguida, clique em "Sim" na janela que abrir. Depois, deve abrir um aplicativo chamado "Apache NetBeans IDE Installer".
- Em tal aplicativo, clique no botão "Next >". Depois, marque a opção "I accept the terms in the licence agreement", e em seguida clique em "Next >" mais uma vez.
- Se quiser que o NetBeans seja instalado em outra pasta, clique no botão "Browser..." do campo "Install the Apache NetBeans IDE to:" na página que abriu, e em seguida, localize em seu computador a pasta desejada.
- Caso você tenha outra JDK instalada, clique na seleção abaixo do campo "JDK for the Apache NetBeans IDE:", e localize a opção "jdk-21.0.5.11-hotspot".
- Ao finalizar, clique em "Next >", depois em "Install", e quando a instalação terminar, clique em "Finish".
<hr>

### Passo 4: Abrindo o projeto no NetBeans
- Vá até a Área de Trabalho do seu computador, e inicie o aplicativo ``Apache NetBeans IDE 23``.
- Quando ele abrir, clique em "File" no canto superior esquerdo, e depois em "Open Project...".
- Na janela que abrir, localize a pasta ``Projeto-POO-main``, baixada no Passo 1.
- Entre na pasta, e após isso, clique em ``Projeto-POO-main`` (a pasta com um ícone diferente), e depois clique em "Open Project". Na janela que abrir, clique em "Close".
<hr>

### Passo 5: Instalação do Servidor usado
- Quando não houver mais nenhuma barra azul no canto inferior do aplicativo, vá até a página "Services", localizada logo acima do nome do projeto.
- Depois, clique com o botão direito sob a opção "Servers", e depois clique em "Add Server...".
- Na janela que abrir, clique em "GlassFish Server", e depois em "Next >".
- Em seguida, clique na seleção abaixo do campo "Choose a server to download:", e depois, localize e clique na opção "GlassFish Server 8.0.0".
- Após isso, marque a opção "I have read and accept the license agreement... (click)" clicando no pequeno quadrado ao lado do texto, e depois, clique na opção "Download Now..." e aguarde a instalação terminar.
- Quando acontecer, clique em "Next >", e depois em "Finish".
- Volte para a página "Projects". Depois, clique no nome do projeto (``Learning_POO``), e depois clique com o botão direito no mesmo lugar.
- Em seguida, localize e clique na opção "Resolve Missing Server Problem...".
- Depois, clique em "GlassFish Server", e depois em "OK".
<hr>

### Passo 6: Conexão com o Banco de Dados
- Volte para a página "Services", e clique na seta para baixo ao lado da opção "Databases".
- Depois, clique com o botão direito em "Java DB", e depois em "Create Database...".
- No campo "Database Name:", escreva ``POOPROJECT``; no campo "User Name:", escreva ``usuario``; e nos campos "Password:" e "Confirm Password:", escreva ``123``.
- Quando aparecer a opção "jdbc:derby://localhost:1527/POOPROJECT [usuario on USUARIO]", clique com o botão direito na mesma, e depois selecione "Connect...".
- Em seguida, clique novamente com o botão direito, e selecione a opção "Execute Command...". Ao fazer isso, um campo será aberto.
- Vá até a [seção "Banco de Dados"](#banco-de-dados) deste documento, e copie o script dentro do grande retângulo cinza.
- Depois, volte ao NetBeans, e no campo aberto, e cole (aperte Ctrl+V em seu teclado) o mesmo script. Após isso, aperte ao mesmo tempo as seguintes teclas do seu teclado: ``Ctrl+Shift+E``.
- Por fim, feche o NetBeans.
<hr>

### Passo 7: Configurando a Variável de Ambiente da IA
- [Clique aqui](https://console.groq.com/keys) para acessar o site do ``Groq``.
- No site, clique em "Login", e prossiga criando uma conta no site (ou entrando, caso já tenha uma).
- Em seguida, no campo "API Keys", clique no botão "Create API Key".
- Depois, no campo acima do botão preto "Submit", insira um nome de sua preferência, e abaixo, marque o campo do ``ReCAPCHA``.
- Depois, clique no botão preto "Copy", e depois em "Done".
- Depois, vá até a barra de pesquisa da barra de ferramentas (no canto inferior do seu computador) e pesquise por "Editar as variáveis de ambiente do sistema", clicando na mesma opção que aparecer logo em seguida.
- Na nova janela que abrir, clique em "Variáveis de Ambiente...", e depois em "Novo...".
- No campo "Nome da variável:", insira o seguinte nome dentro das aspas: ``API_KEY``; e no campo "Valor da variável:", cole o código copiado anteriormente.
- Por fim, clique em "OK", depois em "OK", e por último em "OK".
<hr>

### Passo 8: Executando o projeto
- Abra novamente o ``NetBeans``.
- Quando o aplicativo abrir e tudo acabar de carregar, clique no ícone da Terra, logo acima do nome do projeto, e então clique na opção "Chrome" (se ele estiver instalado), ou "Microsoft Edge".
- Depois, clique no nome do projeto (``Learning_POO``), e depois clique com o botão direito no mesmo lugar.
- Por fim, clique na opção "Run", e na nova janela, clique em "Permitir acesso".

<br>Quando o projeto abrir, você poderá explorar as funções dele normalmente.
<hr>

### Banco de Dados
Para o Passo 6 funcionar corretamente, copie o seguinte script: (ele contém as tabelas usadas no projeto. Sem ele, o projeto em si não funciona)<br>
```
-- Criação da tabela 'usuario'
CREATE TABLE usuario (
    id_usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_email_usuario VARCHAR(100) NOT NULL UNIQUE,
    nm_usuario VARCHAR(100) NOT NULL,
    nm_senha_usuario VARCHAR(255) NOT NULL
);

-- Criação da tabela 'materia'
CREATE TABLE materia (
    id_materia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_materia VARCHAR(100) NOT NULL UNIQUE,
    ds_materia VARCHAR(255)
);

-- Inserindo as matérias
INSERT INTO materia (nm_materia, ds_materia) VALUES
('Matemática', ''),
('Biologia', ''),
('Química', ''),
('Física', ''),
('Sociologia', ''),
('História', ''),
('Geografia', ''),
('Filosofia', '');

-- Criação da tabela 'dificuldade'
CREATE TABLE dificuldade (
    id_dificuldade INT PRIMARY KEY,
    nm_dificuldade_tarefa VARCHAR(50) NOT NULL CHECK (nm_dificuldade_tarefa IN ('Exame de Proficiência', 'Muito fácil', 'Fácil', 'Médio', 'Difícil', 'Muito difícil', 'Exame Final'))
);

-- Inserindo as dificuldades
INSERT INTO dificuldade (id_dificuldade, nm_dificuldade_tarefa) VALUES
(0, 'Exame de Proficiência'),
(1, 'Muito fácil'),
(2, 'Fácil'),
(3, 'Médio'),
(4, 'Difícil'),
(5, 'Muito difícil'),
(6, 'Exame Final');

-- Criação da tabela 'usuario_materia' para gerenciar matrícula do usuário em matérias
CREATE TABLE usuario_materia (
    id_usuario INT,
    id_materia INT,
    dt_matricula DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_usuario, id_materia),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_materia FOREIGN KEY (id_materia) REFERENCES materia(id_materia) ON DELETE CASCADE
);

-- Criando a tabela tarefa
CREATE TABLE tarefa (
    id_tarefa INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_materia INT NOT NULL,
    id_dificuldade INT NOT NULL,
    CONSTRAINT fk_tarefa_materia FOREIGN KEY (id_materia) REFERENCES materia(id_materia) ON DELETE CASCADE,
    CONSTRAINT fk_tarefa_dificuldade FOREIGN KEY (id_dificuldade) REFERENCES dificuldade(id_dificuldade) ON DELETE CASCADE,
    CONSTRAINT fk_usuario_tarefa FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Criação da tabela 'proficiencia_usuario' com chave primária composta
CREATE TABLE proficiencia_usuario (
    id_tarefa INT,
    id_usuario INT,
    id_materia INT,
    qt_ponto_usuario INT DEFAULT 0,
    qt_ponto_maximo_usuario INT DEFAULT 0,
    dt_teste DATE DEFAULT CURRENT_DATE,
    ic_tarefa_concluida_false_true BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_usuario, id_materia, id_tarefa),
    CONSTRAINT fk_proficiencia_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_proficiencia_materia FOREIGN KEY (id_materia) REFERENCES materia(id_materia) ON DELETE CASCADE,
    CONSTRAINT fk_proficiencia_tarefa FOREIGN KEY (id_tarefa) REFERENCES tarefa(id_tarefa) ON DELETE CASCADE
);
```
## Como usar o projeto
Segue a lista de todas as funcionalidades do projeto, e de como acessá-las.
<hr>

### Página Principal & Menu
- O menu serve como uma conexão entre todas as páginas. Inicialmente, ele só possui três botões: página principal, página de registro e página de login.
- Uma vez criada uma conta, os demais botões com as páginas restantes ficam disponíveis para o usuário: página de estatísticas, página de tarefas e biblioteca.
- Para visualizar a página principal, o usuário deve primeiro criar uma conta (ou entrar em uma já existente) usando os botões do menu, ou os links localizados logo abaixo da descrição do site.
- Com a conta devidamente registrada, a página principal muda: o usuário consegue acesso as matérias disponíveis no site, para ele se matricular nas que ele quiser. Uma vez matriculado em uma matéria, a seleção para tal matéria é bloqueada.
- Se o usuário se matricular em todas as matérias, as seleções desaparecem, e o que resta é uma mensagem informando ao usuário sua situação atual.
<hr>

### Páginas de Registro, Login & Perfil
- Todas estas três páginas giram em torno do cadastro do usuário.
- A página de registro possui quatro campos: e-mail, nome, senha e confirmar senha, além de um link direcionando para a página de login no final. Caso o usuário não tenha uma conta, ele deve preencher todos os campos com as devidas informações.
- A página de login possui dois campos: e-mail e senha, além de um link direcionando para a página de registro no final. Caso o usuário tenha uma conta, ele deve preencher todos os campos as informações de sua conta para entrar no site.
- A página de perfil possui as informações do e-mail e nome da conta do usuário, além de campos para o usuário mudar seu nome e senha, e um botão para desconectar da conta.
<hr>

### Página de Estatísticas
- Esta página exibe as seguintes informações sobre o usuário e seu uso do site: Tarefas Concluídas, Precisão Média, Matérias matriculadas, Quantidade de acertos e Quantidade de acertos máximos. Cada uma das informações são autoexplicativas.
<hr>

### Página de Tarefas
- Esta página exibe as matérias nas quais o usuário se matriculou na página principal, separadas e organizadas em retângulos brancos.
- Cada retângulo possui uma lista de botões, que levam o usuário até a página da devida tarefa. Cada botão possui um nome, que corresponde a dificuldade da tarefa de destino, sendo eles: Exame de Proficiência, Muito fácil, Fácil, Médio, Difícil, Muito difícil e Exame Final.
- No fundo de cada retângulo, existe também uma barra de progressão, que mostra a porcentagem do progresso atual do usuário na devida matéria.
<hr>

### Página de Biblioteca
- Esta página exibe o acervo de livros disponíveis no site, cada um separado em um retângulo branco.
- Cada retângulo possui uma imagem do devido livro e um botão, e ambos os itens levam o usuário para página de compra de tal livro.
<hr>

### Página de Tarefa Individual
- Ao clicar nos botões de cada matéria na página das tarefas, o usuário é redirecionado para a página da devida tarefa, tudo depende do título do botão.
- Esta é a página que utiliza a inteligência artificial integrada ao projeto.
- A página começa com a primeira questão da tarefa. a IA descreve cada uma das opções de A à E, e o usuário pode selecionar a opção que ele julgar correta.
- O usuário precisa esperar por até 30 segundos (ou mais) antes de clicar no botão Enviar e ir para a próxima questão.
- Ao final da tarefa, a IA irá sugerir áreas para o usuário melhorar seu desempenho, isso se sua pontuação acabar sendo menor ou igual a três.
- Se a pontuação acabar sendo quatro ou cinco, a próxima tarefa será desbloqueada para o usuário fazer.
- Se sua pontuação acabar sendo menor ou igual a três, o usuário vai precisar refazer o teste até conseguir a pontuação necessária para avançar.

## Nossa Licença
Nosso projeto utiliza a licença do MIT.

## Autores do projeto
- [Miguel Menezes Serra](https://github.com/Miguel-Serra320)
- [Rafael Michalewicz Rodrigues](https://github.com/Michalewicz)
- [Sandro Gabriel dos Santos de Jesus](https://github.com/Sandro-Gab)
