import 'package:flutter/material.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/helper/map_utils.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/penjual/usaha/components/profile_pic.dart';

import '../../../../size_config.dart';

LocationModel lm = new LocationModel(latitude: "", longitude: "", isMock: true);

class ViewUsaha extends StatelessWidget {
  const ViewUsaha({
    Key? key,
    required this.usaha
  }) : super(key: key);

  final Umkm usaha;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
            children: [
              ProfilePic(photo: usaha.photo),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                        'Nama usaha',
                        textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    Text(
                      usaha.nama_usaha,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Bidang usaha',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    Text(
                      usaha.bidang_usaha,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Alamat usaha',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    Text(
                      usaha.alamat_usaha,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Kelurahan',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    Text(
                      usaha.kelurahan,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Kecamatan',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    Text(
                      usaha.kecamatan,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Kabupaten/Kota',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    Text(
                      usaha.kabupaten,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Provinsi',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13)
                      ),
                    ),
                    Text(
                      usaha.provinsi,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              DefaultButton(
                  text: "Dapatkan penunjuk arah",
                  press: (){
                    MapUtils.openMap(double.parse(usaha.lat),double.parse(usaha.lon));
                  },
                  warna: Colors.orange
              ),
            ]
        ),
      ),
    );
  }
}
