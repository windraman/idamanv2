import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/Wilayah.dart';
import 'package:idaman/models/aspirasi_post.dart';
import 'package:idaman/screen/penjual/usaha/components/profile_pic_new.dart';
import 'package:permission_handler/permission_handler.dart';



import '../../../../size_config.dart';

class AspirasiScreen extends StatefulWidget {
  const AspirasiScreen({
    Key? key
  }) : super(key: key);



  static String routeName = "aspirasi";



  @override
  State<AspirasiScreen> createState() => _AspirasiScreenState();
}

class _AspirasiScreenState extends State<AspirasiScreen> {
  // LocationModel lm = new LocationModel(latitude: "", longitude: "", isMock: true);


  List<String> errors = [];
  final _formKey = new GlobalKey<FormState>();


  XFile? imageFile;
  File? croppedImage;

  String selPhoto = "";

  AspirasiPostModel aspirasiPostModel = new AspirasiPostModel(
      cms_user_id: MyApp.localStorage.getString("id").toString(),
      privilege_tujuan: "34",
      judul: "Apirasi " + MyApp.localStorage.getString("displayName").toString(),
      isi: "",
      gambar: ""
  );


  @override
  void initState(){
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Jaring Aspirasi"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Jangan Ragu untuk menyampaikan aspirasi Anda pada kami.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20

                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildInputForm(
                          aspirasiPostModel,
                          "Harap masukkan Aspirasi",
                          "Masukkan aspirasi anda",
                          "Aspirasi",
                          ""
                        ),
                        SizedBox(height: getProportionateScreenWidth(15)),
                        if(croppedImage==null)
                        ProfilePicNew(
                            photo: Image.asset(
                                "assets/images/noimage.png",
                              width: 100,
                            ) ,
                            take: () async{
                              if(await Permission.camera.status.isDenied){
                                MyApp.useCamera(
                                    context,
                                    "Akses Kamera",
                                    "Aplikasi ini memerlukan akses kamera untuk mengmbil gambar aktual. \n\nGambar aktual anda akan tersedia secara publik atau sebagian dan tersimpan dalam server kami sebagai pendataan.",
                                        () {
                                      Navigator.pop(context);
                                    },
                                        () {
                                      Navigator.pop(context);
                                      getImage(ImageSource.camera);
                                    }
                                );
                              }else{
                                getImage(ImageSource.camera);
                              }
                            }
                        ),
                        if(croppedImage!=null)
                          ProfilePicNew(
                              photo: Image.file(
                                File(croppedImage!.path),
                                width: 100,
                              ) ,
                              take: () async{
                                print(await Permission.camera.status);
                                if(await Permission.camera.status.isDenied){
                                  MyApp.useCamera(
                                      context,
                                      "Akses Kamera",
                                      "Aplikasi ini memerlukan akses kamera untuk mengmbil gambar aktual. \n\nGambar aktual anda akan tersedia secara publik atau sebagian dan tersimpan dalam server kami sebagai pendataan.",
                                          () {
                                        Navigator.pop(context);
                                      },
                                          () {
                                        Navigator.pop(context);
                                        getImage(ImageSource.camera);
                                      }
                                  );
                                }else{
                                  getImage(ImageSource.camera);
                                }
                              }
                          ),
                        SizedBox(height: getProportionateScreenWidth(15)),
                        DefaultButton(
                          text: "KIRIM",
                          press: () async {
                            validateAndSave();
                              aspirasiPostModel.gambar = selPhoto;
                              print(aspirasiPostModel.toJson());
                              if(aspirasiPostModel.isi.length > 0) {
                                APIService api = new APIService();

                                PostResponseModel res = await api.addAspirasi(
                                    aspirasiPostModel);
                                print(res);
                                if (res.api_status == 1) {
                                  final snackBar = SnackBar(
                                      content: Text(
                                          "aspirasi anda berhasil dikirim.")
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar);
                                  Navigator.pop(context);
                                } else {
                                  final snackBar = SnackBar(
                                      content: Text(res.api_message)
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar);
                                }

                                setState(() {

                                });
                              }else{
                                final snackBar = SnackBar(
                                    content: Text("Harap isi aspirasi !")
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar);
                              }
                          },
                          warna: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),


              ]
          ),
        ),
      ),
    );
  }

   buildInputForm(AspirasiPostModel model, String error, String hint, String label, String initValue) {
    return Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: Container(
          height: 180,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  errors.add(error);
                });
              }
              return null;
            },
            onChanged: (tempValue){
              if(label=="Aspirasi") {
                print(tempValue);
                model.isi = tempValue;
              }
            },
            onSaved: (newValue) {
              if(label=="Aspirasi") {
                model.isi = newValue!;
              }
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              label: Text(
                label,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            initialValue: initValue,
            maxLines: 5,
          ),
        ),
      );
  }



  Widget _customDropDownExample(BuildContext context, WilayahModel? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),

        title: Text(item.name),
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(BuildContext context, WilayahModel? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
      ),
    );
  }



  void getImage(ImageSource source) async {
        try {
          final pickedImage = await ImagePicker().pickImage(source: source);
          if (pickedImage != null) {
            CroppedFile? cropped = await ImageCropper().cropImage(
                sourcePath: pickedImage.path,
                compressFormat: ImageCompressFormat.jpg,
                compressQuality: 100
            );
            croppedImage = File((await cropped?.path)!);
            selPhoto = (await cropped?.path)!;
            setState(() {

            });
          }
        } catch (e) {
          print("take camera " + e.toString());
          imageFile = null;
        }
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

