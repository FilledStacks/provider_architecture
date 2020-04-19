import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../lib/provider_architecture.dart';

void main() {
  testWidgets('ProviderWidget', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => MyProvider(0),
      child: MyApp(),
    ));

    expect(find.text('0'), findsOneWidget);
  });

  testWidgets("ViewModelProvider with Consumer", (WidgetTester tester) async {
    await tester.pumpWidget(
      ViewModelProvider<MyProvider>.withConsumer(
        viewModel: MyProvider(0),
        builder: (context, model, child) => MaterialApp(
            home: Scaffold(
          body: Text(
            model.count.toString(),
            textDirection: TextDirection.ltr,
          ),
          floatingActionButton: FloatingActionButton(
            key: Key("fabButton"),
            onPressed: () => model.increment(),
            child: Icon(Icons.add),
          ),
        )),
      ),
    );
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byType(Icon));
    await tester.pump();
    // We should be able to find Text with value 1
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets("ViewModelProvider without Consumer",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ViewModelProvider<MyProvider>.withoutConsumer(
        viewModel: MyProvider(0),
        builder: (context, model, child) => MaterialApp(
            home: Scaffold(
          body: Text(
            model.count.toString(),
            textDirection: TextDirection.ltr,
          ),
          floatingActionButton: FloatingActionButton(
            key: Key("fabButton"),
            onPressed: () => model.increment(),
            child: Icon(Icons.add),
          ),
        )),
      ),
    );
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byType(Icon));
    await tester.pump();
    // We should not be able to find Text with value 1
    expect(find.text('1'), findsNothing);
  });
}

class MyApp extends ProviderWidget<MyProvider> {
  MyApp() : super(listen: true);

  @override
  Widget build(BuildContext context, model) {
    return Text(
      model.count.toString(),
      textDirection: TextDirection.ltr,
    );
  }
}

class MyProvider extends ChangeNotifier {
  int count;

  MyProvider(this.count);

  increment() {
    count++;
    notifyListeners();
  }
}
