import 'package:fin_control_web_app/domain/finance_module.dart';
import 'package:fin_control_web_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Every module opens a table and an add form', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Tabela'));
    await tester.pumpAndSettle();
    for (final module in financeModules) {
      final tile = find.widgetWithText(ListTile, module.name);
      await tester.ensureVisible(tile);
      await tester.tap(tile);
      await tester.pumpAndSettle();
      expect(find.byType(DataTable), findsOneWidget);
      await tester.tap(find.text('Adicionar ${module.name}'));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(module.fields.length));
      await tester.tap(find.text('Salvar'));
      await tester.pumpAndSettle();
      expect(find.text('Preencha este campo'), findsWidgets);
      for (var i = 0; i < module.fields.length; i++) {
        await tester.enterText(
          find.byType(TextFormField).at(i),
          '${module.name} $i',
        );
      }
      await tester.tap(find.text('Salvar'));
      await tester.pumpAndSettle();
      expect(find.text('${module.name} 0'), findsOneWidget);
    }
    await tester.ensureVisible(find.widgetWithText(ListTile, 'Accounts'));
    await tester.tap(find.widgetWithText(ListTile, 'Accounts'));
    await tester.pumpAndSettle();
    expect(find.text('Accounts 0'), findsOneWidget);
    await tester.ensureVisible(find.widgetWithText(ListTile, 'Tabela'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tabela'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ListTile, 'Accounts'), findsNothing);
    await tester.tap(find.widgetWithText(ListTile, 'Dashboard'));
    await tester.pumpAndSettle();
    expect(
      find.text('Os indicadores financeiros serão disponibilizados aqui.'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(ListTile, 'Configurações'));
    await tester.pumpAndSettle();
    expect(
      find.text('As preferências do aplicativo serão disponibilizadas aqui.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Tabela'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Accounts'));
    await tester.pumpAndSettle();
    expect(find.text('Accounts 0'), findsOneWidget);
  });

  testWidgets('Mobile navigation uses a drawer and cancel adds no row', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tabela'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Tags'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Adicionar Tags'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(find.text('0 registro(s)'), findsOneWidget);
  });
}
