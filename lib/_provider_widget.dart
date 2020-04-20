import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// A widget that provides a value passed through a provider as a parameter of the build function.
abstract class ProviderWidget<T> extends Widget {
  final bool listen;

  ProviderWidget({Key key, this.listen = true}) : super(key: key);

  @protected
  Widget build(BuildContext context, T model);

  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T> extends ComponentElement {
  _DataProviderElement(ProviderWidget widget) : super(widget);

  @override
  ProviderWidget get widget => super.widget;

  @override
  Widget build() =>
      widget.build(this, Provider.of<T>(this, listen: widget.listen));

  @override
  void update(ProviderWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
