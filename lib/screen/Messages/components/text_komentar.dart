import 'package:flutter/material.dart';
import 'package:idaman/models/komentar_data.dart';

import '../../../constants.dart';

class TextKomentar extends StatelessWidget {
  const TextKomentar({
    Key? key,
    required this.komentar,
  }) : super(key: key);

  final KomentarDataModel komentar;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
              vertical: kDefaultPadding /2
          ),
          decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(komentar.isSender == "1" ? 1 : 0.15),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: komentar.isSender == "1" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                komentar.nama,
                style: TextStyle(
                  color: komentar.isSender == "1"
                      ? Colors.grey
                      : Colors.greenAccent,
                  fontSize: 10,

                ),
              ),
              Text(
                komentar.isi,
                style: TextStyle(
                  color: komentar.isSender == "1"
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(height: kDefaultPadding /2),
              Text(
                komentar.created_at,
                style: TextStyle(
                  color: komentar.isSender == "1"
                      ? Colors.grey
                      : Colors.grey,
                  fontSize: 8,
                ),
              ),
            ],
          )
      ),
    );
  }
}