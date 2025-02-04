

import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';

import '../../../models/homecare_media.dart';
import '../../photo/photo_view.dart';

class PictureSlider extends StatefulWidget {
  const PictureSlider({Key? key}) : super(key: key);

  static bool isApiCallProcess = false;
  @override
  _PictureSliderState createState() => _PictureSliderState();
}

List<Data> slides = [];
List<Widget> imageSliders = [];


class _PictureSliderState extends State<PictureSlider> {

  void initState(){
    loadSlider(context);
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
                photo : item.file.toString()
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
                    item.file.toString(),
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 300,
                  ),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              child: Text(
                                  item.nik.toString(),
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              child: Text(
                                item.nama.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              child: Text(
                                item.alamat.toString(),
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                ],
              )),
        ),
      ),
    )).toList();
    setState(() {});
  }
}


