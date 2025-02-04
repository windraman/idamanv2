import "package:flutter/material.dart";

import "../../../constants.dart";
import "body.dart";
import "homecare_card.dart";


class HomecareList extends StatelessWidget {
  const HomecareList({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                  )
              ),
            ),
            if(data!=null)
            ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context,index) => HomecareCard(
                itemIndex: index,
                data: data![index],
              ),
            ),
          ],
        )
    );
  }
}


