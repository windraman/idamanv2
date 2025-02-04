import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/komentar_data.dart';

import '../../../constants.dart';
import '../../../main.dart';
import 'chat_input_field.dart';
import 'komentar.dart';


List<KomentarDataModel> komentars = [];

class Body extends StatefulWidget {
  const Body({Key? key,
    required this.keyId,
    required this.namaTopik,
    required this.namaTable
  }) : super(key: key);

  final String keyId, namaTopik, namaTable;

  @override
  State<Body> createState() => _BodyState();

}

class _BodyState extends State<Body> {

  ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadKomentar(MyApp.localStorage.get("id").toString(),widget.keyId,widget.namaTable); // use it here
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //loadKomentar(MyApp.localStorage.get("id").toString(),widget.keyId,widget.namaTable);
      _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut
      );
    });
    return Column(
      children: [
        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                  itemCount: komentars.length,
                  controller: _listScrollController,
                  itemBuilder: (context, index) => KomentarBuilder(komentar: komentars[index])
              ),
            )
        ),
        ChatInputField(keyId: widget.keyId,namaTable: widget.namaTable,loadKomentar: loadKomentar)
      ],
    );
  }

  loadKomentar(String userId, String keyId, String namaTable) async{
    APIService apiService = new APIService();
    komentars = await apiService.getKomentar(userId,keyId,namaTable);
    print(komentars.toString());
    setState(() {

    });
  }
}





