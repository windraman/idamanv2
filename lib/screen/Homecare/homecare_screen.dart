import 'package:flutter/material.dart';
import 'package:idaman/screen/Homecare/components/homecare_bottom_nav_bar.dart';

import '../../api/api_service.dart';
import '../../enums.dart';
import '../Homecare/components/body.dart';

class HomecareScreen extends StatelessWidget {
  const HomecareScreen({Key? key}) : super(key: key);

  static String routeName = "/homecare";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: HomecareBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  loadHomecare(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getAllHomecare().then((value) {
      data = value;
    });
    // setState(() {});
  }
}
