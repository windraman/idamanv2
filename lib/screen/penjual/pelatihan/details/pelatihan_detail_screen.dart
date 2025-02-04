import 'package:flutter/material.dart';
import 'package:idaman/models/Pelatihan.dart';

import 'body.dart';

class PelatihanDetailScreen extends StatelessWidget {
  const PelatihanDetailScreen({Key? key}) : super(key: key);

  static String routeName = "pelatihandetail";
  @override
  Widget build(BuildContext context) {
    final pelatihanDetailScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as pelatihanDetailScreenArguments;
    return Body();
  }
}

class pelatihanDetailScreenArguments {
  final Data model;
  pelatihanDetailScreenArguments({required this.model});
}
