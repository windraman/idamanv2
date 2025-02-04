import 'package:flutter/material.dart';
import 'package:idaman/screen/forgot_password/components/forgot_password_form.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(70)),
              Text(
                  "Lupa Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold
                  )
              ),
              const ForgotPasswordForm()
            ],
          ),
        )
    );
  }
}
