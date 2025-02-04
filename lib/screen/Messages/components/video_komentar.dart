import 'package:flutter/material.dart';
import 'package:idaman/models/komentar_data.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

class VideoKomentar extends StatefulWidget {
  const VideoKomentar({Key? key, required this.komentar}) : super(key: key);

  final KomentarDataModel komentar;

  @override
  State<VideoKomentar> createState() => _VideoKomentarState();
}

class _VideoKomentarState extends State<VideoKomentar> {
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
        height: 150,
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2.5
        ),
        decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor.withOpacity(widget.komentar.isSender == "1" ? 1 : 0.2)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Container(),
            ),
            Text(widget.komentar.isi),
          ],
        )
    );
  }
}