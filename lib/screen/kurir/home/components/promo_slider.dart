

import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/slide_model.dart';

class PromoSlider extends StatefulWidget {
  const PromoSlider({Key? key}) : super(key: key);

  static bool isApiCallProcess = false;
  @override
  _PromoSliderState createState() => _PromoSliderState();
}

List<SlideData> slides = [];
List<Widget> imageSliders = [];


class _PromoSliderState extends State<PromoSlider> {

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
    await apiService.getSlider("19").then((value) {
      slides = value;
    });
    buildSliders(context);
  }

  buildSliders(BuildContext context){
    imageSliders = slides
        .map((item) => Container(
      child: GestureDetector(
        onTap: (){

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
                    height: 300,
                  ),

                ],
              )),
        ),
      ),
    )).toList();
    setState(() {});
  }
}


