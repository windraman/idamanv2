import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idaman/components/add_usaha_card.dart';
import 'package:idaman/components/special_offer_card.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/penjual/usaha/usaha_screen.dart';

import '../../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key, required this.usaha
  }) : super(key: key);

  final List<Umkm> usaha;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Usaha Saya",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(usaha.length, (index) =>
                  SpecialOfferCard(
                      image: usaha[index].photo,
                      category: usaha[index].nama_usaha,
                      numOfBrands: usaha[index].numOfProduk,
                      press: () async {
                        LocationService lc = new LocationService();
                        LocationModel lm = await lc.getCurrentPosition();
                        Navigator.pushNamed(
                          context,
                          UsahaScreen.routeName,
                          arguments: UsahaScreenArguments(
                              namaUsaha: usaha[index].nama_usaha,
                              idUsaha: usaha[index].id,
                              usaha: usaha[index]
                          ),
                        );
                      },
                    width: 120,
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
              AddUsahaCard(title: "Daftar", deskripsi: "usaha baru", press: (){}),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}


