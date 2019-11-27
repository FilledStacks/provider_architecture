import 'package:example/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the withConsumer constructor gives you the traditional viewmodel
    // binding which will rebuild when notifyListeners is called. This is used
    // when the model does not have to be consumed by multiple different UI's.
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
          },
        ),
        body: Center(
          child: Text(model.title),
        ),
      ),
    );
  }
}
