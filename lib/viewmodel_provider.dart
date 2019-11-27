import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _ViewModelProviderType { WithoutConsumer, WithConsumer }

/// A widget that provides base functionality for the Mvvm style provider architecture by FilledStacks.
class ViewModelProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget staticChild;
  final Function(T) onModelReady;
  final Widget Function(BuildContext, T, Widget) builder;
  final T viewModel;
  final _ViewModelProviderType providerType;

  ViewModelProvider.withoutConsumer({
    @required this.builder,
    @required this.viewModel,
    this.onModelReady,
  })  : providerType = _ViewModelProviderType.WithoutConsumer,
        staticChild = null;

  ViewModelProvider.withConsumer({
    @required this.viewModel,
    @required this.builder,
    this.staticChild,
    this.onModelReady,
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
      return ChangeNotifierProvider(
        builder: (context) => _model,
        child: widget.builder(context, null, null),
      );
    }

    return ChangeNotifierProvider(
      builder: (context) => _model,
      child: Consumer(
        builder: widget.builder,
        child: widget.staticChild,
      ),
    );
  }
}
