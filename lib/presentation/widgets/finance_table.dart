import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

import 'finance_empty_state.dart';

class FinanceTable extends StatelessWidget {
  const FinanceTable({super.key, required this.module, required this.rows});
  final FinanceModule module;
  final List<List<String>> rows;
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: const WidgetStatePropertyAll(Color(0xFFF1F5F9)),
            columns: [
              for (final field in module.fields) DataColumn(label: Text(field)),
            ],
            rows: [
              for (final row in rows)
                DataRow(
                  cells: [
                    for (final value in row)
                      DataCell(Text(value.isEmpty ? '—' : value)),
                  ],
                ),
            ],
          ),
        ),
        if (rows.isEmpty) FinanceEmptyState(module: module),
      ],
    ),
  );
}
