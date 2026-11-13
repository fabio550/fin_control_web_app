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
