import 'package:flutter/material.dart';

class FinanceModule {
  const FinanceModule(this.name, this.description, this.icon, this.fields);

  final String name;
  final String description;
  final IconData icon;
  final List<String> fields;
}

const financeModules = [
  FinanceModule(
    'Accounts',
    'Contas correntes, dinheiro e cartões unificados',
    Icons.account_balance_wallet_outlined,
    ['Nome', 'Tipo', 'Saldo inicial'],
  ),
  FinanceModule(
    'Invoices',
    'Faturas mensais de cartão de crédito',
    Icons.receipt_long_outlined,
    ['Conta / cartão', 'Mês de referência', 'Vencimento', 'Valor'],
  ),
  FinanceModule(
    'Merchants',
    'Estabelecimentos e comércios',
    Icons.storefront_outlined,
    ['Nome', 'Documento'],
  ),
  FinanceModule(
    'Categories',
    'Categorias e subcategorias',
    Icons.account_tree_outlined,
    ['Nome', 'Categoria pai (opcional)'],
  ),
  FinanceModule('Tags', 'Etiquetas transversais livres', Icons.sell_outlined, [
    'Nome',
    'Descrição (opcional)',
  ]),
  FinanceModule('Transactions', 'Fluxo de caixa e extrato', Icons.swap_horiz, [
    'Descrição',
    'Conta',
    'Categoria',
    'Data',
    'Valor',
  ]),
  FinanceModule(
    'TransactionTags',
    'Ligação entre transações e tags',
    Icons.link,
    ['Transação', 'Tag'],
  ),
  FinanceModule(
    'LoanContracts',
    'Contratos de empréstimos e financiamentos',
    Icons.handshake_outlined,
    ['Descrição', 'Credor', 'Valor contratado', 'Taxa de juros (%)'],
  ),
  FinanceModule(
    'LoanInstallments',
    'Parcelas, juros e amortização',
    Icons.calendar_month_outlined,
    ['Contrato', 'Número da parcela', 'Vencimento', 'Juros', 'Amortização'],
  ),
  FinanceModule(
    'Products',
    'Catálogo de itens, preços e marcas',
    Icons.inventory_2_outlined,
    ['Nome', 'Marca', 'Unidade'],
  ),
  FinanceModule(
    'TransactionItems',
    'Itens detalhados da nota fiscal',
    Icons.list_alt_outlined,
    ['Transação', 'Produto', 'Quantidade', 'Preço unitário'],
  ),
  FinanceModule(
    'Budgets',
    'Metas de orçamento por categoria',
    Icons.savings_outlined,
    ['Categoria', 'Mês de referência', 'Limite'],
  ),
  FinanceModule(
    'RecurringTransactions',
    'Assinaturas e lançamentos recorrentes',
    Icons.event_repeat,
    ['Descrição', 'Conta', 'Valor', 'Periodicidade', 'Próximo lançamento'],
  ),
];
