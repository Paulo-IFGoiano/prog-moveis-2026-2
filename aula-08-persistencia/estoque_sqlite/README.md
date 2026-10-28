# Estoque de Insumos — PROJETO-INICIAL (aula guiada)

Base para a aula prática de **CRUD com SQLite**, já na arquitetura de
camadas. Acompanhe o **Roteiro_Aula_Guiada_SQLite_CRUD.docx**.

## Estrutura

```
lib/
├── main.dart                       ← pronto (bootstrap do SQLite)
├── model/produto.dart              ← pronto (modelo)
├── data/
│   ├── app_database.dart           ← abrir banco pronto; CREATE TABLE = TODO (Passo 4)
│   └── produto_dao.dart            ← CRUD = TODO (Passo 5)
├── repository/produto_repository.dart  ← pronto (fachada)
└── telas/tela_produtos.dart        ← pronto (lista + formulário)
```

## O que você escreve na aula (foco do dia)
- **Passo 4** — o `CREATE TABLE produto (...)` em `data/app_database.dart`.
- **Passo 5** — os métodos `inserir`, `listar`, `atualizar`, `remover`
  em `data/produto_dao.dart`.

Os pontos a completar estão marcados com `TODO` e dicas no próprio código.

## Rodar

```bash
flutter create .
flutter pub get
flutter run -d linux   # ou -d windows / emulador Android
```

> Enquanto o CRUD não estiver implementado, o app abre mas as operações
> lançam `UnimplementedError` — é esperado: implemente e teste aos poucos.
