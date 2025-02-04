import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idaman/constants.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/Location.dart';

import '../../../../size_config.dart';
import '../../tracker/webviewfs.dart';


List<Widget> listKategori = [];


class Categories extends StatelessWidget {
  Categories({Key? key, required this.kategori_produk}) : super(
      key: key,
  );

  final List<KategoriModel> kategori_produk;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Status","route":"/webfs"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Aktif","route":""},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Hari ini","route":""},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Sejarah","route":""},
    ];
    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        childAspectRatio: 1/1.3,
        children: [
          ...List.generate(
              categories.length,
                  (index) => CategoryCard(
                      svgSrc: categories[index]["icon"],
                      text: categories[index]["text"],
                      press: () async {
                        LocationService lc = new LocationService();
                        LocationModel lm = await lc.getCurrentPosition();
                        Navigator.pushNamed(
                          context,
                          categories[index]["route"],
                          arguments: WebViewFSArguments(
                            osmUrl,
                            "TRACK"
                          ),
                        );
                      }
                      )
          )
        ]
    );

  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.svgSrc,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        press();
      },
      child: SizedBox(
          width: getProportionateScreenWidth(25),
          height: getProportionateScreenHeight(50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECDF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                        svgSrc,
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 5),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10
                ),
              )
            ],
          )
      ),
    );
  }

}