import 'package:flutter/material.dart';
import 'package:idaman/screen/penjual/pelatihan/browser/browser.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PELATIHAN"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Browser(umkm_usaha_id: 0,keyword: "" , searchString: '', owned: false),
    );
  }
}
