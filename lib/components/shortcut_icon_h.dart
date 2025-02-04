import 'package:flutter/material.dart';
import 'package:idaman/components/shortcut_icon.dart';
import '../../../size_config.dart';
import '../models/kategori_lokasi.dart';

class ShortcutIconH extends StatelessWidget {
  const ShortcutIconH({
    Key? key,
    required this.imgSrc,
    required this.text,
    required this.press,
    required this.koman,
    required this.anak
  }) : super(key: key);

  final String imgSrc;
  final String text;
  final String koman;
  final List<Anak> anak;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(250),
          height: getProportionateScreenHeight(80),
          child: GestureDetector(
            onTap: press,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFECDF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        imgSrc,
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 5),
                Text(
                  text.length > 40 ? text.substring(0, 40) + '...' : text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14
                  ),
                ),
              ],
            ),
          ),

        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(anak.length, (index) =>
                  ShortcutIcon(
                    imgSrc: anak[index].icon.toString(),
                    text: anak[index].nama.toString(),
                    press: press,
                    koman: '',
                  )
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}