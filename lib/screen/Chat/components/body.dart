

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/chat_data.dart';
import 'package:idaman/screen/Messages/messages_screen.dart';

import '../../../main.dart';
import 'chat_card.dart';

List<ChatDataModel> chats = [];
List<Widget> chatWidget = [];
bool _isLoaded = false;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void initState() {
    loadChat(context);
    // print(chats.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
        //   color: kPrimaryColor,
        //   child: Row(
        //     children: [
        //       FillOutlineButton(press: () {},text: "Recent Messages"),
        //       SizedBox(width: kDefaultPadding),
        //       FillOutlineButton(press: () {},text: "Active",isFilled: false),
        //     ],
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context,index) => ChatCard(
                chat: chats[index],
                press: () {
                  Navigator.pushNamed(
                      context,
                      "/messages",
                      arguments: MessagesArguments(chats[index].key_id,chats[index].detail["nama"],chats[index].nama_table),
                  );
                },
              )
          ),
        )
      ],
    );
  }

  loadChat(BuildContext context) async{
    //print(MyApp.localStorage.get("id").toString() + "tambuk");
    //if(_isLoaded==false) {
      APIService apiService = new APIService();
      chats = await apiService.getListChat(
            MyApp.localStorage.get("id").toString()
           );

      _isLoaded = true;
      setState(() {

      });
   // }
    //print(chats[0].detail["gambar_utama"]);
    //print(_isLoaded.toString());
  }
}


