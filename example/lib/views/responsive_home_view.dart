import 'package:example/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the ViewModelProvider without consumer won't cause the builder passed in to rebuild
    // Instead it will only expose the ViewModel as a provided value to the widget produced by the builder.
    // This is then used together with the ProviderWidget to consume the model through the build function
    // See HomeMobileTablet or Portrait for an example of getting the model passed down in the build function.
    return ViewModelProvider<HomeViewModel>.withoutConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, _, __) => ScreenTypeLayout(
        mobile: OrientationLayoutBuilder(
          portrait: (context) => HomeMobilePortrait(),
          landscape: (context) => HomeMobileLandscape(),
        ),
        tablet: HomeViewTablet(),
      ),
    );
  }
}
