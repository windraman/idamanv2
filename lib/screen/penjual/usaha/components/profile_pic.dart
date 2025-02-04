import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String photo;
  const ProfilePic({
    Key? key,
    required this.photo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Image.network(photo),
        ],
      ),
    );
  }
}
