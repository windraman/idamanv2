import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Homecare.dart';
import '../../Chat/chat_screen.dart';
import '../../Messages/messages_screen.dart';
import '../../kurir/tracker/webviewfs.dart';

class HomecareCard extends StatelessWidget {
  const HomecareCard( {
    Key? key, required this.itemIndex, required this.data
  }) : super(key: key);

  final int itemIndex;
  final Data data;
  //final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 10,
      ),
      // color: Colors.brown,
      height: 160,
      child: InkWell(
        onTap: () {
          Navigator.popAndPushNamed(
            context,
            "/chat",
            arguments: ChatArguments(
                data.id.toString()
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.purpleAccent,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                  )
              ),
            ),
            if(data.photos!.length>0)
              Positioned(
                  top:0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 130,
                    width: 120,
                    child: Image.network(
                      "https://siapkk.banjarbarukota.go.id/" + data.photos![0].file.toString(),
                    ),
                  )
              ),
            Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 136,
                  width: size.width - 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text(
                          "Tanggal : " + data.createdAt.toString(),
                          style: TextStyle(
                              fontSize: 10
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text(
                          "NIK : " + data.nik.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text(
                          "Nama : " + data.nama.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text(
                          "Alamat : " + data.alamat.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 1.5,
                            vertical: kDefaultPadding/4
                        ),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                topRight: Radius.circular(22)
                            )
                        ),
                        child: Text(
                          data.createdBy.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  translateCmd(BuildContext context,String cmd){
    List<String> koman = cmd.split(";");

    print(koman[0] + "-" + koman[1]);
    if(koman[0]=="openUrl"){
      Navigator.pushNamed(
        context,
        "/webfs",
        arguments: WebViewFSArguments(
            koman[1],""
        ),
      );
    }else if(koman[0]=="goToScreen"){
      Navigator.pushNamed(
          context,
          "/" + koman[1]
      );
    }else if(koman[0]=="openGrup"){
      Navigator.pushNamed(
        context,
        "/messages",
        arguments: MessagesArguments(
            koman[1],"Coba","grup"
        ),
      );
    }
  }

}