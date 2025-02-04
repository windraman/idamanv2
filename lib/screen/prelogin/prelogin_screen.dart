import 'package:flutter/material.dart';
import 'package:idaman/screen/prelogin/components/body.dart';

import '../../size_config.dart';

class PreloginScreen extends StatelessWidget {
  const PreloginScreen({Key? key}) : super(key: key);

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

  static String routeName = "/prelogin";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PopScope(
      child: Scaffold(
        body: Body(),
        //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}
