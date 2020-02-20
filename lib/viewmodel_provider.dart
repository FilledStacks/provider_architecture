import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum _ViewModelProviderType { WithoutConsumer, WithConsumer }

/// A widget that provides base functionality for the Mvvm style provider architecture by FilledStacks.
class ViewModelProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget staticChild;
  final Function(T) onModelReady;
  final Widget Function(BuildContext, T, Widget) builder;
  final T viewModel;
  final _ViewModelProviderType providerType;
  final bool reuseExisting;

  ViewModelProvider.withoutConsumer({
    @required this.builder,
    @required this.viewModel,
    this.onModelReady,
    this.reuseExisting = false,
  })  : providerType = _ViewModelProviderType.WithoutConsumer,
        staticChild = null;

  ViewModelProvider.withConsumer({
    @required this.viewModel,
    @required this.builder,
    this.staticChild,
    this.onModelReady,
    this.reuseExisting = false,
  }) : providerType = _ViewModelProviderType.WithConsumer;

  @override
  _ViewModelProviderState<T> createState() => _ViewModelProviderState<T>();
}

class _ViewModelProviderState<T extends ChangeNotifier>
    extends State<ViewModelProvider<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.viewModel;

    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == _ViewModelProviderType.WithoutConsumer) {
      if (widget.reuseExisting) {
        return ChangeNotifierProvider.value(
          value: _model,
          child: widget.builder(context, _model, null),
        );
      }

      return ChangeNotifierProvider(
        create: (context) => _model,
        child: widget.builder(context, _model, null),
      );
    }

    if (widget.reuseExisting) {
      return ChangeNotifierProvider.value(
        value: _model,
        child: Consumer(
          builder: widget.builder,
          child: widget.staticChild,
        ),
      );
    }
    
    return ChangeNotifierProvider(
      create: (context) => _model,
      child: Consumer(
        builder: widget.builder,
        child: widget.staticChild,
      ),
    );
  }
}
