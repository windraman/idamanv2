
import 'package:flutter/material.dart';
import 'package:idaman/models/Transaksi.dart';

import '../../../../components/list_card.dart';
import '../../../../size_config.dart';
import 'section_title.dart';




class TransaksiSaya extends StatelessWidget {
  const TransaksiSaya({
    Key? key, required this.usaha
  }) : super(key: key);

  final List<Data> usaha;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Transaksi Saya",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                  ListCard(
                      category: usaha[index].penjualId.toString(),
                      numOfBrands:int.parse(usaha[index].keranjangCount.toString()),
                      press: () async {
                        // LocationService lc = new LocationService();
                        // LocationModel lm = await lc.getCurrentPosition();
                        // Navigator.pushNamed(
                        //   context,
                        //   UsahaScreen.routeName,
                        //   arguments: UsahaScreenArguments(
                        //       namaUsaha: usaha[index].nama_usaha,
                        //       idUsaha: usaha[index].id,
                        //       usaha: usaha[index]
                        //   ),
                        // ).then((value) => Navigator.pushReplacementNamed(context, PenjualHomeScreen.routeName));
                      },
                    width: 1000,
                    height: 100,
                    status: usaha[index].statusTransaksi.toString(),
                  )
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );

  }

  // AlertDialog _buildLengkapiDialog(BuildContext context) {
  //   return AlertDialog(
  //     title: const Text('Lengkapi Data !'),
  //     content: const Text('Data diri anda belum lengkap, lengkapi sekarang ?'),
  //     actions: <Widget>[
  //       TextButton(
  //         onPressed: () => Navigator.of(context).pop(false),
  //         child: Text('Nanti'),
  //       ),
  //       TextButton(
  //         onPressed: () async{
  //           APIService api = new APIService();
  //           DataDiriModel ddm = await api.getWarga(selWargaId);
  //           Navigator.of(context).pop(true);
  //           Navigator.pushNamed(
  //               context,
  //               EditScreen.routeName,
  //             arguments: EditScreenArguments(idWarga: selWargaId, data:ddm)
  //           );
  //         },
  //         child: Text('Ya'),
  //       ),
  //     ],
  //   );
  // }
}


