import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

import '../navigation/sidebar_destination.dart';
import 'sidebar_button.dart';

class FinanceSidebar extends StatelessWidget {
  const FinanceSidebar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.destination,
    required this.onDestinationSelected,
    required this.tablesExpanded,
    required this.onToggleTables,
  });
  final SidebarDestination destination;
  final ValueChanged<SidebarDestination> onDestinationSelected;
  final bool tablesExpanded;
  final VoidCallback onToggleTables;
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SidebarButton(
                label: 'Tabela',
                icon: Icons.table_chart_outlined,
                selected: destination == SidebarDestination.tables,
                trailing: Icon(
                  tablesExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                onTap: onToggleTables,
              ),
              if (tablesExpanded)
                for (var index = 0; index < financeModules.length; index++)
                  SidebarButton(
                    label: financeModules[index].name,
                    icon: financeModules[index].icon,
                    indented: true,
                    selected:
                        destination == SidebarDestination.tables &&
                        selectedIndex == index,
                    onTap: () => onSelected(index),
                  ),
              SidebarButton(
                label: 'Dashboard',
                icon: Icons.dashboard_outlined,
                selected: destination == SidebarDestination.dashboard,
                onTap: () =>
                    onDestinationSelected(SidebarDestination.dashboard),
              ),
              SidebarButton(
                label: 'Configurações',
                icon: Icons.settings_outlined,
                selected: destination == SidebarDestination.settings,
                onTap: () => onDestinationSelected(SidebarDestination.settings),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
