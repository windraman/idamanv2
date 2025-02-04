import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/ResponseModel.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/penjual/usaha/browser/browser.dart';
import 'package:idaman/screen/penjual/usaha/components/edit_usaha_lanjutan_form.dart';
import 'package:idaman/screen/penjual/usaha/components/view_usaha.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../main.dart';
import 'edit_usaha_form.dart';

LocationModel lm = new LocationModel(latitude: "-3.4572", longitude: "114.8103", isMock: false);

class Body extends StatefulWidget {
  const Body({Key? key,required this.usaha, required this.selTab}) : super(key: key);
  final Umkm usaha;
  final int selTab;
  @override
  State<Body> createState() => _BodyState();
}

AlertDialog _buildLengkapiDialog(BuildContext context, Umkm usaha) {
  return AlertDialog(
    title: const Text('Menghapus Usaha !'),
    content: const Text('Anda yakin ingin menghapus usaha ?'),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text('Batal'),
      ),
      TextButton(
        onPressed: () async{
          APIService api = new APIService();
          ResponseModel res = await api.deleteUsaha(usaha.id.toString(),usaha.warga_bjb_id);

          if(res.api_status == 1) {
            Navigator.pop(context);
            Navigator.pop(context);
          }else{
            print(res);
          }
        },
        child: Text('Yakin'),
      ),
    ],
  );
}


class _BodyState extends State<Body> {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    //print(widget.usaha.nik + " apakah " + MyApp.localStorage.getString("nik").toString());
    return DefaultTabController(
        initialIndex: widget.selTab,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(widget.usaha.nama_usaha),
            actions: <Widget>[
              if(widget.usaha.nama_usaha.isNotEmpty && widget.usaha.nik == MyApp.localStorage.getString("nik".toString()))
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildLengkapiDialog(context, widget.usaha);
                      });

                },
              ),
              if(widget.usaha.nama_usaha.isNotEmpty && widget.usaha.nik == MyApp.localStorage.getString("nik".toString()))
                IconButton(
                  icon: Icon(
                    Icons.more,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context,
                        EditUsahaLanjutan.routeName,
                        arguments: UsahaLanjutanArguments(
                            usaha: widget.usaha,
                            idUsaha: widget.usaha.id,
                            namaUsaha: widget.usaha.nama_usaha
                        )
                    );
                  },
                ),
            ],
            bottom:  TabBar(
                tabs: [
                  Tab(text: "Detail"),
                  Tab(text: "Produk (" + widget.usaha.numOfProduk.toString() + ")")
                ]
            ),
          ),
          body: TabBarView(
            children: [
              if(widget.usaha.nik==MyApp.localStorage.get("nik").toString())
                EditUsaha(usaha: widget.usaha),
              if(widget.usaha.nik!=MyApp.localStorage.get("nik").toString())
                ViewUsaha(usaha: widget.usaha),
              if(widget.usaha.nama_usaha.isNotEmpty)
                Browser(searchString: "umkm_usaha_id=${widget.usaha.id}&reorder=jarak&user_lat=-3.4572&user_lon=114.8103", keyword: widget.usaha.nama_usaha, umkm_usaha_id: widget.usaha.id, owned: widget.usaha.nik==MyApp.localStorage.get("nik").toString() ? true : false),
              if(widget.usaha.nama_usaha.isEmpty)
                Center(
                  child: Text("Halaman produk belum tersedia"),
                )
            ],
          ),
        )
    );

  }


}

