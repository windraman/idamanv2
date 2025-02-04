import 'package:flutter/material.dart';
import 'package:idaman/components/icon_btn_with_counter.dart';
import 'package:idaman/components/rounded_img_btn.dart';
import 'package:idaman/screen/Notifikasi/notifikasi_screen.dart';

import '../../../../size_config.dart';



class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
    required this.numOfCart,
    required this.numOfNotif,
    required this.press2,
  }) : super(key: key);

  final int numOfCart;
  final int numOfNotif;
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
          RoundedImgBtn(
              icon: "assets/images/logo_idaman.png",
              press: (){

              }
          ),
          Text("Idaman"),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfItems: widget.numOfNotif,
            press: () {
              Navigator.pushNamed(context, NotifikasiScreen.routeName);
            },
          ),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Privilege.svg",
          //   numOfItems: int.parse(MyApp.localStorage.get("privilegeId").toString()),
          //   press: () {
          //     Navigator.pushNamed(context, AccountScreen.routeName);
          //   },
          // )

        ],
      ),
    );
  }
}