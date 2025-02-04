
import 'package:flutter/material.dart';
import 'package:idaman/helper/location_service.dart';

import '../../../enums.dart';
import 'components/body.dart';
import 'components/coustom_bottom_nav_bar.dart';


class PenjualHomeScreen extends StatelessWidget {
  const PenjualHomeScreen({Key? key}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Mau Keluar Aplikasi Idaman?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Yes'),
        ),
      ],
    );
  }

  static String routeName = "/penjualHome";
  @override
  Widget build(BuildContext context) {
    LocationService ls = new LocationService();


    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );

  }

}


