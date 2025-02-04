import "package:flutter/material.dart";
import "components/body.dart";

class TransaksiScreen extends StatelessWidget {
  const TransaksiScreen({Key? key}) : super(key: key);

  static String routeName = "/transaksi";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
