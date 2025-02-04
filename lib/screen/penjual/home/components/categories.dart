import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/KategoriImageCard.dart';
import 'package:idaman/models/DataDiri.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/SingleResponseModel.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/penjual/bantuan/bantuan_screen.dart';
import 'package:idaman/screen/penjual/pelatihan/pelatihan_screen.dart';
import 'package:idaman/screen/penjual/home/components/aspirasi_form.dart';
import 'package:idaman/screen/penjual/usaha/usaha_screen.dart';
import 'package:idaman/screen/profile/edit_screen.dart';

import '../../../../main.dart';
import '../../tracker/webviewfs.dart';
import '../home_screen.dart';


// List<Widget> listKategori = [];
String selWargaId = "";

class Categories extends StatelessWidget {
  Categories({Key? key, required this.kategori_produk}) : super(
      key: key,
  );

  final List<KategoriModel> kategori_produk;

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

  @override
  Widget build(BuildContext context) {

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

    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/tambah_usaha.png", "text": "Daftar Usaha","route":"addusaha"},
      {"icon": "assets/images/info_pelatihan.png", "text": "Info Pelatihan","route":"pelatihan"},
      {"icon": "assets/images/info_permodalan.png", "text": "Bantuan dan Permodalan","route":"bantuan"},
      {"icon": "assets/images/jaring_aspirasi.png", "text": "Jaring Aspirasi","route":"aspirasi"},
      {"icon": "assets/images/link_oss.png", "text": "Ijin Usaha","route":"oss"},
    ];

    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 5,
        childAspectRatio: 1/1.5,
        children: [
          ...List.generate(
              categories.length,
                  (index) => KategoriImageCard(
                      imageSrc: categories[index]["icon"],
                      text: categories[index]["text"],
                      press: () async {
                        // LocationService lc = new LocationService();
                        // LocationModel lm = await lc.getCurrentPosition();
                        if(categories[index]['route']=='addusaha') {
                          APIService api = new APIService();
                          SingleResponseModel srm = await api.cekNik(
                              MyApp.localStorage.getString("nik").toString());
                          if (srm.value == "1") {
                            Navigator.pushNamed(
                                context,
                                UsahaScreen.routeName,
                                arguments: UsahaScreenArguments(
                                    namaUsaha: "DAFTAR BARU",
                                    idUsaha: 0,
                                    usaha: newumkm
                                )
                            ).then((value) => Navigator.pushReplacementNamed(context, PenjualHomeScreen.routeName));
                          } else {
                            selWargaId = srm.id;
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  _buildLengkapiDialog(context),
                            );
                          }
                        }
                        if(categories[index]["route"]=="oss")
                          Navigator.pushNamed(
                            context,
                            WebViewerFS.routeName,
                            arguments: WebViewFSArguments(
                                "https://oss.go.id",
                                "OSS"
                            ),
                          );
                        if(categories[index]["route"]=="pelatihan")
                          Navigator.pushNamed(
                            context,
                            PelatihanScreen.routeName,
                          );
                        if(categories[index]["route"]=="bantuan")
                          Navigator.pushNamed(
                            context,
                            BantuanScreen.routeName,
                          );
                        if(categories[index]["route"]=="aspirasi")

                          Navigator.pushNamed(
                            context,
                            AspirasiScreen.routeName,
                          );
                      }
                      )
          )
        ]
    );

  }
}
