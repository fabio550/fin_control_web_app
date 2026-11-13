import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

class FinanceEmptyState extends StatelessWidget {
  const FinanceEmptyState({super.key, required this.module});
  final FinanceModule module;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(40),
    child: Column(
      children: [
        Icon(module.icon, size: 36, color: Colors.blueGrey),
        const SizedBox(height: 12),
        const Text('Nenhum registro cadastrado.'),
        const SizedBox(height: 4),
        const Text(
          'Use o botão Adicionar para começar.',
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
