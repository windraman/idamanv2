import 'package:flutter/material.dart';
import 'package:idaman/screen/penjual/bantuan/components/body.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({Key? key}) : super(key: key);

  static String routeName = "/bantuan";

  @override
  Widget build(BuildContext context) {

    return Body();
  }
}

class BantuanScreenArguments {
  final String idWarga;
  BantuanScreenArguments({required this.idWarga});
}
