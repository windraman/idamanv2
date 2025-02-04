import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:idaman/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);


class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.setJumlahUp,
    required this.setJumlahDown,
  }) : super(key: key);

  final Cart cart;
  final Function() setJumlahUp, setJumlahDown;

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = new TextEditingController(
        text: cart.numOfItem.toString()
    );
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cart.product.images[0].file),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            Text(
              cart.product.lokasi,
              style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 10),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "${formatCurrency.format(cart.product.price)} x ${cart.numOfItem}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " / ${cart.product.berat} ${cart.product.satuan_berat}",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(10)),
                // RoundedIconBtn(
                //   icon: Icons.remove,
                //   press: setJumlahDown,
                // ),
                // Container(
                //   width: SizeConfig.screenWidth * 0.12,
                //   //height: 50,
                //   decoration: BoxDecoration(
                //       color: kSecondaryColor.withOpacity(0.1),
                //       borderRadius: BorderRadius.circular(15)
                //   ),
                //   child: TextField(
                //     controller: _textEditingController,
                //     keyboardType: TextInputType.number,
                //     onChanged: (value){
                //
                //     },
                //     decoration: InputDecoration(
                //         enabledBorder: InputBorder.none,
                //         focusedBorder: InputBorder.none,
                //         contentPadding: EdgeInsets.symmetric(
                //             horizontal: getProportionateScreenWidth(20),
                //             vertical: getProportionateScreenHeight(9)
                //         )
                //     ),
                //   ),
                // ),
                // RoundedIconBtn(
                //   icon: Icons.add,
                //   showShadow: false,
                //   press: setJumlahUp,
                // ),
              ],
            )
          ],
        )
      ],
    );
  }
}
