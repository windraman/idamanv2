

import 'package:flutter/material.dart';
import 'package:idaman/models/slide_model.dart';
import 'package:idaman/screen/photo/photo_view.dart';

import '../../../size_config.dart';

class NewsSlider extends StatefulWidget {
  final List<SlideData> slides;
  NewsSlider({Key? key, required this.slides}) : super(key: key);

  static bool isApiCallProcess = false;
  @override
  _PromoSliderState createState() => _PromoSliderState();
}



class _PromoSliderState extends State<NewsSlider> {

  void initState(){

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _current = 0;
    return Column(
      children: [
        // CarouselSlider(
        //   items: buildSliders(context),
        //   options: CarouselOptions(
        //       autoPlay: true,
        //       enlargeCenterPage: false,
        //       viewportFraction: 0.8,
        //       enlargeStrategy: CenterPageEnlargeStrategy.scale,
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


  buildSliders(BuildContext context){
    return widget.slides
        .map((item) => Container(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(
            context,
            PhotoViewScreen.routeName,
            arguments: PhotoViewArguments(
                photo: item.photo,
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
                    fit: BoxFit.scaleDown,
                    width: getProportionateScreenWidth(900),
                    height: getProportionateScreenWidth(300),
                  ),

                ],
              )),
        ),
      ),
    )).toList();
  }
}


