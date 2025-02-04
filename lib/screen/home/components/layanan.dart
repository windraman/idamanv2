import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/flat_card.dart';
import '../../../models/Layanan.dart';
import '../../../size_config.dart';
import '../../Messages/messages_screen.dart';
import '../../kurir/tracker/webviewfs.dart';
import 'section_title.dart';

class Layanan extends StatelessWidget {
  const Layanan({
    Key? key, required this.layanan
  }) : super(key: key);

  final List<Data> layanan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Layanan Kelurahan",
            press: () {}, section_title: '',
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(layanan.length, (index) =>
                  FlatCard(
                    category: layanan[index].namaSurat.toString(),
                    press: (){
                        translateCmd(context,layanan[index].aksi.toString());
                      },
                    width: 150,
                    height: 100,
                  )
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }

  translateCmd(BuildContext context,String cmd){
    print(cmd);
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
}


