import 'package:example/viewmodels/home_viewmodel.dart';

/// Contains the widgets that will be used for Mobile layout of home,
/// portrait and landscape

import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeMobilePortrait extends ProviderWidget<HomeViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.updateTitle();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(Icons.menu, size: 30),
              onPressed: () {
                _scaffoldKey?.currentState?.openDrawer();
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text(model.title),
            ),
          )
        ],
      ),
    );
  }
}

class HomeMobileLandscape extends ProviderWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                model.title,
                style: TextStyle(fontSize: 35),
              ),
            ),
          )
        ],
      ),
    );
  }
}
