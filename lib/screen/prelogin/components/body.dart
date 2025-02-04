

import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/Keranjang.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Pasar.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/StatsResponseModel.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/cart/cart_screen.dart';
import 'package:idaman/screen/prelogin/components/news_slider.dart';
import 'package:idaman/screen/prelogin/components/popular_product.dart';
import 'package:idaman/size_config.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../main.dart';
import '../../../models/Shortcut.dart';
import '../../../models/slide_model.dart';
import '../../home/components/shortcuts.dart';
import 'daftar_banner.dart';
import 'home_header.dart';
import 'nearby_umkm.dart';

List<SlideData> slides = [];
List<KategoriModel> kategori_produk = [];
List<PasarModel> pasar = [];
List<Product> produks = [];
List<Product> nbproduks = [];
List<Umkm> nbumkm = [];
StatsResposeModel stats = new StatsResposeModel(
    api_status: 0,
    api_message: "none",
    usaha: 0,
    pemilik_usaha_lokal: 0,
    pemilik_usaha_luar: 0,
    nonekraf: 0,
    ekraf: 0
);
KeranjangCountModel  cart = new KeranjangCountModel(
    numOfItems: 0,
    api_status: 0,
    belanjaan: 0
) ;
List<ShortcutModel> shortcuts = [];
LocationService lc = new LocationService();
LocationModel lm =new LocationModel(latitude: "0", longitude: "0", isMock: true);


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState(){
    super.initState();

    // APIService api = new APIService();
    // api.searchProduk("reorderdesc=rating",0,5);
    loadSlider(context);
    // loadGps(context);
    loadShortcut(context);
    loadProduk(context);
    loadNearByUmkm(context);
    //loadStats(context);


  }

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: () async{
          loadSlider(context);
          loadShortcut(context);
          loadProduk(context);
          loadNearByUmkm(context);
        },
        showChildOpacityTransition: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(30)),
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
              //Image.network(banner),
              //DiscountBanner(),
              //PromoSlider(),
              // SizedBox(height: getProportionateScreenWidth(5)),
              NewsSlider(slides: slides),
              SizedBox(height: getProportionateScreenWidth(10)),
              Pintasan(shortcuts: shortcuts),
              if(nbumkm.isNotEmpty)
                SizedBox(height: getProportionateScreenWidth(50)),
              if(nbumkm.isNotEmpty)
                NearbyUmkm(umkm: nbumkm),
              // SizedBox(height: getProportionateScreenWidth(5)),
              // Categories(kategori_produk: kategori_produk),
              // SizedBox(height: getProportionateScreenWidth(15)),
              //SpecialOffers(pasar: pasar),
              SizedBox(height: getProportionateScreenWidth(15)),
              PopularProducts(produks: produks,lm: lm),
              SizedBox(height: getProportionateScreenWidth(50)),
              //VideoSection(),
              // SizedBox(height: getProportionateScreenWidth(50)),
              DaftarBanner(),
              // SizedBox(height: getProportionateScreenWidth(15)),
              // GridView.count(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     primary: false,
              //     padding: const EdgeInsets.all(20),
              //     crossAxisSpacing: 10,
              //     mainAxisSpacing: 10,
              //     crossAxisCount: 3,
              //     childAspectRatio: 1/1.3,
              //     children: [
              //       StatsCard(
              //           val: stats.usaha.toString(),
              //           text: "USAHA",
              //           warnabg: Colors.red,
              //           warnatext: Colors.white,
              //           press: (){}
              //       ),StatsCard(
              //           val: stats.nonekraf.toString(),
              //           text: "UMUM",
              //           warnabg: Colors.green,
              //           warnatext: Colors.white,
              //           press: (){}
              //       ),StatsCard(
              //           val: stats.ekraf.toString(),
              //           text: "EKRAF",
              //           warnabg: Colors.orange,
              //           warnatext: Colors.white,
              //           press: (){}
              //       )
              //     ]
              // ),
              // SizedBox(height: getProportionateScreenWidth(15)),
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: DefaultButton(
              //     text: "INFOGRAFIS",
              //     press: () {
              //       Navigator.pushNamed(
              //           context,
              //           WebViewerFS.routeName,
              //           arguments: WebViewFSArguments(
              //             endPointPublic + "admin/tamu/statistic_builder;show;laporan-umkm",
              //             "INFOGRAFIS"
              //           ),
              //       );
              //     },
              //     warna: Colors.redAccent,
              //   ),
              // ),
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

  loadSlider(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getSlider("1").then((value) {
      print(value.toString());
      slides = value;
    });
  }

  loadPasar(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getPasar().then((value) {
      pasar = value;
      setState(() {

      });
    });

  }

  loadShortcut(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getIcon2("1",12,"","0").then((value) {
      shortcuts = value;
    });
    setState(() {

    });
  }

  loadProduk(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.findProduk("reorderdesc=rating",0,5).then((value) {
      // if(value)
        produks = value;

      setState(() {

      });
    });

  }

  loadNearBy(BuildContext context) async{
    lm = await lc.getCurrentPosition();
    APIService apiService = new APIService();
    await apiService.findProduk("reorderdesc=jarak&limit=7&user_lat=${lm.latitude}&user_lon=${lm.longitude}&jarak=7",0,7).then((value) {
      nbproduks = value;
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
    APIService apiService = new APIService();
    await apiService.getKeranjangCount(MyApp.localStorage.get('id').toString()).then((value) {
      cart = value;
    });
    setState(() {

    });
  }

  loadGps(BuildContext context) async{
    lm = await lc.getCurrentPosition();
    setState(() {

    });
  }

  void loadStats(BuildContext context) async {
    APIService apiService = new APIService();
    await apiService.getStats().then((value) {
      stats = value;
      setState(() {

      });
      print(stats.usaha);
    });
  }


}











