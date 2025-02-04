import 'package:flutter/material.dart';
import 'package:idaman/models/Register.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  static String routeName = "/otp";


  @override
  Widget build(BuildContext context) {
    final OtpScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as OtpScreenArguments;

    return WillPopScope(
      onWillPop: () async {
        print('The user tries to pop()');
        return false;
      },
      child: Scaffold(
        body: Body(model: args.model),
      ),
    );
  }
}

class OtpScreenArguments {
  final RegisterModel model;
  OtpScreenArguments({required this.model});
}
