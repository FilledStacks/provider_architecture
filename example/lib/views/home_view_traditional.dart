import 'package:example/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeViewTraditional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the withConsumer constructor gives you the traditional viewmodel
    // binding which will rebuild when notifyListeners is called. This is used
    // when the model does not have to be consumed by multiple different UI's.
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: UpdateTitleButton(),
        body: Center(
          child: Text(model.title),
        ),
      ),
    );
  }
}

class UpdateTitleButton extends ProviderWidget<HomeViewModel> {
  UpdateTitleButton({
    Key key,
  }) : super(key: key, listen: false);

  @override
  Widget build(BuildContext context, model) {
    return FloatingActionButton(
      onPressed: () {
        model.updateTitle();
      },
    );
  }
}
