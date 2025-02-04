import 'package:flutter/material.dart';
import 'package:idaman/models/komentar_data.dart';
import 'package:idaman/screen/Messages/components/image_komentar.dart';
import 'package:idaman/screen/Messages/components/text_komentar.dart';
import 'package:idaman/screen/Messages/components/video_komentar.dart';

import '../../../constants.dart';

class KomentarBuilder extends StatelessWidget {
  const KomentarBuilder({
    Key? key, required this.komentar,
  }) : super(key: key);

  final KomentarDataModel komentar;

  @override
  Widget build(BuildContext context) {
    Widget komentarContain(KomentarDataModel komentar){
      switch(komentar.jenis_gambar){
        case "null":
          return TextKomentar(komentar: komentar);
          break;
        case "image/jpeg":
          return ImageKomentar(komentar: komentar);
          break;
        case "video/mp4":
          return VideoKomentar(komentar: komentar);
          break;
        default:
          return SizedBox();
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment: komentar.isSender == "1" ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(komentar.isSender == "0") ...[
            CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(komentar.photo)
            )
          ],
          SizedBox(width: kDefaultPadding / 2),
          komentarContain(komentar),
        ],
      ),
    );
  }
}


