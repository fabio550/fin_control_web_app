import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

class FinanceSidebar extends StatelessWidget {
  const FinanceSidebar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Icon(Icons.account_balance, color: Color(0xFF2563EB)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Fin Control',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
          child: Text(
            'GESTÃO FINANCEIRA',
            style: TextStyle(fontSize: 11, letterSpacing: 1.5),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: financeModules.length,
            itemBuilder: (context, index) {
              final module = financeModules[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: ListTile(
                  selected: selectedIndex == index,
                  selectedTileColor: const Color(0xFFEFF6FF),
                  selectedColor: const Color(0xFF1D4ED8),
                  shape: const Border(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 28),
                  leading: Icon(module.icon, size: 21),
                  title: Text(
                    module.name,
                    style: const TextStyle(fontSize: 13),
                  ),
                  onTap: () => onSelected(index),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
