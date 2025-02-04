import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/login_model.dart';
import 'package:idaman/screen/home/home_screen.dart';
import 'package:idaman/screen/kurir/home/home_screen.dart';
import 'package:idaman/screen/penjual/home/home_screen.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../size_config.dart';
import 'login_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late LoginRequestModel loginRequestModel;

  void initState(){
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(70)),
              Text(
                  "1LOGIN",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold
                  )
              ),
              const LoginForm()
            ],
          ),
        )
    );
  }

  loadData() async {

   String nik = MyApp.localStorage.get("nik").toString();
   print(nik);
   print("nik : " + nik + " id :" + MyApp.localStorage.get("id").toString()+ " multi_privs :" + MyApp.localStorage.get("multi_privs").toString());
    if (nik != "null") {
      if (nik.length == 16) {
            loginRequestModel = new LoginRequestModel(nik: nik,password: MyApp.localStorage.get("pass").toString(),appId: appId,appToken: appToken,modeAkses: "login",privId: MyApp.localStorage.get("priv_id").toString());
            alreadyLogin();
        }
      }
    }

  alreadyLogin(){
    //print("usdahhhh");
    APIService apiService = new APIService();
    apiService.login(loginRequestModel).then((value) {

      if (value.apiStatus == 1) {
        MyApp.initBGService();
        if(MyApp.localStorage.get('privilegeId').toString()=="2") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                }
            ),
                (route) => false,
          );
        }else if(MyApp.localStorage.get('privilegeId').toString()=="30") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return KurirHomeScreen();
                }
            ),
                (route) => false,
          );
        }else if(MyApp.localStorage.get('privilegeId').toString()=="31") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return PenjualHomeScreen();
                }
            ),
                (route) => false,
          );
        }
      } else {
        final snackBar = SnackBar(
            content: Text(value.apiMessage)
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}

