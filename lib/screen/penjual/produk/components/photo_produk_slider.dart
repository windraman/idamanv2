
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/Photos.dart';
import 'package:idaman/screen/photo/photo_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../main.dart';

typedef void NewCallback(String val);
typedef void DelCallback(String val);

class PhotoProdukSlider extends StatefulWidget {
  const PhotoProdukSlider({
    Key? key,
    required this.images,
    required this.parentId,
    required this.newPath,
    required this.delPhotoId
  }) : super(key: key);

  final List<PhotoModel> images;
  final String parentId;
  final NewCallback newPath;
  final DelCallback delPhotoId;

  static bool isApiCallProcess = false;
  @override
  _PromoSliderState createState() => _PromoSliderState();
}

//List<SlideData> slides = [];
List<Widget> imageSliders = [];


class _PromoSliderState extends State<PhotoProdukSlider> {
  XFile? imageFile;
  File? croppedImage;

  void initState(){
    buildSliders(context);
    addNewBtn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _current = 0;
    return Column(
      children: [
        // CarouselSlider(
        //   items: imageSliders,
        //   options: CarouselOptions(
        //       autoPlay: false,
        //       aspectRatio: 2.0,
        //       enlargeCenterPage: false,
        //       enlargeStrategy: CenterPageEnlargeStrategy.height,
        //       enableInfiniteScroll: false,
        //       onPageChanged: (index, reason)
        //       {
        //         setState(() {
        //           _current = index;
        //         });
        //       }
        //   ),
        // ),
      ],
    );
  }

  addNewBtn(){
    imageSliders.add(
        Container(
            child: GestureDetector(
              onTap: () {
                _pickImageDialog(context);
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/open_camera.png",
                          fit: BoxFit.cover,
                          width: 1000.0,
                          height: 300,
                        ),
                      ],
                    )),
              ),
            )
        )
    );
  }

  buildSliders(BuildContext context){
    imageSliders = widget.images
        .map((item) => Container(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(
            context,
            PhotoViewScreen.routeName,
            arguments: PhotoViewArguments(
              photo: item.file,
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                alignment: Alignment.center,
                textDirection: TextDirection.rtl,
                fit: StackFit.loose,
                clipBehavior: Clip.hardEdge,
                children: <Widget>[
                  if(item.type=="network")
                  Positioned(
                    child: Image.network(
                      item.file,
                      fit: BoxFit.cover,
                      width: 1000.0,
                      height: 300,
                    ),
                  ),
                  if(item.type=="file")
                    Positioned(
                      child: Image.file(
                        File(item.file),
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 300,
                      ),
                    ),
                  Positioned(
                    width: 50,
                    height: 50,
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                        onPressed: (){
                          deleteImage(item);
                        },
                        icon: Icon(
                            Icons.delete_forever,
                            color: Colors.yellow,
                        )
                    ),
                  ),
                ],
              )),
        ),
      ),
    )).toList();

    setState(() {});
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
            String selPhoto = (await cropped?.path)!;
            widget.images.add(PhotoModel(
                id: "0",
                parent_id: widget.parentId,
                file: selPhoto,
                parent: "produk",
                utama: "0",
                type: "file",
                created_at: DateTime.now().toString()
            ));

            setState(() {
              widget.newPath(selPhoto);
              buildSliders(context);
              addNewBtn();
            });
          }
        } catch (e) {
          print("take camera " + e.toString());
          imageFile = null;
          setState(() {});
        }
      }

  Future<void> deleteImage(PhotoModel item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Perhatian !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah anda ingin menghapus gambar ini ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                if(item.type=="network") {
                  APIService apiSevice = new APIService();
                  String deleted = apiSevice.deleteProdukImage(item.id)
                      .toString();
                  if (deleted == "1") {
                    widget.images.removeWhere((element) => element.id == item.id);
                  } else {

                  }
                  Navigator.of(context).pop();
                }else{
                  widget.images.removeWhere((element) => element.id == item.id);
                  Navigator.of(context).pop();
                }
                setState(() {

                });
              },
            ),
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


