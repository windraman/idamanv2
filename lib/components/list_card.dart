import 'package:flutter/material.dart';

import '../size_config.dart';


class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.category,
    required this.numOfBrands,
    required this.press,
    required this.width,
    required this.height,
    required this.status
  }) : super(key: key);

  final String category, status;
  final int numOfBrands;
  final GestureTapCallback press;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.white70,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: press,
            child: SizedBox(
              width: getProportionateScreenWidth(width),
              height: getProportionateScreenWidth(height),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF343434).withOpacity(0.4),
                            Color(0xFF343434).withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15.0),
                        vertical: getProportionateScreenWidth(10),
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "$category\n",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: "$numOfBrands Produk\n",
                              style: TextStyle(
                                color: Colors.blueGrey
                              )
                            ),
                            TextSpan(
                              text: "status : $status",
                              style: TextStyle(
                                color: status == "ditolak" ? Colors.red : status == "survey" ? Colors.green : status == "approve" ? Colors.blue : Colors.deepOrange  ,
                                fontSize: getProportionateScreenWidth(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}