import 'package:flutter/material.dart';
import 'package:idaman/components/icon_btn_with_counter.dart';
import 'package:idaman/components/rounded_img_btn.dart';
import 'package:idaman/screen/login/login_screen.dart';

import '../../../size_config.dart';


class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
    required this.numOfCart,
    required this.numOfNotif,
    required this.press1,
    required this.press2,
  }) : super(key: key);

  final int numOfCart;
  final int numOfNotif;
  final Function() press1;
  final Function() press2;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SearchField(),
          RoundedImgBtn(
              icon: "assets/images/logo_idaman.png",
              press: (){

              }
          ),

          IconBtnWithCounter(
            svgSrc: "assets/icons/Lock.svg",
            numOfItems: 0,
            press: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
          )

        ],
      ),
    );
  }
}