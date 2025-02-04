import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/keranjang_post.dart';
import 'package:idaman/screen/Messages/messages_screen.dart';
import 'package:idaman/screen/cart/cart_screen.dart';
import 'package:idaman/screen/details/components/product_description_edit.dart';
import 'package:idaman/screen/details/components/product_images_edit.dart';
import 'package:idaman/screen/details/components/quantity_field.dart';

import '../../../main.dart';
import '../../../size_config.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {


  int jumlah = 1;
  Product newProduct = Product(
      id: 0,
      images: [],
      colors: [],
      isFavourite: 0,
      title: "",
      umkm_usaha_id: 0,
      price: 0,
      berat: 0,
      satuan_berat: "Kg",
      description: "",
      longDesc: "",
      lokasi: "0",
      jarak: 0,
      usaha: "0",
      nik: "",
      kategori_produk_id: 0,
      satuan_berat_id: 0,
    status_produk: 1,
    verified: "Belum Verifikasi"
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if(widget.product.nik!=MyApp.localStorage.getString("nik").toString())
          // if(widget.product.images.length>0)
            ProductImages(product: widget.product),
        if(widget.product.nik==MyApp.localStorage.getString("nik").toString())
          ProductImagesEdit(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              if(widget.product.nik!=MyApp.localStorage.getString("nik").toString())
                ProductDescription(
                  product: widget.product,
                  pressOnSeeMore: () {},
                ),
              if(widget.product.nik==MyApp.localStorage.getString("nik").toString())
                ProductDescriptionEdit(
                  product: widget.product,
                  pressOnSeeMore: () {}
                ),

              if(widget.product.nik!=MyApp.localStorage.getString("nik").toString() && MyApp.localStorage.getString("nik").toString().isNotEmpty && MyApp.localStorage.getString("nik")!=null)
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    QuantityField(
                        product: widget.product,
                        jumlah: jumlah,
                        widthFactor: 0.2,
                        setJumlahDown: (){
                          setState(() {
                            if(jumlah>1) {
                              jumlah--;
                            }
                          });
                        },
                        setJumlahUp: (){
                          setState(() {
                            jumlah++;
                          });
                        },
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          top: getProportionateScreenWidth(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    MessageScreen.routeName,
                                    arguments: MessagesArguments(
                                        widget.product.id.toString(),
                                        widget.product.title,
                                        "produk"
                                    )
                                );
                              },
                            ),
                            Expanded(
                              child: DefaultButton(
                                text: "Masukkan Keranjang",
                                warna: Colors.orange,
                                press: () async {
                                  KeranjangPostModel kpm = new KeranjangPostModel(
                                      catatan: "anu",
                                      cms_users_id: MyApp.localStorage.get('id').toString(),
                                      produk_id: widget.product.id.toString(),
                                      qty: jumlah.toString()
                                  );
                                  APIService api = new APIService();
                                  PostResponseModel resp = await api.addKeranjang(kpm);
                                  if(resp.api_status==1){
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,
                                          color: Colors.amber,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text('Barang ditambahkan ke keranjang'),
                                                ElevatedButton(
                                                  child: const Text('Lanjut'),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Lihat Keranjang'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pushNamed(context,CartScreen.routeName);

                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}
