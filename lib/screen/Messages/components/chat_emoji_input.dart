// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
//
// import '../../../constants.dart';
//
// class ChatEmojiField extends StatelessWidget {
//   const ChatEmojiField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _controller = TextEditingController();
//     bool emojiShowing = false;
//
//     _onEmojiSelected(Emoji emoji) {
//       _controller
//         ..text += emoji.emoji
//         ..selection = TextSelection.fromPosition(
//             TextPosition(offset: _controller.text.length));
//     }
//
//     _onBackspacePressed() {
//       _controller
//         ..text = _controller.text.characters.skipLast(1).toString()
//         ..selection = TextSelection.fromPosition(
//             TextPosition(offset: _controller.text.length));
//     }
//
//     return Column(
//       children: [
//         Container(
//             height: 55.0,
//             color: kPrimaryLightColor,
//             child: Row(
//               children: [
//                 Material(
//                   color: Colors.transparent,
//                   child: IconButton(
//                     onPressed: () {
//                         emojiShowing = !emojiShowing;
//                     },
//                     icon: const Icon(
//                       Icons.emoji_emotions,
//                       color: kPrimaryColor,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: TextFormField(
//                         controller: _controller,
//                         style: const TextStyle(
//                             fontSize: 20.0, color: Colors.black87),
//                         decoration: InputDecoration(
//                           hintText: 'Ketik komentar',
//                           filled: true,
//                           fillColor: Colors.white,
//                           contentPadding: const EdgeInsets.only(
//                               left: 16.0,
//                               bottom: 8.0,
//                               top: 8.0,
//                               right: 16.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(50.0),
//                           ),
//                         )),
//                   ),
//                 ),
//                 Material(
//                   color: Colors.transparent,
//                   child: IconButton(
//                       onPressed: () {
//                         // send message
//                       },
//                       icon: const Icon(
//                         Icons.send,
//                         color: kPrimaryDarkColor,
//                       )),
//                 )
//               ],
//             )
//         ),
//         Offstage(
//           offstage: !emojiShowing,
//           child: SizedBox(
//             height: 250,
//             child: EmojiPicker(
//                 onEmojiSelected: (Category category, Emoji emoji) {
//                   _onEmojiSelected(emoji);
//                 },
//                 onBackspacePressed: _onBackspacePressed,
//                 config: Config(
//                     columns: 7,
//                     // Issue: https://github.com/flutter/flutter/issues/28894
//                     emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
//                     verticalSpacing: 0,
//                     horizontalSpacing: 0,
//                     initCategory: Category.RECENT,
//                     bgColor: const Color(0xFFF2F2F2),
//                     indicatorColor: Colors.blue,
//                     iconColor: Colors.grey,
//                     iconColorSelected: Colors.blue,
//                     progressIndicatorColor: Colors.blue,
//                     backspaceColor: Colors.blue,
//                     skinToneDialogBgColor: Colors.white,
//                     skinToneIndicatorColor: Colors.grey,
//                     enableSkinTones: true,
//                     showRecentsTab: true,
//                     recentsLimit: 28,
//                     // noRecentsText: 'No Recents',
//                     // noRecentsStyle: const TextStyle(
//                     //     fontSize: 20, color: Colors.black26),
//                     tabIndicatorAnimDuration: kTabScrollDuration,
//                     categoryIcons: const CategoryIcons(),
//                     buttonMode: ButtonMode.MATERIAL)),
//           ),
//         ),
//       ],
//     );
//   }
// }
