import 'package:flutter/material.dart';
import 'package:idaman/screen/sign_in/components/sign_form.dart';
import 'package:idaman/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                  "1LOGIN",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold
                )
              ),
              const Text(
                  "Daftar dengan Nomor Induk Kependudukan",
                  textAlign: TextAlign.center,
              ),
              const Text(
                "Harap periksa kembali data anda!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              const SignForm()
            ],
          ),
        )
    );
  }
}




