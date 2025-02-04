import 'package:flutter/material.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/main.dart';
import 'package:idaman/screen/mendaftar/scan/scan_screen.dart';
import 'package:idaman/screen/sign_in/sign_in_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:idaman/constants.dart';

import '../../../size_config.dart';

class DaftarBanner extends StatefulWidget {
  const DaftarBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DaftarBanner> createState() => _DaftarBannerState();
}

class _DaftarBannerState extends State<DaftarBanner> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/flat_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Daftarkan Diri Anda Di Idaman !",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(23),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(15)),
              Text(
                "Ada ribuan pelaku usaha mikromkecil dan menengah serta ekraf yang tergabung di Idaman. Dapatkan Pelanggan, Fasilitasi kerjasama, Pelatihan, Seminar, Bantuan Permodalan dan keunggulan-keunggulan lainnya. Gabung sekarang !",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenWidth(15)),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: DefaultButton(
                  text: "DAFTAR",
                  press: () async {
                    print(trackAuthStatus);
                    if(trackAuthStatus=="TrackingStatus.authorized") {
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
                  },
                  warna: Colors.pinkAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  daftar(BuildContext context) async{
    if(MyApp.localStorage.getString("nik").toString().isEmpty || MyApp.localStorage.getString("nik").toString()== "null" || MyApp.localStorage.getString("nik").toString()== "") {
      print(await Permission.camera.status);
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
                  Navigator.pop(context);
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

    }else{
      final snackBar = SnackBar(
          content: Text("Anda Sudah Login !")
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}