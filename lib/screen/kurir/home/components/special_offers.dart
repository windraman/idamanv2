import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idaman/components/special_offer_card.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Pasar.dart';
import 'package:idaman/screen/browser/browser_screen.dart';

import '../../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key, required this.pasar
  }) : super(key: key);

  final List<PasarModel> pasar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Pasar",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(pasar.length, (index) =>
                  SpecialOfferCard(
                      image: pasar[index].gambar_utama,
                      category: pasar[index].nama,
                      numOfBrands: pasar[index].numOfProduk,
                      press: () async {
                        LocationService lc = new LocationService();
                        LocationModel lm = await lc.getCurrentPosition();
                        Navigator.pushNamed(
                          context,
                          BrowserScreen.routeName,
                          arguments: BrowserScreenArguments(
                              searchParams: "lokasi_id=" + pasar[index].id + "&reorder=jarak&user_lat="+lm.latitude+"&user_lon="+lm.longitude,
                              keyword: pasar[index].nama
                          ),
                        );
                      },
                    width: 242,
                    height: 100,
                  )
              ),
              // SpecialOfferCard(
              //   image: "assets/images/Image Banner 2.png",
              //   category: "Sembako",
              //   numOfBrands: 18,
              //   press: () {},
              // ),
              // SpecialOfferCard(
              //   image: "assets/images/Image Banner 3.png",
              //   category: "Sayuran",
              //   numOfBrands: 24,
              //   press: () {},
              // ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}


