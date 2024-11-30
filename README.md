# Learning with RMS
## Índice
- [Descrição do projeto](#descrição-do-projeto)
- [Como executar o projeto](#como-executar-o-projeto)
- [Autores do projeto](#autores-do-projeto)

## Descrição do projeto
Projeto desenvolvido pela equipe **RMS**. Consiste em um site que usa uma API (Interface de Programação de Aplicação) de inteligência artificial para ajudar o usuário a aprender sobre qualquer uma das oito matérias disponíveis no site.

## Como executar o projeto
Segue um passo-a-passo de como executar o projeto em sua máquina. Antes de tudo, certifique-se que de **estar em um computador**, e que ele tenha como sistema operacional o **Windows 10**. Certifique-se também que sua máquina tenha pelo menos **900MB de armazenamento disponível, 4GB de memória RAM** (informações disponíveis nas configurações do computador), e o devido **acesso a internet**.

### Passo 1: Download dos arquivos necessários
- Na página onde você atualmente se encontra, clique no botão verde onde está escrito "< > Code" e, em seguida, clique na opção "Download ZIP".
- Depois, vá até o local onde o arquivo acabou de ser baixado (provavelmente na pasta "Downloads" de seu computador), e localize o mesmo; ele deve estar com o título "Projeto-POO-main".
- Clique com o botão direito do mouse por cima do arquivo e selecione a opção "Extrair Tudo...", e depois clique em "Extrair". Se quiser, você pode mover a pasta gerada para um outro lugar em seu computador, porém, não se esqueça de registrar a localização nova.
- [Clique aqui](https://dlcdn.apache.org/netbeans/netbeans-installers/23/Apache-NetBeans-23-bin-windows-x64.exe) para baixar o aplicativo necessário para abrir o projeto, o Apache NetBeans versão 23.
- [Clique aqui](https://adoptium.net/) para acessar o site "Adoptium". Em seguida, clique no botão roxo escuro onde está escrito "Lastet LTS Release". Um arquivo chamado "OpenJDK21U-jdk_x64_windows_hotspot_21.0.5_11.msi" começará a ser baixado.

### Passo 2: Instalação do Kit de Desenvolvimento Java
- Vá até o local onde o arquivo "OpenJDK21U-jdk_x64_windows_hotspot_21.0.5_11.msi" foi baixado. Na pasta, inicie (clique duas vezes) o mesmo.
- Na nova janela, clique em "Next".
- Depois, marque a opção "I accept de terms in the Licence Agreement", e em seguida clique em "Next >" mais uma vez.
- Depois, clique novamente em "Next", e em seguida no X vermelho onde do lado está escrito "Set or overide JAVA_HOME variable". Após isso, clique em "Will be installed on local hard drive", e depois em "Next".
- Depois, clique em "Install", em seguida em "Sim" na janela que abrir, e por fim em "Finish".

### Passo 3: Instalação do NetBeans
- Vá até o local onde o arquivo "Apache-NetBeans-23-bin-windows-x64.exe" foi baixado. Na pasta, inicie o mesmo.
- Em seguida, clique em "Sim" na janela que abrir. Depois, deve abrir um aplicativo chamado "Apache NetBeans IDE Installer".
- Em tal aplicativo, clique no botão "Next >". Depois, marque a opção "I accept de terms in the licence agreement", e em seguida clique em "Next >" mais uma vez.
- Se quiser que o NetBeans seja instalado em outra pasta, clique no botão "Browser..." do campo "Install the Apache NetBeans IDE to:" na página que abriu, e em seguida, localize em seu computador a pasta desejada.
- Caso você tenha outra JDK instalada, clique na seleção abaixo do campo "JDK for the Apache Netbeans IDE:", e localize a opção "jdk-21.0.5.11-hotspot".
- Ao finalizar, clique em "Next >", depois em "Install", e quando a instalação terminar, clique em "Finish".

### Passo 4: Abrindo o projeto no NetBeans
- Vá até a Área de Trabalho do seu computador, e inicie o aplicativo Apache NetBeans IDE 23.
- Quando ele abrir, clique em "File" no canto superior esquerdo, e depois em "Open Project...".
- Na janela que abrir, localize a pasta "Projeto-POO-main", baixada no Passo 1.
- Entre na pasta, e após isso, clique em "Projeto-POO-main" (a pasta com um ícone diferente), e depois clique em "Open Project". Na janela que abrir, clique em "Close".

### Passo 5: Instalação do Servidor usado
- Quando não houver mais nenhuma barra azul no canto inferior do aplicativo, vá até a página "Services", localizada logo acima do nome do projeto.
- Depois, clique com o botão direito sob a opção "Servers", e depois clique em "Add Server...".
- Na janela que abrir, clique em "GlassFish Server", e depois em "Next >".
- Em seguida, clique na seleção abaixo do campo "Choose a server to download:", e depois, localize e clique na opção "GlassFish Server 8.0.0".
- Após isso, marque na opção "I have read and accept the license agreement... (click)" clicando no pequeno quadrado ao lado do texto, e depois, clique na opção "Download Now..." e aguarde a instalação terminar.
- Quando acontecer, clique em "Next >", e depois em "Finish".
- Volte para a página "Projects". Depois, clique no nome do projeto (Learning_POO), e depois clique com o botão direito no mesmo lugar.
- Em seguida, localize e clique na opção "Resolve Missing Server Problem...".
- Depois, clique em "GlassFish Server", e depois em "OK".

### Passo 6: Conexão com o Banco de Dados
- Volte para a página "Services", e clique na seta para baixo ao lado da opção "Databases".
- Depois, clique com o botão direito em "Java DB", e depois em "Create Database...".
- No campo "Database Name:", escreva "POOPROJECT"; no campo "User Name:", escreva "usuario"; e nos campos "Password:" e "Confirm Password:", escreva "123".
- Quando aparecer a opção "jdbc:derby://localhost:1527/POOPROJECT [usuario on USUARIO]", clique com o botão direito na mesma, e depois selecione "Connect...".
- Em seguida, clique novamente com o botão direito, e selecione a opção "Execute Command...".
- No campo que abrir, copie (clique no ícone de folhetos dentro do campo) e cole (aperte Ctrl+V em seu teclado) o script disponível na [seção "Banco de Dados"](#banco-de-dados), e depois aperte ao mesmo tempo as seguintes teclas do seu teclado: Ctrl+Shift+E.
- Por fim, feche o NetBeans.

### Passo 7: Configurando a Variável de Ambiente da IA
- Copie o seguinte código: ``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``.
- Depois, vá até a barra de pesquisa da barra de ferramentas (no canto inferior do seu computador) e pesquise por "Editar as variáveis de ambiente do sistema", clicando na mesma opção que aparecer logo em seguida.
- Na nova janela que abrir, clique em "Variáveis de Ambiente...", e depois em "Novo...".
- No campo "Nome da variável:", insira o seguinte nome dentro das aspas: "API_KEY"; e no campo "Valor da variável:", cole o código copiado anteriormente.
- Por fim, clique em "OK", depois em "OK", e por último em "OK".

### Passo 8: Executando o projeto
- Abra novamente o NetBeans.
- Quando o aplicativo abrir e tudo acabar de carregar, clique no ícone da Terra, logo acima do nome do projeto, e então clique na opção "Chrome" (se ele estiver instalado), ou "Microsoft Edge".
- Depois, clique no nome do projeto (Learning_POO), e depois clique com o botão direito no mesmo lugar.
- Por fim, clique na opção "Run", e na nova janela, clique em "Permitir acesso".
<br>Quando o projeto abrir, você poderá explorar as funções do mesmo normalmente.

### Banco de Dados
Para o Passo 6 funcionar corretamente, copie e cole o seguinte script: (ele contém as tabelas usadas no projeto. Sem ele, as funcionalidades não funcionam)<br>
```
A Ser Adicionado...
```

## Autores do projeto
- [Miguel Menezes Serra](https://github.com/Miguel-Serra320)
- [Rafael Michalewicz Rodrigues](https://github.com/Michalewicz)
- [Sandro Gabriel dos Santos de Jesus](https://github.com/Sandro-Gab)
