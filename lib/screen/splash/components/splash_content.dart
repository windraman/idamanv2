import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.image,
    required this.text,
    required this.headText
  }) : super(key: key);

  final String headText, text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Spacer(),
          Text(
            headText,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(36),
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: Colors.black
              )
          ),
          const Spacer(flex: 2),
          Image.asset(
            image,
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235),
          )
        ]
    );
  }
}