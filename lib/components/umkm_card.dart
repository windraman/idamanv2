

import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/penjual/usaha/usaha_screen.dart';

import '../constants.dart';
import '../size_config.dart';

import 'package:intl/intl.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class UmkmCard extends StatelessWidget {
  const UmkmCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.umkm,
  }) : super(key: key);

  final double width, aspectRetio;
  final Umkm umkm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            UsahaScreen.routeName,
            arguments: UsahaScreenArguments( usaha: umkm, namaUsaha: umkm.nama_usaha, idUsaha: umkm.id),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.03,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    //borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: umkm.id.toString(),
                    child: Image.network(
                        umkm.photo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                umkm.nama_usaha,
                maxLines: 1,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      umkm.bidang_usaha.length > 15 ?umkm.bidang_usaha.substring(0, 15)+'...' : umkm.bidang_usaha,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(11),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              if(umkm.brand!="null")
              // Row(
              //   children: [
              //     Icon(
              //       Icons.store_mall_directory,
              //       size: 15,
              //     ),
              //     Text(
              //         umkm.brand,
              //       style: TextStyle(
              //           fontSize: 12
              //       ),
              //     ),
              //   ],
              // ),
              if(umkm.jarak_km!=0)
              Row(
                children: [
                  Icon(
                      Icons.location_on,
                    size: getProportionateScreenWidth(10),
                  ),
                  Text(
                    "${umkm.jarak_km}km",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10)
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> setFavourite(String namaTable, String keyId, String reaksi) async {
    APIService api = new APIService();
    PostResponseModel prm = await api.sukai(namaTable, reaksi, keyId);
    if(prm.api_status==1){
      print(prm.api_message);
      //umkm.isFavourite = prm.id;
    }else{
      print(prm.api_message);
    }
  }
}
