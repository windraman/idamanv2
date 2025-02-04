import 'package:flutter/material.dart';
import 'package:idaman/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
    required this.warna,
  }) : super(key: key);

  final String text;
  final Function() press;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: warna,
      minimumSize: Size(double.infinity, getProportionateScreenHeight(56)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
          style: flatButtonStyle,
          onPressed: press,
          child: Text(
              text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14)
            ),
          )
      ),
    );
  }
}

