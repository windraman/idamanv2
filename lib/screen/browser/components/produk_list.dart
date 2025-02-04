import 'package:flutter/material.dart';
import 'package:idaman/components/product_card.dart';
import 'package:idaman/models/Product.dart';


import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../size_config.dart';

// List<Product> produks = [];
List<Widget> produkWidget = [];

class ProdukList extends StatefulWidget {
  final List<Product> produks;
  final String searchString;
  final Function(String,bool) cari;

  const ProdukList({
    Key? key,
    required this.produks,
    required this.searchString,
    required this.cari
  }) : super(key: key);



  // static cari(String query) async {
  //   produks = [];
  //   APIService apiService = new APIService();
  //   await apiService.findProduk(query).then((value) {
  //     produks = value;
  //   });
  //  // buildProduk();
  // }

   static buildProduk(List<Product> prod) async {
     //produkWidget = prod.map((item) => ProductCard(product: item)).toList();
     return GridView.builder(
         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
             maxCrossAxisExtent: 200,
             childAspectRatio: 3 / 2,
             crossAxisSpacing: 20,
             mainAxisSpacing: 20),
         itemCount: prod.length,
         itemBuilder: (BuildContext ctx, index) {
           return  ProductCard(
               product: prod[index],
             width: getProportionateScreenWidth(100),
             aspectRetio: 1.02,
           );
         });
  }

  @override
  State<ProdukList> createState() => _ProdukListState();
}

class _ProdukListState extends State<ProdukList> {

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SmartRefresher(
          enablePullUp: true,
          controller: refreshController,
          onRefresh: () async {
            final result = widget.cari(widget.searchString,true);
            if(result){
              refreshController.refreshCompleted();
            }else{
              refreshController.refreshFailed();
            }
          },
          onLoading: () async{
            final result = await widget.cari(widget.searchString,false);
            if(result){
              refreshController.refreshCompleted();
            }else{
              refreshController.refreshFailed();
            }
          },
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1/1.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
              ),
              itemCount: widget.produks.length,
              itemBuilder: (BuildContext ctx, index) {
                return  ProductCard(
                    product: widget.produks[index],
                  width: getProportionateScreenWidth(100),
                  aspectRetio: 1.02,
                );
              }),
        ),
      ),
    );
  }
}
