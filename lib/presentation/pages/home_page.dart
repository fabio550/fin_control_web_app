import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selected = 0;
  final Map<String, List<List<String>>> _records = {};

  void _select(int index, {bool closeDrawer = false}) {
    setState(() => _selected = index);
    if (closeDrawer) Navigator.of(context).pop();
  }

  Widget _navigation(bool drawer) => SafeArea(
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: financeModules.length,
            itemBuilder: (context, index) {
              final module = financeModules[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: ListTile(
                  selected: _selected == index,
                  selectedTileColor: const Color(0xFFEFF6FF),
                  selectedColor: const Color(0xFF1D4ED8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: Icon(module.icon, size: 21),
                  title: Text(
                    module.name,
                    style: const TextStyle(fontSize: 13),
                  ),
                  onTap: () => _select(index, closeDrawer: drawer),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  Future<void> _add(FinanceModule module) async {
    final formKey = GlobalKey<FormState>();
    final controllers = [
      for (final _ in module.fields) TextEditingController(),
    ];
    final route = DialogRoute<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar — ${module.name}'),
        content: SizedBox(
          width: 460,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < module.fields.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        controller: controllers[i],
                        autofocus: i == 0,
                        decoration: InputDecoration(
                          labelText: module.fields[i],
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            !module.fields[i].contains('(opcional)') &&
                                (value == null || value.trim().isEmpty)
                            ? 'Preencha este campo'
                            : null,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    final saved = await Navigator.of(context).push(route);
    if (saved == true && mounted) {
      setState(
        () => _records.putIfAbsent(module.name, () => []).add([
          for (final controller in controllers) controller.text.trim(),
        ]),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Registro adicionado.')));
    }
    await route.completed;
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  Widget _page(FinanceModule module) {
    final rows = _records[module.name] ?? [];
    return ListView(
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
              onPressed: () => _add(module),
              icon: const Icon(Icons.add),
              label: Text('Adicionar ${module.name}'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: const WidgetStatePropertyAll(
                    Color(0xFFF1F5F9),
                  ),
                  columns: [
                    for (final field in module.fields)
                      DataColumn(label: Text(field)),
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
              if (rows.isEmpty)
                Padding(
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
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 1000;
      final module = financeModules[_selected];
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: wide ? null : AppBar(title: const Text('Fin Control')),
        drawer: wide ? null : Drawer(width: 290, child: _navigation(true)),
        body: Row(
          children: [
            if (wide) ...[
              SizedBox(
                width: 290,
                child: Material(color: Colors.white, child: _navigation(false)),
              ),
              const VerticalDivider(width: 1),
            ],
            Expanded(child: SafeArea(child: _page(module))),
          ],
        ),
      );
    },
  );
}
