

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/screen/details/details_screen.dart';
import 'package:idaman/screen/penjual/produk/produk_screen.dart';

import '../constants.dart';
import '../size_config.dart';

import 'package:intl/intl.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    // this.width = 140,
    // this.aspectRetio = 1.02,
    required this.width,
    required this.aspectRetio,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: SizedBox(
          width: getProportionateScreenWidth(width),
          child: GestureDetector(
            onTap: () {
              if(product.nik!=MyApp.localStorage.getString("nik").toString()) {
                Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: ProductDetailsArguments(product: product)
                );
              }else{
                Navigator.pushNamed(
                    context,
                    ProdukScreen.routeName,
                    arguments: ProdukScreenArguments(produk: product,judul: "Edit Produk")
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.03,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Hero(
                      tag: product.id.toString(),
                      child: product.images.length > 0 ?
                      Image.network(
                          product.images[0].file,
                        fit: BoxFit.cover,
                      ):Image.asset(
                        "assets/images/noimage.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(13)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${formatCurrency.format(product.price)}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(11),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    if(MyApp.localStorage.getString("nik").toString().isNotEmpty && MyApp.localStorage.getString("nik")!=null)
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        if(product.isFavourite==0){
                          setFavourite("produk", product.id.toString(), "1");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        height: getProportionateScreenWidth(28),
                        width: getProportionateScreenWidth(28),
                        decoration: BoxDecoration(
                          color: product.isFavourite > 0
                              ? kPrimaryColor.withOpacity(0.15)
                              : kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          color: product.isFavourite > 0
                              ? Color(0xFFFF4848)
                              : Color(0xFFDBDEE4),
                        ),
                      ),
                    ),
                  ],
                ),
                if(product.usaha!="0")
                Row(
                  children: [
                    Icon(
                      Icons.store_mall_directory,
                      size: getProportionateScreenWidth(12),
                    ),
                    Text(
                        product.usaha.toString(),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(8)
                      ),
                    ),
                  ],
                ),
                if(product.lokasi!="0")
                Row(
                  children: [
                    Icon(
                        Icons.location_on,
                      size: 15,
                    ),
                    Text(
                        product.lokasi,
                      style: TextStyle(
                        fontSize: 10
                      ),
                    )
                  ],
                ),
                if(product.lokasi=="0")
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 15,
                      color: Colors.white,
                    ),
                    Text(
                      product.lokasi,
                      style: TextStyle(
                          fontSize: 10,
                        color: Colors.white
                      ),
                    )
                  ],
                ),
                if(product.jarak>0)
                Text(
                  "${product.jarak}km",
                  style: TextStyle(
                      fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setFavourite(String namaTable, String keyId, String reaksi) async {
    APIService api = new APIService();
    PostResponseModel prm = await api.sukai(namaTable, reaksi, keyId);
    if(prm.api_status==1){
      print(prm.api_message);
      //product.isFavourite = prm.id;
    }else{
      print(prm.api_message);
    }
  }
}
