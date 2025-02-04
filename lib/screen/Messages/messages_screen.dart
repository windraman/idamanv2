import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);
  static const routeName = '/messages';

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as MessagesArguments;

    return Scaffold(
        appBar: buildAppBar(args.namaTopik,args.namaTable),
        body: Body(keyId: args.keyId, namaTable: args.namaTable, namaTopik: args.namaTopik)
    );
  }

  AppBar buildAppBar(String namaTopik, String namaTable) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          BackButton(),
          // CircleAvatar(
          //
          // ),
          SizedBox(width: kDefaultPadding * 0.75),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaTopik,
                  style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis
                ),
                Text(
                  namaTable,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          )
        ],
      ),
      // actions: [
      //   IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.local_phone)
      //   ),
      //   IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.videocam)
      //   ),
      //   SizedBox(width: kDefaultPadding / 2,)
      // ],
    );
  }
}

class MessagesArguments {
  final String keyId, namaTopik, namaTable;

  MessagesArguments(this.keyId, this.namaTopik, this.namaTable);
}
