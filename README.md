# Fin Control

Aplicativo Flutter com menu lateral para Accounts, Invoices, Merchants, Categories,
Tags, Transactions, TransactionTags, LoanContracts, LoanInstallments, Products,
TransactionItems, Budgets e RecurringTransactions.

Cada seção possui tabela, estado vazio e formulário de inclusão com validação de
campos obrigatórios. Em telas menores, o menu fica em um drawer.

Os registros são mantidos em memória durante a sessão. Recarregar ou reiniciar o
aplicativo limpa os registros. Integração com banco de dados, relacionamentos por
identificador e validação financeira dos campos são etapas futuras; os campos
atuais são textuais e não executam cálculos financeiros.

## Executar

Com Flutter compatível com o SDK definido em `pubspec.yaml`:

```sh
flutter pub get
flutter run -d chrome
```

## Verificar

```sh
flutter analyze
flutter test
flutter build web
```

## Organização da interface

- `lib/presentation/pages/home_page.dart`: estado da sessão e navegação responsiva.
- `lib/presentation/pages/finance_module_page.dart`: composição da página de um módulo.
- `lib/presentation/widgets/finance_sidebar.dart`: menu lateral.
- `lib/presentation/widgets/finance_table.dart`: tabela de registros.
- `lib/presentation/widgets/finance_empty_state.dart`: apresentação da tabela vazia.
- `lib/presentation/widgets/finance_entry_dialog.dart`: formulário de inclusão,
  validação e ciclo de vida dos controladores. Retorna os dados à página ao salvar.
