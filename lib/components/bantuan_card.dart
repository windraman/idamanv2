

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:idaman/models/Bantuan.dart';
import 'package:idaman/screen/penjual/bantuan/details/bantuan_detail_screen.dart';

import '../constants.dart';
import '../size_config.dart';

import 'package:intl/intl.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class BantuanCard extends StatelessWidget {
  const BantuanCard({
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
                  BantuanDetailScreen.routeName,
                  arguments: BantuanDetailScreenArguments(model: product)
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
                      child: product.photo.toString()!="null" ?
                      Image.network(
                          product.photo.toString(),
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
                  product.bantuan.toString(),
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.bold
                  ),
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
                          "${dateFormat.format(DateTime.parse(product.tanggal.toString()))}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(11),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
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
