import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idaman/constants.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/Akun.dart';
import 'package:idaman/screen/account/components/akun_list.dart';
import 'package:idaman/screen/home/home_screen.dart';
import 'package:idaman/screen/kurir/home/home_screen.dart';
import 'package:idaman/screen/penjual/home/home_screen.dart';

import '../../../api/api_service.dart';
import '../../../models/login_model.dart';
import '../../Homecare/homecare_screen.dart';

enum SingingCharacter { Warga, Penjual, Kurir }



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<AkunModel> akuns = [];

  void initState(){
    getAkun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: akuns.length,
        itemBuilder: (context,index){
            return AkunList(
                text: akuns[index].name,
                ics: akuns[index].cmsPrivilegesId.toString() == MyApp.localStorage.get("privilegeId").toString() ?  Icon(Icons.check_circle) : Icon(Icons.radio_button_unchecked),
              press: () async{
                APIService apiService = new APIService();
                LoginRequestModel loginRequestModel = new LoginRequestModel(nik: MyApp.localStorage.getString("nik").toString(), password: MyApp.localStorage.getString("pass").toString(), appId: appId, appToken: appToken, modeAkses: "berubah", privId: akuns[index].cmsPrivilegesId.toString());
                await apiService.berubah(loginRequestModel).then((value) {
                  print(value);
                  if(value==1){
                    MyApp.localStorage.setString("privilegeId", akuns[index].cmsPrivilegesId.toString());
                    MyApp.localStorage.setString("privilegeName", akuns[index].name.toString());
                    setState(() {
                      if(akuns[index].cmsPrivilegesId=="32"){
                        Navigator.pushNamedAndRemoveUntil(context, KurirHomeScreen.routeName, (route) => false);
                      }else if(akuns[index].cmsPrivilegesId=="2"){
                        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                      }else if(akuns[index].cmsPrivilegesId=="31"){
                        Navigator.pushNamedAndRemoveUntil(context, PenjualHomeScreen.routeName, (route) => false);
                      }else if(akuns[index].cmsPrivilegesId=="27"){
                        Navigator.pushNamedAndRemoveUntil(context, HomecareScreen.routeName, (route) => false);
                      }
                    });
                  } else{
                    print("berubah gagal !");
                  }
                });

              },
            );
        },
    );
  }

  void getAkun(){
    // print(MyApp.localStorage.get("privilegeId").toString());
    JsonCodec codec = new JsonCodec();
    try{
      var akun = codec.decode(MyApp.localStorage.get('multi_privs').toString());
      for(String aku in akun){
        var ak = json.decode(aku);
        AkunModel am = new AkunModel(
            cmsPrivilegesId: ak["cms_privileges_id"],
            name: ak["name"]
        );
        akuns.add(am);
      }
      setState(() {

      });
    } catch(e) {
      print("Error: $e");
    }
  }

  berubah(int index) async {
    APIService apiService = new APIService();
    LoginRequestModel loginRequestModel = new LoginRequestModel(nik: MyApp.localStorage.getString("nik").toString(), password: MyApp.localStorage.getString("pass").toString(), appId: appId, appToken: appToken, modeAkses: "berubah", privId: akuns[index].cmsPrivilegesId.toString());
    await apiService.berubah(loginRequestModel).then((value) {
        print(value);
        return value;
    });
  }
}
