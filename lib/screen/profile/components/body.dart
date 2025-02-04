import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/DataDiri.dart';
import 'package:idaman/models/SingleResponseModel.dart';
import 'package:idaman/models/profil_post.dart';
import 'package:idaman/screen/account/account_screen.dart';
import 'package:idaman/screen/prelogin/prelogin_screen.dart';
import 'package:idaman/screen/profile/edit_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants.dart';
import '../../../main.dart';
import '../../../models/profil_post_response_model.dart';
import '../../Notifikasi/notifikasi_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? croppedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          if(croppedImage == null)
            ProfilePic(
                image: NetworkImage(MyApp.localStorage.get("photo").toString()),
              take: (){
                  _pickImageDialog(context);
              },
            ),
          if(croppedImage != null)
            ProfilePic(
              image: FileImage(File(croppedImage!.path)),
              take: () {
                _pickImageDialog(context);
                },
            ),
          Text(MyApp.localStorage.get("displayName").toString()),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Akun Saya",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context, AccountScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Notifikasi",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.pushNamed(context, NotifikasiScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Data Diri",
            icon: "assets/icons/Settings.svg",
            press: () async {
              APIService api = new APIService();
              SingleResponseModel srm = await api.cekNik(MyApp.localStorage.getString("nik").toString());
              DataDiriModel ddm = await api.getWarga(srm.id);
                 Navigator.pushNamed(
                    context,
                    EditScreen.routeName,
                    arguments: EditScreenArguments(
                        idWarga: srm.id,
                      data : ddm
                    )
                );

            },
          ),
          // ProfileMenu(
          //   text: "Help Center",
          //   icon: "assets/icons/Question mark.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              MyApp.localStorage.setString("id", "");
              MyApp.localStorage.setString("nik", "");
              MyApp.localStorage.setString("pass", "");
              MyApp.localStorage.setString("photo", "");
              MyApp.localStorage.setString("privilegeId", "");
              MyApp.localStorage.setString("multi_privs", "");
              MyApp.localStorage.setString("priv_id", "");

              setState(){};

             // MyApp.reloadSF();
              print("you are logged out. nik = " + MyApp.localStorage.get("nik").toString());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context){
                      return PreloginScreen();
                    }
                ),
                    (route) => false,
              );
            },
          ),
          ProfileMenu(
            text: "Hapus Akun",
            icon: "assets/icons/Error.svg",
            press: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Penghapusan Akun'),
                  content: Text('Anda yakin ingin menghapus akun ?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Tidak',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () => hapusAkun(),
                      child: Text(
                        'Yakin',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  hapusAkun() async{
    APIService api = new APIService();
    int res = await api.deleteAccount();
    if(res ==1) {
      MyApp.localStorage.setString("id", "");
      MyApp.localStorage.setString("nik", "");
      MyApp.localStorage.setString("pass", "");
      MyApp.localStorage.setString("photo", "");
      MyApp.localStorage.setString("privilegeId", "");
      MyApp.localStorage.setString("multi_privs", "");
      MyApp.localStorage.setString("telp", "");

      setState(() {

      });
      print("you are logged out. nik = " + MyApp.localStorage.get("nik").toString());
      final snackBar = SnackBar(
          content: Text("penghapusan akun ${MyApp.localStorage.getString("nik")} Berhasil ")
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) {
              return PreloginScreen();
            }
        ),
            (route) => false,
      );
    }else{
      final snackBar = SnackBar(
          content: Text("Penghapusan akun ${MyApp.localStorage.getString("nik")} Gagal. Harap coba lagi.")
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _pickImageDialog(BuildContext context) async{
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Ambil Dari : '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    ElevatedButton(
                      child: const Text('Gallery'),
                      onPressed: (){
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                    ),
                    Spacer(),
                    ElevatedButton(
                      child: const Text('Camera'),
                      onPressed: () async{
                        print(await Permission.camera.status);
                        if(await Permission.camera.status.isDenied){
                          MyApp.useCamera(
                              context,
                              "Akses Kamera",
                              "Aplikasi ini membutuhkan akses kamera untuk mengambil gambar aktual",
                                  () {
                                Navigator.pop(context);
                              },
                                  () {
                                Navigator.pop(context);
                                getImage(ImageSource.camera);
                              }
                          );
                        }else{
                          Navigator.pop(context);
                          getImage(ImageSource.camera);
                        }
                      },
                    ),
                    Spacer(),
                  ],
                )


              ],
            ),
          ),
        );
      },
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
        //if(croppedImage != null) {
        String? picPath = croppedImage?.path;
        APIService api = new APIService();
        ProfilPostResponseModel prm = await api.updateProfil(
            ProfilPostModel(
                id: MyApp.localStorage.getString("id").toString(),
                display_name: "",
                photo: picPath.toString(),
                email: "",
                icon: "",
                spesimen_tte: "",
                sharing: ""
            )
        );
        print("my pic is " + picPath.toString());
        if (prm.apiStatus == 1) {
          String? updatedPhoto = prm.data?.photo.toString();
          MyApp.localStorage.setString("photo", endPointUrl + "/" + updatedPhoto!);
          final snackBar = SnackBar(
              content: Text(
                  "Update ${MyApp.localStorage.getString("nik")} Berhasil ")
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      }
    } catch (e) {
      print("take camera " + e.toString());

    }
    setState(() {

    });
  }
}
