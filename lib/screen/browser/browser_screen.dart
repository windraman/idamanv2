import 'package:flutter/material.dart';

import 'components/body.dart';

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  static String routeName = "/browser";
  @override
  Widget build(BuildContext context) {
    final BrowserScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as BrowserScreenArguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(searchString: args.searchParams, keyword: args.keyword),
    );
  }
}

class BrowserScreenArguments {
  final String searchParams;
  final String keyword;
  BrowserScreenArguments({required this.searchParams,required this.keyword});
}
