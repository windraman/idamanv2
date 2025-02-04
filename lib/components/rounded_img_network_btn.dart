import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class RoundedImgNetworkBtn extends StatelessWidget {
  const RoundedImgNetworkBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
    required this.caption,
  }) : super(key: key);

  final String icon;
  final GestureTapCancelCallback press;
  final bool showShadow;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor, padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: press,
        child: Image.network(
            icon,
          fit: BoxFit.contain,
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
