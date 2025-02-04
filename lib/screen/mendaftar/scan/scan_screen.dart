
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_camera_overlay_new/flutter_camera_overlay.dart';
import 'package:flutter_camera_overlay_new/model.dart';



class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  static String routeName = "scanscreen";

  @override
  _ScanScreenState createState() => _ScanScreenState();
}


class _ScanScreenState extends State<ScanScreen> {
  OverlayFormat format = OverlayFormat.cardID3;
  int tab = 1;
  bool textScanning = false;

  String scannedText = "";
  List<String> rText = [];
  String ktpPath = "";
  String selfiePath = "";

  double persenNumber = 0;

  String scannedNik = "";
  String scannedNama = "";

  int failedAttempt = 0;
  bool suspect = false;


  @override
  void initState() {
    setState(() {
      format = OverlayFormat.cardID3;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder<List<CameraDescription>?>(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Tidak ada kamera di temukan',
                        style: TextStyle(color: Colors.black),
                      ));
                }
                return CameraOverlay(
                    snapshot.data!.first,
                    CardOverlay.byFormat(format),
                        (XFile file) {
                      try {
                        if (file.path.isNotEmpty) {
                          textScanning = true;
                          ktpPath = file.path;
                          getRecognisedText(file);

                          // getFaces(file);
                        }
                      } catch (e) {
                        textScanning = false;
                        scannedText = "Error ketika memindai.";
                      }
                    },
                    info: 'Posisikan KTP anda tepat pada kotak dan pastikan foto KTP terbaca dengan sempurna.',
                    label: 'Memindai KTP'
                );
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Fetching cameras',
                      style: TextStyle(color: Colors.black),
                    ));
              }
            },
          ),
        ));
  }

  void getRecognisedText(XFile image) async {
    // final inputImage = InputImage.fromFilePath(image.path);
    // final textDetector = GoogleMlKit.vision.textRecognizer();
    // RecognizedText recognisedText = await textDetector.processImage(inputImage);
    // await textDetector.close();
    //
    // scannedText = "";
    // //print(recognisedText.text);
    //
    // List<TextBlock> b = recognisedText.blocks;
    // int blok = -1;
    // for (TextBlock block in recognisedText.blocks) {
    //   blok+=1;
    //   int baris = 0;
    //   for (TextLine line in block.lines) {
    //     print(line.text +  "($blok)($baris)");
    //     baris+=1;
    //     if(line.text.length == 16 && line.elements.length ==1) {
    //       suspect = true;
    //       double numnum = 0;
    //       for(String c in line.text.characters){
    //         if(nikValidatorRegExp.hasMatch(c)){
    //           numnum += 1;
    //         }
    //       }
    //
    //       double persen = numnum/line.text.length*100;
    //
    //       if(persen>=75){
    //         String norm = normalizeText(line.text);
    //         numnum = 0;
    //         for(String c in norm.characters){
    //           if(nikValidatorRegExp.hasMatch(c)){
    //             numnum += 1;
    //           }
    //         }
    //         persenNumber = numnum/norm.length*100;
    //         print(persenNumber);
    //         this.scannedText = scannedText + line.text + "\n";
    //
    //           if(persenNumber <= 99){
    //             failedAttempt += 1;
    //             Fluttertoast.showToast(
    //                 msg: "Photo KTP Kurang Jelas ! harap coba lagi.(${failedAttempt})",
    //                 toastLength: Toast.LENGTH_SHORT,
    //                 gravity: ToastGravity.CENTER,
    //                 timeInSecForIosWeb: 1,
    //                 backgroundColor: Colors.red,
    //                 textColor: Colors.white,
    //                 fontSize: 16.0
    //             );
    //           }else{
    //             scannedNik = norm;
    //             scannedNama = b[2].lines[0].text;
    //             // List<String> ttl = b[2].lines[1].text.split(",");
    //             // List<String> rtrw = b[5].lines[0].text.split("/");
    //             // DataDiriPostModel ktp = new DataDiriPostModel(
    //             //     id: "",
    //             //     nama_lgkp: b[1].lines[0].text,
    //             //     jk: b[2].lines[1].text,
    //             //     tmpt_lhr: ttl[0],
    //             //     tgl_lhr: ttl[1],
    //             //     pddk_akhir_id: "",
    //             //     pekerjaan_id: "",
    //             //     alamat2: b[2].lines[3].text,
    //             //     rt: rtrw[0],
    //             //     rw: rtrw[1],
    //             //     nama_prop: b[0].lines[0].text.replaceAll("PROVINSI", ""),
    //             //     nama_kab: b[0].lines[1].text.replaceAll("KABUPATEN", ""),
    //             //     nama_kec: b[3].lines[2].text,
    //             //     nama_kel: b[3].lines[1].text,
    //             //     no_kk: "",
    //             //     updated_by: "1"
    //             // );
    //
    //             //print(ktp.toJson());
    //             Navigator.pushNamed(
    //                 context,
    //                 SignInScreen.routeName,
    //                 arguments: SignInScreenArguments(
    //                     ktpPath: ktpPath,
    //                     recText: scannedText,
    //                     scannedNik: scannedNik,
    //                   scannedNama:  scannedNama
    //                 )
    //             );
    //           }
    //       }else{
    //         failedAttempt += 1;
    //         Fluttertoast.showToast(
    //             msg: "Photo KTP Kurang Jelas ! harap coba lagi.(${failedAttempt})",
    //             toastLength: Toast.LENGTH_SHORT,
    //             gravity: ToastGravity.CENTER,
    //             timeInSecForIosWeb: 1,
    //             backgroundColor: Colors.red,
    //             textColor: Colors.white,
    //             fontSize: 16.0
    //         );
    //       }
    //     }
    //   }
    // }
    // if(!suspect){
    //   failedAttempt += 1;
    //   Fluttertoast.showToast(
    //       msg: "Photo KTP Kurang Jelas ! harap coba lagi.(${failedAttempt})",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
    // }
    // if(failedAttempt >= 7){
    //   Fluttertoast.showToast(
    //       msg: "Gagal membaca data KTP, Beralih ke Moda Manual.",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
    //   failedAttempt = 0;
    //   Navigator.pushNamed(
    //       context,
    //       SignInScreen.routeName,
    //       arguments: SignInScreenArguments(
    //           ktpPath: ktpPath,
    //           recText: "",
    //           scannedNik: "",
    //           scannedNama:  ""
    //       )
    //   );
    // }
    // textScanning = false;
    // suspect = false;
    // setState(() {
    //
    // });

  }

  String normalizeText(String str){
    String str2 = str.replaceAll(":", "");
    String str3 = str2.replaceAll("L", "6");
    String str4 = str3.replaceAll("b", "6");
    String str5 = str4.replaceAll("B", "8");
    String str6 = str5.replaceAll("O", "0");
    String str7 = str6.replaceAll("D", "0");

    //print(nikValidatorRegExp.hasMatch(nik));

    print( "After : " + str7);

    return str7;
  }

  void getFaces(XFile image) async {
    // final inputImage = InputImage.fromFilePath(image.path);
    // final faceDetector = GoogleMlKit.vision.faceDetector();
    // final faces = await faceDetector.processImage(inputImage);
    // await faceDetector.close();
    //
    // for (final face in faces) {
    //   print( 'face: ${face.boundingBox}\n\n');
    // }

    setState(() {});
  }
}

