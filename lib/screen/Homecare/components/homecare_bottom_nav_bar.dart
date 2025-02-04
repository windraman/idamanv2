import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idaman/screen/Chat/chat_screen.dart';
import 'package:idaman/screen/home/home_screen.dart';
import 'package:idaman/screen/profile/profile_screen.dart';

import '../../../api/api_service.dart';
import '../../../constants.dart';
import '../../../enums.dart';
import 'body.dart';

class HomecareBottomNavBar extends StatelessWidget {
  const HomecareBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Discover.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: (){
                  loadHomecare(context,"diterima");
                }
              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Question mark.svg"),
                onPressed: () {
                  Navigator.pushNamed(context, ChatScreen.routeName);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }

  loadHomecare(BuildContext context, String status) async{
    //data?.clear();
    APIService apiService = new APIService();
    await apiService.getHomecare(status).then((value) {
      data = value;
    });
    //setState(() {});
  }
}
