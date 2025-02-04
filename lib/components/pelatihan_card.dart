

import 'package:flutter/material.dart';
import 'package:idaman/models/Pelatihan.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:idaman/screen/penjual/pelatihan/details/pelatihan_detail_screen.dart';

import '../constants.dart';
import '../size_config.dart';

import 'package:intl/intl.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class PelatihanCard extends StatelessWidget {
  const PelatihanCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Data product;



  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat;
    DateFormat timeFormat;
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('id');
    timeFormat = new DateFormat.Hms('id');
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: SizedBox(
          width: getProportionateScreenWidth(width),
          child: GestureDetector(
            onTap: () {

                Navigator.pushNamed(
                    context,
                    PelatihanDetailScreen.routeName,
                    arguments: pelatihanDetailScreenArguments(model: product)
                );

            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    ),
                    child: Hero(
                      tag: product.id.toString(),
                      child: product.gambar.toString()!="null" ?
                      Image.network(
                          product.gambar.toString(),
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
                  product.namaPelatihan.toString(),
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.storage,
                      size: 15,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Text(
                        product.penyelenggara.toString(),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(11),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Text(
                        product.tempat.toString(),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(11),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 15,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Text(
                        "${dateFormat.format(DateTime.parse(product.tanggalMulai.toString()))} ${timeFormat.format(DateTime.parse(product.tanggalMulai.toString()))} - ${timeFormat.format(DateTime.parse(product.tanggalAkhir.toString()))}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(11),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
