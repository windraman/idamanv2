import 'package:flutter/material.dart';
import 'package:idaman/screen/penjual/pelatihan/components/body.dart';

class PelatihanScreen extends StatelessWidget {
  const PelatihanScreen({Key? key}) : super(key: key);

  static String routeName = "/pelatihan";

  @override
  Widget build(BuildContext context) {

    return Body();
  }
}

class pelatihanScreenArguments {
  final String idWarga;
  pelatihanScreenArguments({required this.idWarga});
}
