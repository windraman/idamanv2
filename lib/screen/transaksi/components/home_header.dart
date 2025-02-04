import 'package:flutter/material.dart';

import '../../../../size_config.dart';
import '../../../components/rounded_img_btn.dart';
import '../../../components/rounded_img_network_btn.dart';
import '../../../main.dart';
import '../../profile/profile_screen.dart';



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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedImgBtn(
                  icon: "assets/images/logo_tjsl_round.png",
                  press: (){

                  }
              ),
              Text(
                  "Transaksi",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              // IconBtnWithCounter(
              //   svgSrc: "assets/icons/Bell.svg",
              //   numOfItems: widget.numOfNotif,
              //   press: () {
              //     Navigator.pushNamed(context, NotifikasiScreen.routeName);
              //   },
              // ),
              // IconBtnWithCounter(
              //   svgSrc: "assets/icons/Privilege.svg",
              //   numOfItems: int.parse(MyApp.localStorage.get("privilegeId").toString()),
              //   press: () {
              //     Navigator.pushNamed(context, AccountScreen.routeName);
              //   },
              // )
              RoundedImgNetworkBtn(
                  icon: MyApp.localStorage.getString("photo").toString(),
                  press: (){
                      Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                  caption: MyApp.localStorage.getString("displayName").toString()
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 70,
                child: Text(
                  MyApp.localStorage.getString("displayName").toString(),
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.white70
                  ),
                  maxLines: 1,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}