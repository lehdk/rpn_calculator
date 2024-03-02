import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// Replace with your app name
import 'package:rpn_calculator/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Change name of test to something that makes sense for your app
  testWidgets('Test MyApp', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // TODO write your test code here
  });
}