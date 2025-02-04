import 'package:flutter/material.dart';
import 'package:idaman/screen/transaksi/components/transaksi_saya.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../api/api_service.dart';
import '../../../main.dart';
import '../../../models/Transaksi.dart';
import '../../../size_config.dart';

List<Data> transaksiSaya = [];

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void initState(){
    loadTransaksiSaya(context);
    super.initState();
  }
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      onRefresh: () async{
        loadTransaksiSaya(context);
      },
      showChildOpacityTransition: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),

            SizedBox(height: getProportionateScreenWidth(10)),
            TransaksiSaya(usaha: transaksiSaya)
          ],
        )
      ),
    );
  }

  loadTransaksiSaya(BuildContext context) async{
    // print(MyApp.localStorage.get("nik").toString() + ", " + MyApp.localStorage.get("pass").toString());
    //lm = await lc.getCurrentPosition();
    APIService apiService = new APIService();
    await apiService.getTransakasiByUser(MyApp.localStorage.get("id").toString()).then((value) {
      transaksiSaya = value;
    });
    setState((){});
  }
}
