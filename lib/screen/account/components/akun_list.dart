import 'package:flutter/material.dart';

import '../../../constants.dart';

class AkunList extends StatelessWidget {
  const AkunList({
    Key? key,
    required this.text,
    required this.ics,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon ics;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor, padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            ics,
          ],
        ),
      ),
    );
  }
}
