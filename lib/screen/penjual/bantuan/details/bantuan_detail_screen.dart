import 'package:flutter/material.dart';
import 'package:idaman/models/Bantuan.dart';

import 'body.dart';

class BantuanDetailScreen extends StatelessWidget {
  const BantuanDetailScreen({Key? key}) : super(key: key);

  static String routeName = "bantuandetail";
  @override
  Widget build(BuildContext context) {
    final BantuanDetailScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as BantuanDetailScreenArguments;
    return Body();
  }
}

class BantuanDetailScreenArguments {
  final Data model;
  BantuanDetailScreenArguments({required this.model});
}
