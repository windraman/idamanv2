
import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/Keranjang.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Pasar.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/models/login_model.dart';
import 'package:idaman/screen/penjual/home/components/home_header.dart';
import 'package:idaman/screen/penjual/home/components/promo_slider.dart';
import 'package:idaman/screen/penjual/home/components/usaya_saya.dart';
import 'package:idaman/size_config.dart';

import '../../../../main.dart';
import 'categories.dart';


List<KategoriModel> kategori_produk = [];
List<PasarModel> pasar = [];
List<Product> produks = [];
List<Product> nbproduks = [];
late LoginRequestModel loginRequestModel;
List<Umkm> usahaSaya = [];

KeranjangCountModel  cart = new KeranjangCountModel(
    numOfItems: 0,
    api_status: 0,
  belanjaan: 0
) ;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void initState(){
    //loadKategori(context);
    loadUsahaSaya(context);
    //loadProduk(context);
    //loadKeranjang(context);
    //loadNearBy(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(20)),
              HomeHeader(
                numOfCart: cart.numOfItems,
                numOfNotif: 0,
                press2: (){},
              ),
              SizedBox(height: getProportionateScreenWidth(10)),
              //DiscountBanner(),
              PromoSlider(),
              SizedBox(height: getProportionateScreenWidth(10)),
              Categories(kategori_produk: kategori_produk),
              SizedBox(height: getProportionateScreenWidth(15)),
              UsahaSaya(usaha: usahaSaya),
              // SizedBox(height: getProportionateScreenWidth(15)),
              // PopularProducts(produks: produks),
              SizedBox(height: getProportionateScreenWidth(15)),

              // NearbyProducts(produks: nbproduks),
            ],
          ),
        )
    );
  }

  loadKategori(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getKategoriProduk().then((value) {
      kategori_produk = value;
    });
    setState(() {

    });
  }

  loadUsahaSaya(BuildContext context) async{
    // print(MyApp.localStorage.get("nik").toString() + ", " + MyApp.localStorage.get("pass").toString());
    //lm = await lc.getCurrentPosition();
    APIService apiService = new APIService();
    await apiService.getUmkm("&nik="+MyApp.localStorage.get("nik").toString() , "0", "0", 0, 10).then((value) {
      usahaSaya = value;
    });
    setState((){});
  }

  loadProduk(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.findProduk("user_id=${MyApp.localStorage.get('id')}&reorderdesc=rating",0,5).then((value) {
      produks = value;
    });
    setState(() {

    });
  }

  loadNearBy(BuildContext context) async{
    LocationService lc = new LocationService();
    LocationModel lm = await lc.getCurrentPosition();
    APIService apiService = new APIService();
    await apiService.findProduk("reorderdesc=jarak&limit=5&user_lat=${lm.latitude}&user_lon=${lm.longitude}",0,0).then((value) {
      nbproduks = value;
    });
    setState(() {

    });
  }

  loadKeranjang(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getKeranjangCount(MyApp.localStorage.get('id').toString()).then((value) {
      cart = value;
    });
    setState(() {

    });
  }


}









