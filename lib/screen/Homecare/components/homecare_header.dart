import 'package:flutter/material.dart';
import 'package:idaman/components/icon_btn_with_counter.dart';
import 'package:idaman/main.dart';
import 'package:idaman/screen/account/account_screen.dart';

import '../../../components/rounded_svg_btn.dart';
import '../../../size_config.dart';


class HomecareHeader extends StatefulWidget {
  const HomecareHeader({
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
  State<HomecareHeader> createState() => _HomecareHeaderState();
}

class _HomecareHeaderState extends State<HomecareHeader> {
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
          RoundedSvgBtn(
              icon: "assets/icons/juara-homecare.svg",
              press: (){

              }
          ),

          IconBtnWithCounter(
            svgSrc: "assets/icons/Privilege.svg",
            numOfItems: int.parse(MyApp.localStorage.get("privilegeId").toString()),
            press: () {
              Navigator.pushNamed(context, AccountScreen.routeName);
            },
          )

        ],
      ),
    );
  }
}