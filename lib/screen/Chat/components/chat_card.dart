import 'package:flutter/material.dart';
import 'package:idaman/models/chat_data.dart';

import '../../../constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key, required this.chat, required this.press,
  }) : super(key: key);

  final ChatDataModel chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding * 0.75
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: chat.detail["gambar_utama"].toString().isNotEmpty ? NetworkImage(chat.detail["gambar_utama"].toString()) : AssetImage('assets/images/noimage.png') as ImageProvider,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3
                        )
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.detail["nama"].toString(),
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Opacity(
                        opacity:  0.64,
                        child: Text(
                            chat.nama_table,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        ),
                      )
                    ],
                  ),
                )
            ),
            Opacity(
              opacity: 0.63,
              child: Text("12:00"),
            )
          ],
        ),
      ),
    );
  }
}