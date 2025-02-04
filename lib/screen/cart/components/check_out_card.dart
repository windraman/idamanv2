import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/models/Cart.dart';
import 'package:idaman/screen/cart/components/kurir_card.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class CheckoutCard extends StatelessWidget {
  final int total;
  final Function() beli;
  final double jarak;
  final int tarif_per_km;
  final int biaya_kurir;
  final String error;
  final List<Cart> keranjang;
  const CheckoutCard({
    Key? key,
    required this.total,
    required this.beli,
    required this.jarak,
    required this.tarif_per_km,
    required this.biaya_kurir,
    required this.error,
    required this.keranjang
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(keranjang.isNotEmpty && error == "none") {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KurirCard(
                  jarak: jarak,
                  tarif_per_km: tarif_per_km,
                  biaya_kurir: biaya_kurir
              )
              ,
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("Gunakan Kode Voucher"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "${formatCurrency.format(total+(jarak*tarif_per_km))}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      text: "Beli",
                      warna: Colors.orange,
                      press: (){
                        showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 300,
                            color: Colors.yellow,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Pilih Pembayaran'),
                                  ElevatedButton(
                                    child: const Text('Tunai'),
                                    onPressed: beli,
                                  ),
                                  ElevatedButton(
                                    child: const Text('Virtual Account'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigator.pushNamed(context,CartScreen.routeName);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Dompet Idaman'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigator.pushNamed(context,CartScreen.routeName);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Batal'),
                                    onPressed: () => Navigator.pop(context),
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      );
                        },

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }else{
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(error),
              SizedBox(height: 10),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "${formatCurrency.format(total)}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
