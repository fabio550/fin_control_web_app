import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

import '../widgets/finance_table.dart';

class FinanceModulePage extends StatelessWidget {
  const FinanceModulePage({
    super.key,
    required this.module,
    required this.rows,
    required this.onAdd,
  });
  final FinanceModule module;
  final List<List<String>> rows;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(24),
    children: [
      Text(
        module.name,
        style: Theme.of(context).textTheme.headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        module.description,
        style: const TextStyle(color: Color(0xFF64748B)),
      ),
      const SizedBox(height: 24),
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 24,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '${rows.length} registro(s)',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text('Adicionar ${module.name}'),
          ),
        ],
      ),
      const SizedBox(height: 16),
      FinanceTable(module: module, rows: rows),
    ],
  );
}
