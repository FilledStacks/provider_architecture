import 'package:observable_ish/observable_ish.dart';

class ReactiveService {
  List<Function> _listeners = List<Function>();

  void listenToReactiveValues(List<RxValue> reactiveValues) {
    for (var reactiveValue in reactiveValues) {
      reactiveValue.values.listen((value) {
        for (var listener in _listeners) {
          listener();
        }
      });
    }
  }

  void addListener(void Function() listener) {
    _listeners.add(listener);
  }
}
