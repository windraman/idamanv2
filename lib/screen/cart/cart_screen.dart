import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Cart.dart';
import 'package:idaman/models/Keranjang.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Photos.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/cart_post.dart';
import 'package:idaman/models/transaksi_post.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../main.dart';
import '../../size_config.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';




class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  KeranjangResponseModel it = new KeranjangResponseModel(
      data: List.empty(),
      numOfItems: 0,
      api_status: 0,
      api_message: "api_message",
      total: 0,
      error: "none",
      avg_jarak: 0,
      tarif_per_km: 0,
      biaya_kurir: 0
  ) ;
  List<Cart> keranjang = [];
  int numOfItems = 0;
  int total = 0;

  @override
  void initState() {
    loadKeranjang(context);
    super.initState();
  }

  changeNum(int num){
    setState(() {
      numOfItems = num;
    });
  }

  changeTotal(int num){
    setState(() {
      total = num;
    });
  }

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {

    return LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: () async{
          loadKeranjang(context);
    },
    showChildOpacityTransition: false,
    child:Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: keranjang.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(keranjang[index].id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                APIService api = new APIService();
                int status = await api.delKeranjang(keranjang[index].id.toString());
                if(status==1) {
                  setState(()  {
                    it.numOfItems = it.numOfItems - keranjang[index].numOfItem;
                    it.total = it.total - keranjang[index].product.price.toInt() * keranjang[index].numOfItem;
                    changeNum(it.numOfItems);
                    changeTotal(it.total);

                    keranjang.removeAt(index);
                  });
                }else{
                  final snackBar = SnackBar(
                      content: Text("Gagal Menghapus Keranjang")
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(
                cart: keranjang[index],
                setJumlahDown:(){
                  keranjang[index].numOfItem--;
                },
                setJumlahUp: (){
                  keranjang[index].numOfItem++;
                }
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(
          total: total,
          beli: ()=>_fetchData(context),
          jarak: it.avg_jarak,
          tarif_per_km: it.tarif_per_km,
          biaya_kurir: it.biaya_kurir,
          error: it.error,
          keranjang: keranjang,
      )
    )
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: BackButton(
        onPressed: () => Navigator.pop(context, "load keranjang"),
      ),
      title: Column(
        children: [
          Text(
            "Keranjangku",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${numOfItems} items",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  loadKeranjang(BuildContext context) async{
    LocationService ls = new LocationService();
    LocationModel lm = await ls.getCurrentPosition();
    APIService apiService = new APIService();
    await apiService.getKeranjang(MyApp.localStorage.get('id').toString(),lm.latitude,lm.longitude).then((value) {
      it = value;
      //print(value);
      if(it.api_status == 1) {
        List<Cart> carts = [];
        numOfItems = it.numOfItems;
        total = it.total;
        for(var i = 0; i < it.data.length; i++) {
          List<dynamic> photoList = it.data[i]["produk"]["photo"];
          List<PhotoModel> photos = [];
          for(String photo in photoList) {
            print(it.data[i]["produk"]["photo"]);
            print(it.tarif_per_km);
            photos.add(new PhotoModel(id: "1", parent_id: "1", file: photo, parent: "produk", utama: "1", type: "image", created_at: ""));
          }
          carts.add(
              new Cart(
                  id: int.parse(it.data[i]['id']) ,
                  numOfItem: int.parse(it.data[i]['qty']),
                  tarif_per_km: it.tarif_per_km,
                  avg_jarak: it.avg_jarak,
                  biaya_kurir: it.biaya_kurir,
                  error: it.error,
                  product: new Product(
                    id: int.parse(it.data[i]['produk']['id']),
                    images: photos,
                    colors: new List<Color>.empty(),
                    title: it.data[i]['produk']['nama_produk_jasa'],
                    umkm_usaha_id: int.parse(it.data[i]['produk']['umkm_usaha_id']),
                    price: double.parse(it.data[i]['produk']['harga']),
                    berat: double.parse(it.data[i]['produk']['berat']),
                    satuan_berat: it.data[i]['produk']['satuan_berat'],
                    description: it.data[i]['produk']['deskripsi_singkat'],
                    longDesc: it.data[i]['produk']['deskripsi_produk'],
                    lokasi: it.data[i]['produk']['lokasi'],
                    jarak: double.parse(it.data[i]['produk']['jarak'].toString()),
                    rating: double.parse(it.data[i]['produk']['rating'].toString()),
                    isFavourite: int.parse(it.data[i]['produk']["isFavorite"].toString()),
                    isPopular: it.data[i]['produk']["isPopular"] == true,
                    usaha: it.data[i]['produk']["usaha"],
                    nik: "", //it.data[i]['produk']["nik"],
                    kategori_produk_id: int.parse(it.data[i]['produk']["kategori_produk_id"]),
                    satuan_berat_id: 0, //it.data[i]['produk']["satuan_berat_id"],
                    status_produk: int.parse(it.data[i]['produk']["status_produk"]),
                    verified: it.data[i]["verified"].toString(),
                  )
              )
          );
        }
        keranjang = carts;
      }else{
        return it.api_message;
      }

    });
    setState(() {

    });
  }

  convertStringArray(List<dynamic> string){
    List<String> list = [];
    for(var item in string){
      list.add(item);
    }
    return list;
  }

  Future<bool> beli() async {
    LocationService ls = new LocationService();
    LocationModel lm = await ls.getCurrentPosition();
    List<dynamic> cp = List.empty(growable: true);
    for(Cart cart in keranjang){
      try {
        cp.add(new CartPost(
            produk_id: jsonEncode(cart.product.id),
            qty: cart.numOfItem.toString(), 
            catatan: ""
        ));
      } on Exception catch (_) {
        print('never reached');
      }

    }

    TransaksiPostModel postModel = new TransaksiPostModel(
        pembeli_id: MyApp.localStorage.get("id").toString(),
        total_item: numOfItems.toString(),
        total_harga: total.toString(),
        list_item_json: jsonEncode(cp),
        pembeli_lat: lm.latitude,
        pembeli_lon: lm.longitude,
        jarak: it.avg_jarak.toString(),
        ongkir: (it.avg_jarak * it.tarif_per_km).toString(),
        metode_pembayaran_id: "1"
    );

    //print(jsonEncode(postModel));

    APIService api = new APIService();
    PostResponseModel trans = await api.addTansaksi(postModel);
    print(trans.api_message);
    if(trans.api_status==1){
      print("transaksi masuk");
      return true;
    }else{
      print("transaksi gagal");
      return false;
    }
    setState(() {

    });
  }

  void _fetchData(BuildContext context, [bool mounted = true]) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Menunggu respon penjual ...')
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await beli();

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

}
