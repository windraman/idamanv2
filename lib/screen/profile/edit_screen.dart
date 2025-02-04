import 'package:flutter/material.dart';
import 'package:idaman/models/DataDiri.dart';
import 'package:idaman/screen/profile/components/edit_data_form.dart';


class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  static String routeName = "/datadiri";

  @override
  Widget build(BuildContext context) {
    final EditScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as EditScreenArguments;

    print(args.idWarga);

    return EditDataDiri(idWarga: args.idWarga,data: args.data);
  }
}


class EditScreenArguments {
  final String idWarga;
  final DataDiriModel data;
  EditScreenArguments({required this.idWarga,required this.data});
}
