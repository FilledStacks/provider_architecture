import 'package:example/viewmodels/home_viewmodel.dart';
import 'package:example/widgets/description_section.dart';
import 'package:example/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class HomeViewMultipleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withoutConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[TitleSection(), DescriptionSection()],
        ),
      ),
    );
  }
}
