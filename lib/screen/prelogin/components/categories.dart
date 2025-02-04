import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/screen/browser/browser_screen.dart';

import '../../../size_config.dart';

//List<Widget> listKategori = [];


class Categories extends StatelessWidget {
  Categories({Key? key, required this.kategori_produk}) : super(
      key: key,
  );

  final List<KategoriModel> kategori_produk;

  @override
  Widget build(BuildContext context) {

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
              kategori_produk.length,
                  (index) => CategoryCard(
                      svgSrc: kategori_produk[index].icon,
                      text: kategori_produk[index].nama_kategori,
                      press: () async {
                        LocationService lc = new LocationService();
                        LocationModel lm = await lc.getCurrentPosition();
                        Navigator.pushNamed(
                          context,
                          BrowserScreen.routeName,
                          arguments: BrowserScreenArguments(
                            searchParams: "user_id=${MyApp.localStorage.get('id')}&kategori_produk_id=" + kategori_produk[index].id + "&reorder=jarak&user_lat="+lm.latitude+"&user_lon="+lm.longitude,
                            keyword: kategori_produk[index].nama_kategori
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
                    child: SvgPicture.network(
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