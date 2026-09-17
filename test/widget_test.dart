// A basic Flutter widget smoke test for the calculator UI.
//
// It drives the on-screen buttons (2 + 3 =) and checks that the
// display shows the correct result, exercising the app end-to-end
// rather than just the underlying Calculator logic.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator_app/main.dart';

void main() {
  testWidgets('pressing 2 + 3 = shows 5 on the display', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final display = find.byKey(const Key('display'));

    // Verify the display starts at 0.
    expect(tester.widget<Text>(display).data, '0');

    await tester.tap(find.widgetWithText(ElevatedButton, '2'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '3'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();

    expect(tester.widget<Text>(display).data, '5');
  });
}
