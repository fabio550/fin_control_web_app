import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

import 'finance_module_page.dart';
import 'dashboard_page.dart';
import 'settings_page.dart';
import '../navigation/sidebar_destination.dart';
import '../widgets/finance_sidebar.dart';
import '../widgets/finance_entry_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selected = 0;
  SidebarDestination _destination = SidebarDestination.tables;
  bool _tablesExpanded = false;
  final Map<String, List<List<String>>> _records = {};

  void _select(int index, {bool closeDrawer = false}) {
    setState(() {
      _selected = index;
      _destination = SidebarDestination.tables;
    });
    if (closeDrawer) Navigator.of(context).pop();
  }

  void _selectDestination(
    SidebarDestination destination, {
    bool closeDrawer = false,
  }) {
    setState(() => _destination = destination);
    if (closeDrawer) Navigator.of(context).pop();
  }

  void _toggleTables() => setState(() => _tablesExpanded = !_tablesExpanded);

  Future<void> _add(FinanceModule module) async {
    final record = await showDialog<List<String>>(
      context: context,
      builder: (context) => FinanceEntryDialog(module: module),
    );
    if (!mounted || record == null) return;
    setState(() => _records.putIfAbsent(module.name, () => []).add(record));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Registro adicionado.')));
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 1000;
      final module = financeModules[_selected];
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: wide ? null : AppBar(title: const Text('Fin Control')),
        drawer: wide
            ? null
            : Drawer(
                width: 290,
                child: FinanceSidebar(
                  selectedIndex: _selected,
                  destination: _destination,
                  tablesExpanded: _tablesExpanded,
                  onToggleTables: _toggleTables,
                  onDestinationSelected: (destination) =>
                      _selectDestination(destination, closeDrawer: true),
                  onSelected: (index) => _select(index, closeDrawer: true),
                ),
              ),
        body: Row(
          children: [
            if (wide) ...[
              SizedBox(
                width: 290,
                child: Material(
                  color: Colors.white,
                  child: FinanceSidebar(
                    selectedIndex: _selected,
                    destination: _destination,
                    tablesExpanded: _tablesExpanded,
                    onToggleTables: _toggleTables,
                    onDestinationSelected: _selectDestination,
                    onSelected: _select,
                  ),
                ),
              ),
              const VerticalDivider(width: 1),
            ],
            Expanded(
              child: SafeArea(
                child: switch (_destination) {
                  SidebarDestination.tables => FinanceModulePage(
                    module: module,
                    rows: _records[module.name] ?? [],
                    onAdd: () => _add(module),
                  ),
                  SidebarDestination.dashboard => const DashboardPage(),
                  SidebarDestination.settings => const SettingsPage(),
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
