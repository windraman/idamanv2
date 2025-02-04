import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    Key? key,
    required this.val,
    required this.text,
    required this.press,
    required this.warnabg,
    required this.warnatext,
  }) : super(key: key);

  final String val;
  final String text;
  final Color warnabg;
  final Color warnatext;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        press();
      },
      child: SizedBox(
          width: getProportionateScreenWidth(25),
          height: getProportionateScreenHeight(30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    decoration: BoxDecoration(
                      color: warnabg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                        val,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(23),
                        color: warnatext
                      ),
                    ),
                    ),
                  ),
                ),
              //SizedBox(height: 5),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12)
                ),
              )
            ],
          )
      ),
    );
  }

}