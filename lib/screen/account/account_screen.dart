import 'package:flutter/material.dart';
import 'package:idaman/screen/account/components/body.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static String routeName = "/account";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
          Text("Pilih Jenis Akun"),
      ),
      body: Body()
    );
  }
}
