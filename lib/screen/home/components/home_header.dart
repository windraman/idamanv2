import 'package:flutter/material.dart';
import 'package:idaman/components/icon_btn_with_counter.dart';
import 'package:idaman/main.dart';
import 'package:idaman/screen/account/account_screen.dart';

import '../../../components/rounded_img_btn.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SearchField(),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Cart Icon.svg",
          //   numOfItems: widget.numOfCart,
          //   press: widget.press1
          // ),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfItems: widget.numOfNotif,
          //   press: () {
          //
          //   },
          // ),
          RoundedImgBtn(
              icon: "assets/images/logo_idaman.png",
              press: (){

              }
          ),
          Spacer(),
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