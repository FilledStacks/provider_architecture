import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum _ViewModelProviderType { WithoutConsumer, WithConsumer }

/// A widget that provides base functionality for the Mvvm style provider architecture by FilledStacks.
class ViewModelProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget staticChild;

  /// Fires once when the viewmodel is created or set for the first time
  final Function(T) onModelReady;

  /// Builder function with access to the model to build UI form
  final Widget Function(BuildContext, T, Widget) builder;

  /// Deprecated: Use the viewModelBuilder for better ViewModel management
  final T viewModel;

  /// A builder function that returns the viewmodel for this widget
  final T Function() viewModelBuilder;

  /// Deprecated: Use the better named disposeViewModel property
  final bool reuseExisting;

  /// Indicates if you want Provider to dispose the viewmodel when it's removed from the widget tree.
  ///
  /// default's to true
  final bool disposeViewModel;

  /// When set to true a new ViewModel will be constructed everytime the widget is inserted.
  ///
  /// When setting this to true make sure to handle all disposing of streams if subscribed
  /// to any in the ViewModel. [onModelReady] will fire once the viewmodel has been created/set.
  /// This will be used when on re-insert of the widget the viewmodel has to be constructed with
  /// a new value.
  final bool createNewModelOnInsert;

  final _ViewModelProviderType providerType;

  /// Constructs a viewmodel provider that will not rebuild the provided widget when notifyListeners is called.
  ViewModelProvider.withoutConsumer({
    @required this.builder,
    @required this.viewModelBuilder,
    this.onModelReady,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
    @Deprecated('Use viewModelBuilder for better viewModel management')
        this.viewModel,
    @Deprecated('Use the better named disposeViewModel property')
        this.reuseExisting = false,
  })  : providerType = _ViewModelProviderType.WithoutConsumer,
        staticChild = null {
    assert(viewModel != null || viewModelBuilder != null,
        'You have to provide a viewmodel or a viewmodel builder');
  }

  /// Constructs a viewmodel provider that fires the builder function when notifyListeners is called in the viewmodel.
  ViewModelProvider.withConsumer({
    @required this.builder,
    @required this.viewModelBuilder,
    this.staticChild,
    this.onModelReady,
    this.disposeViewModel = true,
    this.createNewModelOnInsert = false,
    @Deprecated('Use viewModelBuilder for better viewModel management')
        this.viewModel,
    @Deprecated('Use the better named disposeViewModel property')
        this.reuseExisting = false,
  }) : providerType = _ViewModelProviderType.WithConsumer {
    assert(viewModel != null || viewModelBuilder != null,
        'You have to provide a viewmodel or a viewmodel builder');
  }

  @override
  _ViewModelProviderState<T> createState() => _ViewModelProviderState<T>();
}

class _ViewModelProviderState<T extends ChangeNotifier>
    extends State<ViewModelProvider<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    // We want to ensure that we only build the model if it hasn't been built yet.
    if (_model == null) {
      _createOrSetViewModel();

      if (widget.onModelReady != null) {
        widget.onModelReady(_model);
      }
    } else if (widget.createNewModelOnInsert) {
      _createOrSetViewModel();
    }
  }

  void _createOrSetViewModel() {
    if (widget.viewModelBuilder != null) {
      _model = widget.viewModelBuilder();
    } else {
      _model = widget.viewModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == _ViewModelProviderType.WithoutConsumer) {
      if (widget.reuseExisting || widget.disposeViewModel) {
        return ChangeNotifierProvider.value(
          value: _model,
          child: widget.builder(context, _model, widget.staticChild),
        );
      }

      return ChangeNotifierProvider(
        create: (context) => _model,
        child: widget.builder(context, _model, widget.staticChild),
      );
    }

    if (widget.reuseExisting || widget.disposeViewModel) {
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
