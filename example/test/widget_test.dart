import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the names and surnames are displayed properly
    expect(find.text('Dane'), findsWidgets);
    expect(find.text('Mackier'), findsOneWidget);
  });
}
