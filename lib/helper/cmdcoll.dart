import 'package:flutter/cupertino.dart';

import '../screen/Messages/messages_screen.dart';
import '../screen/kurir/tracker/webviewfs.dart';

translateCmd(BuildContext context,String cmd){
  List<String> koman = cmd.split(";");
  if(koman[0]=="goToScreen"){
    Navigator.pushNamed(
        context,
        "/" + koman[1]
    );
  }else if(koman[0]=="openGrup"){
    Navigator.pushNamed(
      context,
      "/messages",
      arguments: MessagesArguments(
          koman[1],koman[2],koman[3]
      ),
    );
  }else if(koman[0]=="openUrl"){
    List<String> subkoman = koman[1].split(",");
    print(subkoman.length);
    if (subkoman.length>1) {
      Navigator.pushNamed(
        context,
        WebViewerFS.routeName,
        arguments: WebViewFSArguments(
            subkoman[0], subkoman[1]
        ),
      );
    }else{
      Navigator.pushNamed(
        context,
        WebViewerFS.routeName,
        arguments: WebViewFSArguments(
            koman[1], koman[1]
        ),
      );
    }
  }
}