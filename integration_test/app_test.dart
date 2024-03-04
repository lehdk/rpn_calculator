import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// Replace with your app name
import 'package:rpn_calculator/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Change name of test to something that makes sense for your app
  testWidgets('Test calculator', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Expect initial display to be "0"

    final display = find.byKey(const Key("display"));

    expect(display, findsOneWidget);

    var displayValue = tester.widget<Text>(display).data;

    expect(displayValue, "0");

    // Press button 7

    final btn7 = find.byKey(const Key("btn_7"));
    expect(btn7, findsOneWidget);

    await tester.tap(btn7);

    await tester.pump();

    displayValue = tester.widget<Text>(display).data;

    expect(displayValue, "7 = 7");

    // Press push button

    final btnPush = find.byKey(const Key("btn_push"));
    expect(btnPush, findsOneWidget);

    await tester.tap(btnPush);

    await tester.pump();

    displayValue = tester.widget<Text>(display).data;

    expect(displayValue, "7 0 = 0");

    // Press 5

    final btn5 = find.byKey(const Key("btn_5"));
    expect(btn5, findsOneWidget);

    await tester.tap(btn5);

    await tester.pump();

    displayValue = tester.widget<Text>(display).data;

    expect(displayValue, "7 5 = 5");

    // Press plus

    final btnAdd = find.byKey(const Key("btn_+"));
    expect(btnAdd, findsOneWidget);

    await tester.tap(btnAdd);

    await tester.pump();

    displayValue = tester.widget<Text>(display).data;

    expect(displayValue, "7 5 + = 12");

    // Test clear button

    final btnClear = find.byKey(const Key("btn_C"));
    expect(btnClear, findsOneWidget);

    await tester.tap(btnClear);

    await tester.pump();

    displayValue = tester.widget<Text>(display).data;

    expect(displayValue, "0");
  });
}