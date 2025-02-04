import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   backgroundColor: kPrimaryColor,
      //   child: Icon(
      //     Icons.person_add_alt_1,
      //     color: Colors.white
      //   ),
      // ),
      //bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value){
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger),label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people),label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call),label: "Call"),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text("Oborolan"),
      elevation: 0,
      actions: [
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.search)
        )
      ],
    );
  }
}

class ChatArguments {
  final String keyId;

  ChatArguments(this.keyId);
}
