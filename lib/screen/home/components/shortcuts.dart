import 'package:flutter/material.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Shortcut.dart';
import 'package:idaman/screen/browser/browser_screen.dart';
import 'package:idaman/screen/kurir/tracker/webviewfs.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_config.dart';
import '../../Messages/messages_screen.dart';

List<Widget> listKategori = [];


class Pintasan extends StatelessWidget {
  Pintasan({Key? key, required this.shortcuts}) : super(
      key: key,
  );

  final List<ShortcutModel> shortcuts;

  @override
  Widget build(BuildContext context) {

    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        childAspectRatio: 1/1.5,
        children: [
          ...List.generate(
              shortcuts.length,
                  (index) => ShortcutCard(
                      imgSrc: shortcuts[index].icon,
                      text: shortcuts[index].deskripsi,
                      koman: shortcuts[index].aksi,
                      press: () async {
                        LocationService lc = new LocationService();
                        LocationModel lm = await lc.getCurrentPosition();
                        debugPrint(lm.longitude);
                        Navigator.pushNamed(
                          context,
                          BrowserScreen.routeName,
                          arguments: BrowserScreenArguments(
                            searchParams: "user_id=${MyApp.localStorage.get('id')}&kategori_produk_id=" + shortcuts[index].id + "&reorder=jarak&user_lat="+lm.latitude+"&user_lon="+lm.longitude,
                            keyword: shortcuts[index].deskripsi
                          ),
                        );
                      })
          )
        ]
    );

  }
}

class ShortcutCard extends StatelessWidget {
  const ShortcutCard({
    Key? key,
    required this.imgSrc,
    required this.text,
    required this.press,
    required this.koman
  }) : super(key: key);

  final String imgSrc;
  final String text;
  final String koman;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        translateCmd(context, koman);
      },
      child: SizedBox(
          width: getProportionateScreenWidth(25),
          height: getProportionateScreenHeight(60),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFECDF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                        imgSrc,
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 5),
              Text(
                  text.length > 40 ?text.substring(0, 30)+'...' : text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10
                ),
              )
            ],
          )
      ),
    );
  }

  translateCmd(BuildContext context,String cmd) async{
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
    }else if(koman[0]=="openExternalUrl") {
      List<String> subkoman = koman[1].split(",");
      print(subkoman[0]);
      if (subkoman.length==1) {
        String url = subkoman[0];
        if(await canLaunch(url)){
          await launch(url);  //forceWebView is true now
        }else {
        throw 'Could not launch $url';
        }
      }
    }
  }

}