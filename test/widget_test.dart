import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mini_tasks/main.dart';
import 'package:flutter_mini_tasks/task2_interactive_ui.dart';

Color _colorOf(WidgetTester tester, String key) {
  final container = tester.widget<Container>(find.byKey(Key(key)));
  return container.color!;
}

void main() {
  testWidgets('Task 2: counter increments and colour box toggles',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: InteractiveBoxesScreen()),
    );

    expect(find.text('0'), findsOneWidget);
    expect(_colorOf(tester, 'colorBox'), Colors.green);

    await tester.tap(find.byKey(const Key('yellowBox')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(_colorOf(tester, 'colorBox'), Colors.blue);

    await tester.tap(find.byKey(const Key('yellowBox')));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    expect(_colorOf(tester, 'colorBox'), Colors.green);
  });

  testWidgets('Task 4: cart state is shared between screens', (tester) async {
    await tester.pumpWidget(const MiniTasksApp());

    await tester.tap(find.text('Task 4: Shared-state Cart'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('add_1')));
    await tester.tap(find.byKey(const Key('add_1')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('openCart')));
    await tester.pumpAndSettle();

    expect(find.text('Headphones'), findsOneWidget);
    expect(find.text('Total: \$119.98'), findsOneWidget);
  });
}
