import 'package:flutter/material.dart';
import 'package:idaman/components/product_card.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/screen/browser/browser_screen.dart';


import '../../../size_config.dart';
import 'section_title.dart';


class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
    required this.produks,
    required this.lm,
  }) : super(key: key);

  final List<Product> produks;
  final LocationModel lm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Produk UMKM Terpopuler", press: () {
            Navigator.pushNamed(
              context,
              BrowserScreen.routeName,
              arguments: BrowserScreenArguments(
                  searchParams: "reorder=jarak&user_lat="+lm.latitude+"&user_lon="+lm.longitude,
                  keyword: ""
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
                  //if (produks[index].isPopular)
                    return ProductCard(
                        product: produks[index],
                      width: getProportionateScreenWidth(120),
                      aspectRetio: 1.02,
                    );

                  //return SizedBox.shrink(); // here by default width and height is 0
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
