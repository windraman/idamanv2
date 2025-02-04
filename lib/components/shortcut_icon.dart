import 'package:flutter/material.dart';
import '../../../size_config.dart';

class ShortcutIcon extends StatelessWidget {
  const ShortcutIcon({
    Key? key,
    required this.imgSrc,
    required this.text,
    required this.press,
    required this.koman,
  }) : super(key: key);

  final String imgSrc;
  final String text;
  final String koman;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
          width: getProportionateScreenWidth(80),
          height: getProportionateScreenHeight(130),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    fontSize: 11
                ),
              ),
            ],
          ),

      ),
    );
  }
}