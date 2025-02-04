import 'package:flutter/material.dart';
import 'package:idaman/models/UmkmData.dart';

import 'components/body.dart';

class UsahaScreen extends StatelessWidget {
  static String routeName = "/usaha";
  @override
  Widget build(BuildContext context) {
    final UsahaScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as UsahaScreenArguments;
    return Scaffold(
      body: Body(usaha: args.usaha,selTab: 0),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}

class UsahaScreenArguments {
  final String namaUsaha;
  final int idUsaha;
  final Umkm usaha;
  UsahaScreenArguments({required this.namaUsaha,required this.idUsaha, required this.usaha});
}
