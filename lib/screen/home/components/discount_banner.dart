import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/icon_btn_with_counter.dart';
import '../../../size_config.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
    required this.belanjaan,
    required this.press1,
    required this.numOfItems
  }) : super(key: key);

  final int belanjaan;
  final Function() press1;
  final int numOfItems;


  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                  text: "Dompet\n",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(10),
                  ),
                ),
                TextSpan(
                  text: "${formatCurrency.format(0)}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(11),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                    text: "Belanjaan saya\n",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(10),
                  ),
                ),
                TextSpan(
                  text: "${formatCurrency.format(belanjaan)}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(11),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfItems: numOfItems,
            press: press1
          ),
        ],
      ),
    );
  }
}
