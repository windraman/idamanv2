import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class PhotoViewScreen extends StatelessWidget {
  static String routeName = "/PhotoViewScreen";

  @override
  Widget build(BuildContext context) {
    final PhotoViewArguments args =
    ModalRoute.of(context)!.settings.arguments as PhotoViewArguments;
    return Container(
        child: PhotoView(
          imageProvider:NetworkImage(args.photo),
        )
    );
  }
}

class PhotoViewArguments {
  final String photo;
  PhotoViewArguments({required this.photo});
}
