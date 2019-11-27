import 'package:example/datamodel/human.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DuplicateNameWidget extends ProviderWidget<Human> {
  @override
  Widget build(BuildContext context, Human model) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(model.name),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          child: Text(model.name),
        ),
      ],
    );
  }
}
