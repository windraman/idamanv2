import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idaman/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:intl/intl.dart';


final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    print(product.verified);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: Row(
                    children: [
                      Text(
                        "${formatCurrency.format(product.price)}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      Text(
                        "/${product.berat} ${product.satuan_berat}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.w300,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color:
                  product.isFavourite > 0 ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color:
                  product.isFavourite > 0 ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                  height: getProportionateScreenWidth(16),
                ),
              ),
            ),
          ],
        ),

        Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Column(
            children: [
              Row(
                children: [
                  if(product.usaha!="0")
                    GestureDetector(
                      onTap:(){

                        // Navigator.pushNamed(
                        //     context,
                        //     UsahaScreen.routeName,
                        //     arguments: UsahaScreenArguments( usaha: , namaUsaha: umkm.nama_usaha, idUsaha: umkm.id
                        // );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.store_mall_directory,
                            size: 15,
                          ),
                          Text(
                            product.usaha.toString(),
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          if(product.verified=="Account")
                          Icon(
                              Icons.verified_rounded,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  Spacer(),
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
                              fontSize: 12
                          ),
                        )
                      ],
                    ),
                ],
              ),
              if(product.jarak>0)
                Row(
                  children: [
                    Text(
                      " Jarak : ",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),
                    ),
                    Text(
                      "${product.jarak}km",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.green
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: Row(
            children: [
              Text(
                product.longDesc,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              )
            ],
          ),
        )
      ],
    );
  }
}
