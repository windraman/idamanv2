
import 'package:flutter/material.dart';
import 'package:idaman/screen/Homecare/components/homecare_header.dart';
import 'package:idaman/screen/Homecare/components/picture_slider.dart';
import 'package:idaman/screen/photo/photo_view.dart';

import '../../../api/api_service.dart';
import '../../../models/Homecare.dart';
import '../../../models/Shortcut.dart';
import '../../../models/slide_model.dart';
import '../../kurir/tracker/webviewfs.dart';
import 'homecare_list.dart';

List<String> imgList = [];
List<String> pelayananList = [
  "Pelayanan Kelurahan",
  "Bantuan",
  "Pelatihan",
  "Daftarkan Usaha",
];

List<SlideData> slides = [];
List<Widget> imageSliders = [];

List<ShortcutModel> shortcuts = [];
List<Widget> listShortcut = [];

List<Data>? data;

class Body extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<Body> {
  bool hidePassword = true;
  bool isApiCallProcess = false;

  void initState() {

    loadHomecare(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            HomecareHeader(numOfCart: 0, numOfNotif: 0, press1: (){}, press2: (){}),
            PictureSlider(),
            // CarouselSlider(
            //   options: CarouselOptions(
            //     autoPlay: true,
            //     aspectRatio: 2.0,
            //     enlargeCenterPage: true,
            //     enlargeStrategy: CenterPageEnlargeStrategy.height,
            //   ),
            //   items: imageSliders,
            // ),
            //SizedBox(height: kDefaultPadding/2),
            HomecareList(),
          ],
        ),
      ),
    );
  }


  loadSlider(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getHomecareMedia(1,5).then((value) {
      slides = value;
    });
    buildSliders(context);
  }

  buildSliders(BuildContext context){
    imageSliders = slides
        .map((item) => Container(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(
            context,
            PhotoViewScreen.routeName,
            arguments: PhotoViewArguments(
                photo : item.photo
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    item.photo,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 500,
                  ),

                ],
              )),
        ),
      ),
    )).toList();
    setState(() {});
  }

  loadShortcut(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getIcon("0",10).then((value) {
      shortcuts = value;
    });
    setState(() {});
  }

  buildShortcut(BuildContext context){

  }

  loadHomecare(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getAllHomecare().then((value) {
      data = value;
    });
    setState(() {});
  }

  translateCmd(BuildContext context,String cmd){
    List<String> koman = cmd.split(";");

    print(koman[0] + "-" + koman[1]);
    if(koman[0]=="openUrl"){
      Navigator.pushNamed(
        context,
        WebViewerFS.routeName,
        arguments: WebViewFSArguments(
            koman[1], koman[1]
        ),
      );
    }else if(koman[0]=="goToScreen"){
      Navigator.pushNamed(
          context,
          "/" + koman[1]
      );
    }
  }
}





