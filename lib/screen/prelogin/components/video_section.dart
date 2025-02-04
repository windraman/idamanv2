
import 'package:flutter/material.dart';
import 'package:idaman/constants.dart';
import 'package:idaman/screen/home/components/section_title.dart';
import 'package:video_player/video_player.dart';

import '../../../size_config.dart';

class VideoSection extends StatefulWidget {
  const VideoSection({Key? key, required this.videoUrl}) : super(key: key);

  final String videoUrl;

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  late VideoPlayerController _controller;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SectionTitle(title: "Halo Sobat Tabe", press: () async {
          // await LaunchApp.openApp(
          //   androidPackageName: 'com.google.android.youtube.player',
          //   iosUrlScheme: 'youtube://',
          //   appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
          //   // openStore: false
          // );
        }, section_title: '',),
      ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      _isVisible = !_isVisible;
                    });
                  },
                    child: VideoPlayer(_controller)
                ),
                Visibility(
                  visible: _isVisible,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 50),
                    reverseDuration: const Duration(milliseconds: 200),
                    child: _controller.value.isPlaying
                        ? SizedBox.shrink()
                        : Container(
                      color: Colors.black26,
                      child:  Center(
                        child: GestureDetector(
                          onTap: (){
                            _controller.value.isPlaying ? _controller.pause() : _controller.play();
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 100.0,
                            semanticLabel: 'Play',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),


          )
              : Container(),
        ),
      ],
    );
  }
}
