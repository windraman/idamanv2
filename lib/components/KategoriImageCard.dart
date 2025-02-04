import 'package:flutter/material.dart';

import '../size_config.dart';

class KategoriImageCard extends StatelessWidget {
  const KategoriImageCard({
    Key? key,
    required this.imageSrc,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String imageSrc;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  child: Image.asset(
                    imageSrc,
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