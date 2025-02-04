import 'package:flutter/material.dart';
import 'package:idaman/components/custom_svg_icon.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/components/form_error.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String nohp = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            buildHPFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            DefaultButton(
              text: "Kirim",
              press: () {
                errors.clear();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  //if()
                }
              },
              warna: Colors.blue,
            ),
          ],
        ),
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
          }else if(!nikValidatorRegExp.hasMatch(value)){
            setState(() {
              errors.add("Format Nomor HP salah");
            });
          }
        }

        return null;
      },
      onChanged: (tempValue) => nohp = tempValue,
      onSaved: (newValue) => nohp = newValue!,
      decoration: const InputDecoration(
          hintText: "Nomor HP Terdaftar",
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            "",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg")
      ),
    );
  }
}
