# Peneiras App FrontEnd

Uma aplicação Flutter completa projetada para gerenciar peneiras para clubes esportivos e jogadores individuais.

## Descrição

O Peneiras App FrontEnd é um aplicativo mobile e web construído em Flutter, voltado para otimizar o processo de organização e participação em peneiras esportivas. Ele permite que clubes criem e gerenciem eventos de testes, e que jogadores descubram e se inscrevam nessas oportunidades. O aplicativo oferece recursos de autenticação de usuários, gerenciamento de perfis para jogadores e clubes, além de visualizações detalhadas dos eventos.

## Sumário

- [Descrição](#descrição)
- [Sumário](#sumário)
- [Funcionalidades](#funcionalidades)
- [Tecnologias](#tecnologias)
- [Instalação](#instalação)
- [Uso](#uso)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuindo](#contribuindo)
- [Links Importantes](#links-importantes)

## Funcionalidades

- **Autenticação de Usuário:** Login e cadastro seguros para jogadores e clubes.
- **Gerenciamento de Perfil:** Seções de perfil dedicadas para jogadores e clubes gerenciarem suas informações.
- **Gerenciamento de Peneiras:** Clubes podem criar, editar e visualizar detalhes de seus eventos de testes.
- **Inscrição de Jogadores:** Jogadores podem descobrir e se inscrever em peneiras disponíveis.
- **Design Responsivo:** Adapta-se a vários tamanhos de tela para uma experiência perfeita no mobile e na web.
- **Navegação Organizada:** Barra de abas e rotas claras para fácil acesso a diferentes seções do aplicativo.

## Tecnologias

- **Linguagem:** Dart
- **Framework:** Flutter
- **Deploy na Web:** Vercel (configuração encontrada em `vercel.json`)
- **Plataformas Específicas:** Configurações para iOS (`ios/`) e Android (`android/`).
- **Configuração:** YAML para opções de análise (`analysis_options.yaml`), JSON para manifesto web (`web/manifest.json`).

## Instalação

Este projeto foi construído com Flutter. Para começar, você precisa ter o Flutter instalado em seu sistema.

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/Victor1669/Peneiras-App-FrontEnd.git
   cd Peneiras-App-FrontEnd
   ```

2. **Instale as dependências:**
   Navegue até o diretório do projeto e execute:
   ```bash
   flutter pub get
   ```

3. **Execute a aplicação:**
   Você pode rodar o aplicativo em um emulador, dispositivo físico ou como aplicação web:
   ```bash
   flutter run
   ```

   Para web, certifique-se de ter um dispositivo compatível ou use a configuração de execução:
   ```bash
   flutter run -d chrome
   ```

## Uso

O Peneiras App FrontEnd foi desenvolvido para atender a dois tipos principais de usuários: jogadores e clubes esportivos.

**Para Jogadores:**
- Descobrir eventos de peneiras futuros.
- Visualizar detalhes de cada peneira, incluindo requisitos e localização.
- Inscrever-se em peneiras compatíveis com o seu perfil.
- Gerenciar informações do perfil pessoal.

**Para Clubes:**
- Criar e gerenciar eventos de peneiras, especificando datas, horários e requisitos dos atletas.
- Visualizar jogadores inscritos para cada peneira.
- Gerenciar informações do perfil do clube.

### Casos de Uso no Mundo Real

- **Descoberta de Talentos:** Clubes esportivos podem organizar e promover de forma eficiente seus eventos de peneiras para atrair novos talentos.
- **Oportunidades para Atletas:** Atletas aspirantes podem encontrar e se candidatar facilmente a peneiras relevantes para o seu esporte e nível de habilidade.
- **Gerenciamento de Eventos:** Fornece uma plataforma centralizada para gerenciar todos os aspectos dos eventos de peneiras, desde a criação até o rastreamento de participantes.

## Estrutura do Projeto

O projeto segue a estrutura padrão de projetos Flutter:

```
Peneiras-App-FrontEnd/
├── android/
├── ios/
├── lib/
│   ├── constants/
│   ├── layout/
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── services/
│   ├── utils/
│   └── widgets/
├── test/
├── web/
├── .metadata
├── analysis_options.yaml
├── pubspec.lock
└── pubspec.yaml
```

- **`lib/`**: Contém o código principal da aplicação.
  - **`constants/`**: Constantes globais como cores.
  - **`layout/`**: Define a estrutura geral da interface e layouts.
  - **`models/`**: Modelos de dados para jogadores, clubes, peneiras, etc.
  - **`providers/`**: Controladores de gerenciamento de estado.
  - **`screens/`**: Telas diferentes da aplicação (login, início, perfis, etc.).
  - **`services/`**: Serviço de API e lógica de negócios.
  - **`utils/`**: Funções auxiliares e utilitários.
  - **`widgets/`**: Componentes de interface reutilizáveis.
- **`web/`**: Configurações específicas para web e ponto de entrada (`index.html`).
- **`ios/` e `android/`**: Arquivos de projeto específicos de cada plataforma.
- **`pubspec.yaml`**: Dependências e metadados do projeto.

## Contribuindo

Contribuições são bem-vindas! Se você deseja contribuir, por favor:

1. Faça um fork do repositório.
2. Crie uma nova branch para sua funcionalidade ou correção de bug.
3. Faça suas alterações e realize o commit.
4. Envie um pull request.

Certifique-se de que seu código siga os padrões do projeto e inclua testes onde apropriado.

## Links Importantes

- **Repositório:** [Peneiras-App-FrontEnd](https://github.com/Victor1669/Peneiras-App-FrontEnd)
- **Demonstração ao Vivo:** (Nenhuma URL de demonstração informada)
