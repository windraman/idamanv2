
import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/komentar_post.dart';

import '../../../constants.dart';
import '../../../main.dart';

class ChatInputField extends StatelessWidget {
  final Function loadKomentar;
  const ChatInputField({
    Key? key,
    required this.keyId,
    required this.namaTable,
    required this.loadKomentar
  }) : super(key: key);

  final String keyId, namaTable;


  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    //bool emojiShowing = false;

    String typedChat = "";

    // _onEmojiSelected(Emoji emoji) {
    //   _controller
    //     ..text += emoji.emoji
    //     ..selection = TextSelection.fromPosition(
    //         TextPosition(offset: _controller.text.length));
    // }

    _onBackspacePressed() {
      _controller
        ..text = _controller.text.characters.skipLast(1).toString()
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length));
    }

    _clearText(){
      _controller
      ..text = "";
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding/2
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,4),
                    blurRadius: 32,
                    color: Color(0xFF087949).withOpacity(0.1)
                )
              ]
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 0
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),

                      ),
                      child: Row(
                        children: [
                          // IconButton(
                          //     icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                          //     color: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1!
                          //         .color,
                          //   onPressed: (){
                          //     //emojiShowing = !emojiShowing;
                          //   },
                          // ),
                          SizedBox(width: kDefaultPadding/4),
                          Flexible(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                  hintText: "Ketik Komentar",
                                  border: InputBorder.none
                              ),
                              onChanged: (value){
                                typedChat = value;
                              },
                            ),
                          ),
                          // Icon(
                          //     Icons.attach_file,
                          //     color: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1!
                          //         .color
                          // ),
                          // SizedBox(width: kDefaultPadding/4),
                          // Icon(
                          //     Icons.send,
                          //     color: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1!
                          //         .color
                          // ),
                        ],
                      ),
                    )
                ),
                SizedBox(width: kDefaultPadding),
                IconButton(
                    icon: Icon(Icons.send),
                    color: kPrimaryDarkColor,
                  onPressed: () async{
                    sendKomentar(MyApp.localStorage.get("id").toString(),keyId,namaTable,typedChat,"");
                    _clearText();
                    await Future.delayed(Duration(seconds: 1));
                    loadKomentar(MyApp.localStorage.get("id").toString(),keyId,namaTable);
                  },
                ),
              ],
            ),
          ),
        ),
        // Offstage(
        //   offstage: !emojiShowing,
        //   child: SizedBox(
        //     height: 250,
        //     child: EmojiPicker(
        //         onEmojiSelected: (Category category, Emoji emoji) {
        //           _onEmojiSelected(emoji);
        //         },
        //         onBackspacePressed: _onBackspacePressed,
        //         config: Config(
        //             columns: 7,
        //             // Issue: https://github.com/flutter/flutter/issues/28894
        //             emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
        //             verticalSpacing: 0,
        //             horizontalSpacing: 0,
        //             initCategory: Category.RECENT,
        //             bgColor: const Color(0xFFF2F2F2),
        //             indicatorColor: Colors.blue,
        //             iconColor: Colors.grey,
        //             iconColorSelected: Colors.blue,
        //             progressIndicatorColor: Colors.blue,
        //             backspaceColor: Colors.blue,
        //             skinToneDialogBgColor: Colors.white,
        //             skinToneIndicatorColor: Colors.grey,
        //             enableSkinTones: true,
        //             showRecentsTab: true,
        //             recentsLimit: 28,
        //             // noRecentsText: 'No Recents',
        //             // noRecentsStyle: const TextStyle(
        //             //     fontSize: 20, color: Colors.black26),
        //             tabIndicatorAnimDuration: kTabScrollDuration,
        //             categoryIcons: const CategoryIcons(),
        //             buttonMode: ButtonMode.MATERIAL)),
        //   ),
        // ),
      ],
    );
  }

  sendKomentar(String userId, String keyId, String namaTable, String isi, String terlibat) async{
    APIService apiService = new APIService();
    KomentarRequestModel requestModel = new KomentarRequestModel(namaTable: namaTable, keyId: keyId, userId: userId, isi: isi, terlibat: terlibat);
     await apiService.sendKomentar(requestModel);
    // print(komentars.toString());
    // setState(() {
    //
    // });
  }
}
