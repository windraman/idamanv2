import 'package:flutter/material.dart';
import 'package:idaman/components/product_card.dart';
import 'package:idaman/constants.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/screen/prelogin/leaflet/webviewmap.dart';


import '../../../size_config.dart';
import 'section_title.dart';

class NearbyProducts extends StatelessWidget {
  const NearbyProducts({
    Key? key,
    required this.produks,
  }) : super(key: key);

  final List<Product> produks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "UMKM Terdekat", press: () async {
            LocationService lc = new LocationService();
            LocationModel lm = await lc.getCurrentPosition();
            Navigator.pushNamed(
              context,
              WebViewMap.routeName,
              arguments: WebViewFSArguments(
                osmUrl,
              ),
            );
          }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                produks.length,
                (index) {
                    return ProductCard(
                        product: produks[index],
                      width: getProportionateScreenWidth(100),
                      aspectRetio: 1.02,
                    );

                  return SizedBox.shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
