
import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/Keranjang.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Pasar.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/Shortcut.dart';
import 'package:idaman/screen/cart/cart_screen.dart';
import 'package:idaman/screen/home/components/discount_banner.dart';
import 'package:idaman/screen/home/components/home_header.dart';
import 'package:idaman/screen/home/components/nearby_umkm.dart';
import 'package:idaman/screen/home/components/popular_product.dart';
import 'package:idaman/screen/home/components/shortcuts.dart';
import 'package:idaman/screen/home/components/special_offers.dart';
import 'package:idaman/screen/prelogin/components/news_slider.dart';
import 'package:idaman/size_config.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../main.dart';
import '../../../models/Layanan.dart';
import '../../../models/UmkmData.dart';
import '../../../models/slide_model.dart';
import 'categories.dart';
import 'layanan.dart';

APIService apiService = new APIService();
List<SlideData> slides = [];
List<KategoriModel> kategori_produk = [];
List<Data> layanan = [];
List<PasarModel> pasar = [];
List<Product> produks = [];
List<Product> nbproduks = [];
List<ShortcutModel> shortcuts = [];
List<Umkm> nbumkm = [];
KeranjangCountModel  cart = new KeranjangCountModel(
    numOfItems: 0,
    api_status: 0,
    belanjaan: 0
) ;

LocationService lc = new LocationService();
LocationModel lm =new LocationModel(latitude: "0", longitude: "0", isMock: true);

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void initState(){
    loadSlider(context);
    loadKategori(context);
    loadLayanan(context);
    loadPasar(context);
    loadProduk(context);
    loadKeranjang(context);
    loadNearByUmkm(context);
    loadShortcut(context);
    super.initState();
  }

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: () async{
          loadSlider(context);
          loadKategori(context);
          loadLayanan(context);
          loadPasar(context);
          loadProduk(context);
          loadKeranjang(context);
          loadNearByUmkm(context);
          loadShortcut(context);
        },
        showChildOpacityTransition: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(20)),
              HomeHeader(
                numOfCart: cart.numOfItems,
                numOfNotif: 0,
                press1: ()  async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                  if(result=="load keranjang"){
                    loadKeranjang(context);
                  }
                  // ScaffoldMessenger.of(context)
                  //   ..removeCurrentSnackBar()
                  //   ..showSnackBar(SnackBar(content: Text('$result')));
                },
                press2: (){},
              ),
              SizedBox(height: getProportionateScreenWidth(10)),
              //if(cart.belanjaan>0)
              DiscountBanner(
                  belanjaan : cart.belanjaan,
                  press1: ()  async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
                if(result=="load keranjang"){
                  loadKeranjang(context);
                }
                // ScaffoldMessenger.of(context)
                //   ..removeCurrentSnackBar()
                //   ..showSnackBar(SnackBar(content: Text('$result')));
              },
              numOfItems: cart.numOfItems
              ),
              NewsSlider(slides: slides),
              SizedBox(height: getProportionateScreenWidth(10)),
              Pintasan(shortcuts: shortcuts),
              SizedBox(height: getProportionateScreenWidth(30)),
              Layanan(layanan: layanan),
              SizedBox(height: getProportionateScreenWidth(30)),
              SpecialOffers(pasar: pasar),
              SizedBox(height: getProportionateScreenWidth(15)),
              Categories(kategori_produk: kategori_produk),
              SizedBox(height: getProportionateScreenWidth(20)),
              PopularProducts(produks: produks),
              SizedBox(height: getProportionateScreenWidth(15)),
              NearbyUmkm(umkm: nbumkm),
            ],
          ),
        )
    );
  }

  loadShortcut(BuildContext context) async{
    // APIService apiService = new APIService();
    await apiService.getIcon("1",12).then((value) {
      shortcuts = value;
    });
    setState(() {

    });
  }

  loadSlider(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getSlider("1").then((value) {
      // print(value.toString());
      slides = value;
    });
    setState(() {

    });
  }

  loadKategori(BuildContext context) async{
    // APIService apiService = new APIService();
    await apiService.getKategoriProduk().then((value) {
      kategori_produk = value;
    });
    setState(() {

    });
  }

  loadPasar(BuildContext context) async{
    // APIService apiService = new APIService();
    await apiService.getPasar().then((value) {
      pasar = value;
    });
    setState(() {

    });
  }

  loadLayanan(BuildContext context) async{
    // APIService apiService = new APIService();
    await apiService.getLayananKeluranan(MyApp.localStorage.getString('village_id').toString()).then((value) {
      layanan = value;
    });
    setState(() {

    });
  }

  loadProduk(BuildContext context) async{
    // APIService apiService = new APIService();
    await apiService.findProduk("user_id=${MyApp.localStorage.get('id')}&reorderdesc=rating",0,5).then((value) {
      produks = value;
    });
    setState(() {

    });
  }

  loadNearByUmkm(BuildContext context) async{

    lm = await lc.getCurrentPosition();
    print(lm.longitude);
    APIService apiService = new APIService();
    await apiService.getUmkm("", lm.latitude, lm.longitude, 25, 7).then((value) {
      print(value);
      nbumkm = value;
      setState(() {

      });
    });

  }

  loadKeranjang(BuildContext context) async{
    // APIService apiService = new APIService();
    await apiService.getKeranjangCount(MyApp.localStorage.get('id').toString()).then((value) {
        cart = value;
    });
    setState(() {

    });
    print(cart.belanjaan);
  }


}









