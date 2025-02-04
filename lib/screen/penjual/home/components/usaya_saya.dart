
import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/special_offer_card.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/DataDiri.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/penjual/usaha/usaha_screen.dart';
import 'package:idaman/screen/profile/edit_screen.dart';

import '../../../../main.dart';
import '../../../../size_config.dart';
import '../home_screen.dart';
import 'section_title.dart';

String selWargaId = "";

Umkm newumkm = new Umkm(
    id: 0,
    warga_bjb_id: "0",
    nama_usaha: "",
    bidang_usaha: "",
    sub_bidang_usaha: "",
    jenis_produk: "",
    brand: "",
    alamat_usaha: "",
    province_id: "",
    regency_id: "",
    district_id: "",
    village_id: "",
    lat: "",
    lon: "",
    photo: "",
    peta_icon: "",
    provinsi: "",
    kabupaten: "",
    kecamatan: "",
    kelurahan: "",
    jarak_km: 0,
    verified: "",
    numOfProduk: 0,
    nik: MyApp.localStorage.getString("nik").toString(),
    lokasi_id: "",
    keterangan: "",
    perizinan: "",
    aset_tetap: 0,
    omset: 0,
    update_omset: "",
    j_kary_l: 0,
    j_kary_p: 0
);


class UsahaSaya extends StatelessWidget {
  const UsahaSaya({
    Key? key, required this.usaha
  }) : super(key: key);

  final List<Umkm> usaha;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Usaha Saya",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // AddUsahaCard(title: "Daftar", deskripsi: "usaha baru", press: () async{
              //   //Umkm usaha= new Umkm;
              //   APIService api = new APIService();
              //   SingleResponseModel srm = await api.cekNik(MyApp.localStorage.getString("nik").toString());
              //   if(srm.value=="1") {
              //     Navigator.pushNamed(
              //         context,
              //         UsahaScreen.routeName,
              //         arguments: UsahaScreenArguments(
              //             namaUsaha: "DAFTAR BARU",
              //             idUsaha: 0,
              //             usaha: newumkm
              //         )
              //     );
              //   }else{
              //     selWargaId = srm.id;
              //     showDialog(
              //       context: context,
              //       builder: (context) => _buildLengkapiDialog(context),
              //     );
              //   }
              // }),
              ...List.generate(usaha.length, (index) =>
                  SpecialOfferCard(
                      image: usaha[index].photo,
                      category: usaha[index].nama_usaha,
                      numOfBrands: usaha[index].numOfProduk,
                      press: () async {
                        LocationService lc = new LocationService();
                        LocationModel lm = await lc.getCurrentPosition();
                        Navigator.pushNamed(
                          context,
                          UsahaScreen.routeName,
                          arguments: UsahaScreenArguments(
                              namaUsaha: usaha[index].nama_usaha,
                              idUsaha: usaha[index].id,
                              usaha: usaha[index]
                          ),
                        ).then((value) => Navigator.pushReplacementNamed(context, PenjualHomeScreen.routeName));
                      },
                    width: 120,
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

  AlertDialog _buildLengkapiDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Lengkapi Data !'),
      content: const Text('Data diri anda belum lengkap, lengkapi sekarang ?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Nanti'),
        ),
        TextButton(
          onPressed: () async{
            APIService api = new APIService();
            DataDiriModel ddm = await api.getWarga(selWargaId);
            Navigator.of(context).pop(true);
            Navigator.pushNamed(
                context,
                EditScreen.routeName,
              arguments: EditScreenArguments(idWarga: selWargaId, data:ddm)
            );
          },
          child: Text('Ya'),
        ),
      ],
    );
  }
}


