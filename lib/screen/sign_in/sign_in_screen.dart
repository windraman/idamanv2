import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {

    //print(args.rText);
    //for(String ln in args.rText){
    //   print("nik nya  ${args.rText[2]}");
    //}
    return const Scaffold(
    // appBar: AppBar(
    //   title: const Text("Mendaftar"),
    // ),
    body: Body(),
  );

  }
}

class SignInScreenArguments {
  final String ktpPath;
  final String recText;
  final String scannedNik;
  final String scannedNama;
  SignInScreenArguments({required this.ktpPath,required this.recText,required this.scannedNik,required this.scannedNama});
}
