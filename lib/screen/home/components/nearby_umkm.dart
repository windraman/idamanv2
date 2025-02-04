import 'package:flutter/material.dart';
import 'package:idaman/components/umkm_card.dart';
import 'package:idaman/constants.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/home/components/section_title.dart';
import 'package:idaman/screen/kurir/tracker/webviewfs.dart';


import '../../../size_config.dart';

class NearbyUmkm extends StatelessWidget {
  const NearbyUmkm({
    Key? key,
    required this.umkm,
  }) : super(key: key);

  final List<Umkm> umkm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Dekat Saya",
              press: () async {
            LocationService lc = new LocationService();
            LocationModel lm = await lc.getCurrentPosition();
            Navigator.pushNamed(
              context,
              WebViewerFS.routeName,
              arguments: WebViewFSArguments(
                osmUrl,
                "judul"
              ),
            );
            // Navigator.pushNamed(
            //   context,
            //   OsmScreen.routeName
            // );
          }, section_title: '',),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                umkm.length,
                (index) {
                    return UmkmCard(umkm: umkm[index]);

                  return SizedBox.shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
