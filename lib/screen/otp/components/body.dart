import 'package:flutter/material.dart';
import 'package:idaman/constants.dart';
import 'package:idaman/models/Register.dart';
import 'package:idaman/size_config.dart';

import 'otp_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.model}) : super(key: key);

  final RegisterModel model;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children:  [
            SizedBox(height: getProportionateScreenWidth(50)),
            const Text(
                "Verifikasi kode OTP",
                style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
             const Text(
                "Nomor Kami 0858-7878-6000 telah mengirimkan \nkode OTP ke nomor anda",
              textAlign: TextAlign.center,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Kode ini expired dalam "),
                buildTimer()
              ],
            ),
            SizedBox(height: getProportionateScreenWidth(30)),
            OtpForm(model: widget.model),
            Spacer(),
            // GestureDetector(
            //   onTap: (){
            //       //kitim ulang, tapi cek sampai 3 kali percobaan
            //   },
            //   child: Text(
            //     "Kirim Ulang kode OTP",
            //     style: TextStyle(
            //       color: Colors.blue,
            //       decoration: TextDecoration.underline
            //     ),
            //   ),
            // ),
            Spacer(flex:3)
          ],
        ),
      ),
    );
  }

  TweenAnimationBuilder<num> buildTimer() {
    try {
      return TweenAnimationBuilder(
          tween: Tween(begin: 90.0,end: 0),
          duration: const Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: const TextStyle(color: kPrimaryColor),
          ),
        onEnd: (){

        },
      );
    } catch (e, s) {
      debugPrint(s.toString());
    }

    return TweenAnimationBuilder(
      tween: Tween(begin: 90.0,end: 0),
      duration: const Duration(seconds: 30),
      builder: (context, value, child) => const Text(
        "00:00",
        style: TextStyle(color: kPrimaryColor),
      ),
    );
  }
}



