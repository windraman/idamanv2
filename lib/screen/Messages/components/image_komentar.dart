import 'package:flutter/material.dart';
import 'package:idaman/models/komentar_data.dart';
import 'package:idaman/screen/photo/photo_view.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

class ImageKomentar extends StatefulWidget {
  const ImageKomentar({Key? key, required this.komentar}) : super(key: key);

  final KomentarDataModel komentar;

  @override
  State<ImageKomentar> createState() => _ImageKomentarState();
}

class _ImageKomentarState extends State<ImageKomentar> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.55,
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2.5
        ),
        decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor.withOpacity(widget.komentar.isSender == "1" ? 1 : 0.2)
        ),
        child: Column(
          crossAxisAlignment: widget.komentar.isSender == "1" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              widget.komentar.nama,
              style: TextStyle(
                color: widget.komentar.isSender == "1"
                    ? Colors.grey
                    : Colors.greenAccent,
                fontSize: 10,

              ),
            ),
            GestureDetector(
              onTap:() {
                Navigator.pushNamed(
                  context,
                  PhotoViewScreen.routeName,
                  arguments: PhotoViewArguments(
                    photo: widget.komentar.gambar,
                  ),
                );
              },
              child: Container(
                child:Image.network(
                    widget.komentar.gambar,
                  fit: BoxFit.fill,
                )
                ,
              ),
            ),
            Text(
              widget.komentar.isi,
              style: TextStyle(
                color: widget.komentar.isSender == "1"
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        )
    );
  }
}