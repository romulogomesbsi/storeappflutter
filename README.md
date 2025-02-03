# Store App Flutter

Este é um projeto de aplicativo de loja desenvolvido em Flutter. O aplicativo permite que os usuários naveguem por categorias de produtos, visualizem detalhes dos produtos e adicionem produtos à lista de desejos.

## Arquitetura

O projeto segue a arquitetura limpa (Clean Architecture), que divide o código em camadas distintas para promover a separação de responsabilidades e facilitar a manutenção e escalabilidade do código.

### Camadas

- **Presentation (Apresentação)**: Contém as views (telas) e controllers que gerenciam a lógica de apresentação.
- **Domain (Domínio)**: Contém as entidades e use cases que representam as regras de negócio.
- **Data (Dados)**: Contém as implementações dos repositórios e fontes de dados (remotas e locais).

### Organização das Pastas

- `lib/`: Contém o código fonte do aplicativo.
  - `presentation/`: Contém as views e controllers.
    - `views/`: Contém as telas do aplicativo, como `products_view.dart` e `categories_view.dart`.
    - `controllers/`: Contém os controllers que gerenciam a lógica de apresentação.
    - `widgets/`: Contém os widgets reutilizáveis.
  - `domain/`: Contém as entidades e use cases.
    - `entities/`: Contém as entidades de domínio, como `category.dart` e `product.dart`.
    - `usecases/`: Contém os casos de uso, como `get_products_by_category.dart` e `get_wishlist.dart`.
    - `repositories/`: Contém as interfaces dos repositórios.
  - `data/`: Contém as implementações dos repositórios e fontes de dados.
    - `repositories/`: Contém as implementações dos repositórios, como `product_repository_impl.dart`.
    - `datasources/`: Contém as fontes de dados, como `product_remote_data_source.dart` e `product_local_data_source.dart`.
    - `models/`: Contém os modelos de dados.

## Bibliotecas Externas Utilizadas

- `flutter`: Framework principal para desenvolvimento do aplicativo.
- `get`: Biblioteca para gerenciamento de estado e navegação.
- `dartz`: Biblioteca para manipulação de tipos funcionais, como `Either`.

## Como Executar o Projeto

1. Certifique-se de ter o Flutter instalado em sua máquina.
2. Clone este repositório.
3. Navegue até o diretório do projeto.
4. Execute `flutter pub get` para instalar as dependências.
5. Execute `flutter run` para iniciar o aplicativo.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

---

Este README fornece uma visão geral da arquitetura, organização das pastas e bibliotecas externas utilizadas no projeto. Sinta-se à vontade para ajustá-lo conforme necessário para refletir melhor os detalhes específicos do seu projeto.
