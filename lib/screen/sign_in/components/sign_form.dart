import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/custom_svg_icon.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/components/form_error.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/Register.dart';
import 'package:idaman/models/register_post.dart';
import 'package:idaman/screen/login/login_screen.dart';
import 'package:idaman/screen/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../sign_in_screen.dart';


class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String nik = "";
  String nama = "";
  String nohp = "";
  String pass1 = "";
  String pass2 = "";
  @override
  Widget build(BuildContext context) {
    final SignInScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as SignInScreenArguments;

    print(args.recText);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            buildNikFormField(args.scannedNik),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildNamaFormField(args.scannedNama),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildHPFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPassworLagiFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            DefaultButton(
              text: "KIRIM",
              press: () async {
                print(args.ktpPath);
                errors.clear();
                bool valid = _formKey.currentState!.validate();

                print(errors.length);
                print(valid);
                if(valid && errors.length == 0){
                  _formKey.currentState!.save();
                  APIService api = new APIService();
                  PostResponseModel res = await api.registrasiV2(
                    RegisterPostModel(
                        nik: nik,
                        nama_lgkp: nama,
                        no_telp: nohp,
                        password: pass2,
                        file_ktp: args.ktpPath,
                        file_selfie: ""
                    )
                  );
                  if(res.api_status==1){
                    RegisterModel model = new RegisterModel(
                        nik: nik,
                        nama_lgkp: nama,
                        no_telp: nohp,
                        password: pass2,
                        otp: ""
                    );
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        OtpScreen.routeName,
                            (route) => true,
                    arguments: OtpScreenArguments(model: model));
                  }else{

                    final snackBar = SnackBar(
                        content: Text(res.api_message)
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }else{

                  // setState(() {
                  //
                  // });
                }


              },
              warna: Colors.orange,
            ),
            const Text("Sudah memiliki akun 1login ?"),
            DefaultButton(
              text: "Login",
              press: (){
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => true);
              },
              warna: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPassworLagiFormField() {
    return TextFormField(
      obscureText: true,
      validator: (value){
        if(value!.isEmpty){
          setState(() {
            errors.add(kPassNullError);
          });
        }else{
          if(value.length<6){
            setState(() {
              errors.add("Password terlalu pendek");
            });
          }else if(pass1!=value){
            setState(() {
              errors.add("Password tidak sama");
            });
          }
        }

        return null;
      },
      onChanged: (tempValue) => pass2 = tempValue,
      onSaved: (newValue) => pass2 = newValue!,
      decoration: const InputDecoration(
          hintText: "Password sekali lagi",
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            "Password lagi",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg")
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      validator: (value){
        if(value!.isEmpty){
          setState(() {
            errors.add(kPassNullError);
          });
        }else{
          if(value.length<6){
            setState(() {
              errors.add("Password terlalu pendek");
            });
          }
        }

        return null;
      },
      onChanged: (tempValue) => pass1 = tempValue,
      onSaved: (newValue) => pass1 = newValue!,
      decoration: const InputDecoration(
          hintText: "Password baru",
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

  TextFormField buildHPFormField() {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          setState(() {
            errors.add(kPhoneNumberNullError);
          });
        }else{
          if(value.length<10){
            setState(() {
              errors.add("Nomor HP terlalu pendek");
            });
          }
        }

        return null;
      },
      onChanged: (tempValue) => nohp = tempValue,
      onSaved: (newValue) => nohp = newValue!,
      decoration: const InputDecoration(
          hintText: "Nomor HP yang aktif",
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            "Nomor HP",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg")
      ),
    );
  }

  TextFormField buildNamaFormField(String initValue) {
    return TextFormField(
      initialValue: initValue,
      validator: (value){
        if(value!.isEmpty){
          setState(() {
            errors.add(kNamelNullError);
          });
        }

        return null;
      },
      onChanged: (tempValue) => nama = tempValue,
      onSaved: (newValue) => nama = newValue!,
      decoration: const InputDecoration(
          hintText: "Nama Lengkap Sesuai KTP",
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            "Nama Lengkap",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg")
      ),
    );
  }

  TextFormField buildNikFormField(String initValue) {
    return TextFormField(
      maxLength: 16,
      initialValue:  initValue,
      validator: (value){
        if(value!.isEmpty){
          setState(() {
            errors.add("Harap isi NIK");
          });
        }else{
          if(value.length<16){
            setState(() {
              errors.add("NIK terlalu pendek");
            });
          }else if(!nikValidatorRegExp.hasMatch(value)){
            setState(() {
              errors.add("Format NIK salah");
            });
          }
        }

        return null;
      },
      onChanged: (tempValue) => nik = tempValue,
      onSaved: (newValue) => nik = newValue!,
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
}