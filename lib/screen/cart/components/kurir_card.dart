import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);


class KurirCard extends StatelessWidget {
  const KurirCard({
    Key? key,
    required this.jarak,
    required this.tarif_per_km,
    required this.biaya_kurir,
  }) : super(key: key);

  final double jarak;
  final int tarif_per_km;
  final int biaya_kurir;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 44,
          child: AspectRatio(
            aspectRatio: 0.44,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.motorcycle),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Biaya Kurir",
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "${formatCurrency.format(tarif_per_km)}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${jarak}km = ",
                      style: Theme.of(context).textTheme.bodyMedium),
                  TextSpan(
                      text: "${formatCurrency.format(biaya_kurir)}",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
