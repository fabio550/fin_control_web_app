import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:flutter/material.dart';

class FinanceEntryDialog extends StatefulWidget {
  const FinanceEntryDialog({super.key, required this.module});
  final FinanceModule module;
  @override
  State<FinanceEntryDialog> createState() => _FinanceEntryDialogState();
}

class _FinanceEntryDialogState extends State<FinanceEntryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = [
      for (final _ in widget.module.fields) TextEditingController(),
    ];
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text('Adicionar — ${widget.module.name}'),
    content: SizedBox(
      width: 460,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.module.fields.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _controllers[i],
                    autofocus: i == 0,
                    decoration: InputDecoration(
                      labelText: widget.module.fields[i],
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        !widget.module.fields[i].contains('(opcional)') &&
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
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      ),
      FilledButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pop(context, [
              for (final controller in _controllers) controller.text.trim(),
            ]);
          }
        },
        child: const Text('Salvar'),
      ),
    ],
  );
}
