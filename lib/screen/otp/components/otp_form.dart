import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/Register.dart';
import 'package:idaman/models/ResponseModel.dart';
import 'package:idaman/screen/login/login_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

// import 'package:sms/sms.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key, required this.model}) : super(key: key);

  final RegisterModel model;
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode = FocusNode();
  FocusNode pin3FocusNode = FocusNode();
  FocusNode pin4FocusNode = FocusNode();
  FocusNode pin5FocusNode = FocusNode();
  FocusNode pin6FocusNode = FocusNode();
  // SmsQuery query = new SmsQuery();

  @override
  void dispose(){
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    super.dispose();
  }

  void nextField(String value, FocusNode focusNode){
    if(value.length==1){
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    String otp = "";
    print(widget.model.password);
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(45),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value){
                    otp += value;
                    nextField(value,pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value){
                    otp += value;
                    nextField(value,pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value){
                    otp += value;
                    nextField(value,pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value){
                    otp += value;
                    nextField(value,pin5FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value){
                    otp += value;
                    nextField(value,pin6FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(45),
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) async {
                    otp += value;
                    pin6FocusNode.unfocus();
                    APIService api = new APIService();
                    ResponseModel res = await api.sendOtp(
                        widget.model.nik,
                        widget.model.no_telp,
                        widget.model.nama_lgkp,
                        widget.model.password,
                        otp
                    );

                    if(res.api_status == 1){
                      final snackBar = SnackBar(
                          content: Text("Proses pendaftaran berhasil, silahkan melakukan login.")
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                              (route) => false
                      );
                    }else{
                      final snackBar = SnackBar(
                          content: Text(res.api_message)
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(),

        ],
      ),
    );
  }
}