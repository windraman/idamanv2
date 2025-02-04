import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../api/api_service.dart';
import '../../../main.dart';
import '../../../models/Notifikasi.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  RefreshController _refreshController = new RefreshController();
  NotifikasiModel? notifikasiModel;
  int numNotif = 0;
  int offset = 0;
  int limit = 20;
  int increment = 20;
  List<Data> listData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadNotifikasi(offset,limit);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTIFIKASI"),
        backgroundColor: Colors.red,
      ),
      body: buildStack()
    );
  }

  buildStack() {
    return Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
            child: Column(
              children: [
                SizedBox(height: 50),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SmartRefresher(
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: () async {
                        loadNotifikasi(0, limit);
                        offset = 0;
                        if(notifikasiModel?.apiStatus==1){
                          _refreshController.refreshCompleted();
                        }else{
                          _refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async{
                        offset += increment;
                        addNotifikasi(offset, limit);
                        if(notifikasiModel?.apiStatus==1){
                          _refreshController.loadComplete();
                        }else{
                          _refreshController.loadFailed();
                        }
                      },
                      child: ListView.separated(
                        // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        //     maxCrossAxisExtent: 200,
                        //     childAspectRatio: 1/1.5,
                        //     crossAxisSpacing: 20,
                        //     mainAxisSpacing: 20
                        // ),
                        itemCount: numNotif,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: (){

                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(listData[index].gambar.toString().isNotEmpty && listData[index].gambar.toString()!="null")
                                  Image.network(listData[index].gambar.toString()),
                                Text(
                                    listData[index].createdAt.toString(),
                                  style: TextStyle(
                                    fontSize: 10
                                  ),
                                ),
                                Text(listData[index].content.toString()),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }

  void loadNotifikasi(int offset,int limit) async{
    APIService api = new APIService();
    NotifikasiModel nm = await api.getNotif(MyApp.localStorage.getString("nik").toString(), 'terima', offset, limit);
    notifikasiModel = nm;
    numNotif = (nm.data?.length == null ? 0 : nm.data?.length)!;
    listData = nm.data!;
    setState(() {

    });
  }

  void addNotifikasi(int offset,int limit) async{
    APIService api = new APIService();
    NotifikasiModel nm = await api.getNotif(MyApp.localStorage.getString("nik").toString(), 'terima', offset, limit);
    notifikasiModel = nm;
    numNotif += (nm.data?.length == null ? 0 : nm.data?.length)!;
    listData.addAll(nm.data!);
    setState(() {

    });
  }
}
