import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/custom_svg_icon.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/components/form_error.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/login_model.dart';
import 'package:idaman/screen/home/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../mendaftar/scan/scan_screen.dart';
import '../../sign_in/sign_in_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  String nik = "";
  String password = "";
  bool remember = false;

  late LoginRequestModel loginRequestModel;

  void initState(){
    super.initState();
    MyApp.localStorage.reload();
    loginRequestModel = new LoginRequestModel(nik: "",password: "", appId: "", appToken: "", modeAkses: "", privId: "");
    // loadData("nik");
    // if(nik != "null") {
    //   if(nik.length == 16) {
    //     loginRequestModel = new LoginRequestModel(nik: nik,password: password);
    //     alreadyLogin();
    //   }
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildNikFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Checkbox(
                  //     value: remember,
                  //     activeColor: kPrimaryColor,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         remember = value!;
                  //       });
                  //     }
                  // ),
                  // const Text("ingat saya"),
                  const Spacer(),
                  // GestureDetector(
                  //   onTap: () =>
                  //       Navigator.pushNamed(
                  //           context, ForgotPasswordScreen.routeName),
                  //   child: const Text(
                  //     "Lupa password ?",
                  //     style: TextStyle(decoration: TextDecoration.underline),
                  //   ),
                  // )
                ],
              ),
            ),
            DefaultButton(
              text: "Login",
              press: () {
                errors.clear();
                bool valid = _formKey.currentState!.validate();

                login();
                validateAndSave();
                errors.clear();
              },
              warna: Colors.blue,
            ),
            const Text("Belum memiliki akun 1login ?"),
            DefaultButton(
              text: "Mendaftar",
              press: () async{
                if(MyApp.localStorage.getString("nik").toString().isEmpty || MyApp.localStorage.getString("nik").toString()== "null" || MyApp.localStorage.getString("nik").toString()== "") {
                  print(await Permission.camera.status);
                  print(trackAuthStatus);
                  if(trackAuthStatus=="TrackingStatus.authorized"){
                    daftar(context);
                  }else if(trackAuthStatus=="TrackingStatus.notSupported"){
                    daftar(context);
                  }else if(trackAuthStatus=="Unknown"){
                    MyApp.initTrackAuth(context);
                  }else{
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Berbagi data'),
                        content: const Text(
                          "Fitur mendaftar di nonaktifkan karena anda tidak menyetujui untuk berbagi data. Anda dapat mengubahnya di app settings.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              openAppSettings();
                            },
                            child: const Text('App Settings'),
                          ),
                        ],
                      ),
                    );
                  }


                }else{
                  final snackBar = SnackBar(
                      content: Text("Anda Sudah Login !")
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              warna: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  daftar(BuildContext context) async{
    if(await Permission.camera.status.isDenied){
      MyApp.useCamera(
          context,
          "Akses Kamera",
          "Akses kamera dan audio diperlukan untuk proses pendaftaran.",
              () {
            Navigator.pop(context);
            Navigator.pushNamed(
                context,
                SignInScreen.routeName,
                arguments: SignInScreenArguments(
                    ktpPath: "",
                    recText: "",
                    scannedNik: "",
                    scannedNama: ""
                )
            );
          },
              () async{
            if(await Permission.camera.request().isGranted) {
              if(await Permission.microphone.request().isGranted) {
                Navigator.pushNamed(
                    context,
                    ScanScreen.routeName
                );
              }
            }
          }
      );
    }else{
      Navigator.pushNamed(
          context,
          ScanScreen.routeName
      );
    }
  }

  TextFormField buildNikFormField() {
    return TextFormField(
      maxLength: 16,
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            errors.add("Harap isi NIK");
          });
        } else if (!nikValidatorRegExp.hasMatch(value)) {
          setState(() {
            errors.add("Format NIK salah");
          });
        } else {
          if (value.length < 16) {
            setState(() {
              errors.add("NIK terlalu pendek");
            });
          }
        }
        return null;
      },
      onChanged: (tempValue) => loginRequestModel.nik = tempValue,
      onSaved: (newValue) {
        loginRequestModel.nik = newValue!;
      },
      decoration: const InputDecoration(
          hintText: "Masukkan NIK anda",
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            "NIK",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Bill Icon.svg")
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else {
          if (value.length < 6) {
            setState(() {
              errors.add("Password terlalu pendek");
            });
          }
          return "";
        }
      },
      onChanged: (tempValue) => loginRequestModel.password = tempValue,
      onSaved: (newValue) =>
      loginRequestModel.password = newValue!,
      decoration: const InputDecoration(
          hintText: "Masukkan Password",
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            "Password",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg")
      ),
    );
  }

  loadData(String key) async {
    if (key == "nik") {
      nik = MyApp.localStorage.get("nik").toString();

      if (nik != "null") {
        if (nik.length == 16) {
          password = MyApp.localStorage.get("pass").toString();
          // photo = MyApp.localStorage.get("photo").toString();
          // privilegeId = MyApp.localStorage.get("privilegeId").toString();
        }
      } else {
        nik = "";
        password = "";
      }
    }

    setState(() {});
  }

  login() {
    if (errors.length==0) {
      APIService apiService = new APIService();
      apiService.login(loginRequestModel).then((value) {
        print(value.telp);
        // setState(() {
        //   isApiCallProcess = false;
        // });
        if (value.apiStatus == 1) {
          MyApp.localStorage.setString("nik", loginRequestModel.nik);
          MyApp.localStorage.setString("id", value.id);
          MyApp.localStorage.setString("displayName", value.displayName);
          MyApp.localStorage.setString("privilegeName", "UMKM");
          MyApp.localStorage.setString("pass", loginRequestModel.password);
          MyApp.localStorage.setString("photo", value.photo);
          MyApp.localStorage.setString("privilegeId", "2");
          MyApp.localStorage.setString("icon", value.icon);
          MyApp.localStorage.setString("telp", value.telp);
          MyApp.localStorage.setString("district_id", value.district_id);
          MyApp.localStorage.setString("village_id", value.village_id);
          MyApp.localStorage.setString("multi_privs", json.encode(value.multiPrivs));

          // MyApp.reloadSF();
          setState(() {
            
          });



          final snackBar = SnackBar(
              content: Text("Login ${MyApp.localStorage.getString("nik")} Berhasil ")
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          MyApp.initBGService();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                }
            ),
                (route) => false,
          );
        } else {
          final snackBar = SnackBar(
              content: Text(value.apiMessage)
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      final snackBar = SnackBar(
          content: Text(errors[0])
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //errors.clear();
    }
  }

  alreadyLogin(){
    APIService apiService = new APIService();
    apiService.login(loginRequestModel).then((value) {
      if (value.apiStatus == 1) {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context){
                return HomeScreen();
              }
          ),
              (route) => false,
        );
      } else {
        final snackBar = SnackBar(
            content: Text(value.apiMessage)
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    debugPrint(form?.validate().toString());
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}


