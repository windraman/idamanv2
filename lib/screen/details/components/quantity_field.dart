

import 'package:flutter/material.dart';
import 'package:idaman/components/rounded_icon_btn.dart';
import 'package:idaman/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class QuantityField extends StatelessWidget {

  const QuantityField({
    Key? key,
    required this.product,
    required this.setJumlahUp,
    required this.setJumlahDown,
    required this.jumlah,
    required this.widthFactor,
  }) : super(key: key);

  final Product product;
  final Function() setJumlahUp, setJumlahDown;
  final int jumlah;
  final num widthFactor;

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = new TextEditingController(
        text: jumlah.toString()
    );
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Text("Jumlah"),
          Spacer(),
          Container(
            width: SizeConfig.screenWidth * widthFactor,
            //height: 50,
            decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)
            ),
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              onChanged: (value){

              },
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(9)
                  )
              ),
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: setJumlahDown,
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: setJumlahUp,
          ),
        ],
      ),
    );
  }
}
