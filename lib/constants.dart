import 'package:flutter/material.dart';
import 'package:idaman/size_config.dart';


const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp nikValidatorRegExp =
    RegExp(r"^[0-9.]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Harap isi password";
const String kShortPassError = "Password terlalu pendek";
const String kMatchPassError = "Password tidak sama";
const String kNamelNullError = "Harap isi nama";
const String kPhoneNumberNullError = "Harap isi nomor HP";
const String kAddressNullError = "Harap isi alamat";
String endPointUrl = "https://webservice.siapkk.banjarbarukota.go.id/";
String endPoint = "https://webservice.siapkk.banjarbarukota.go.id/api/";
String endPointLogin = "https://webservice.siapkk.banjarbarukota.go.id/api/";
String endPointPublic = "https://webservice.siapkk.banjarbarukota.go.id/public/";
const String osmUrl = "https://webservice.siapkk.banjarbarukota.go.id/osm";
const String appId = "1208";
const String appToken = "1029384756";
String trackAuthStatus = 'Unknown';
String banner = "";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

const kDefaultPadding = 20.0;
const kPrimaryDarkColor = Color.fromRGBO(0,146,63,1);

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);

bool isWeb = false;

