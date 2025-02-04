import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/ResponseModel.dart';

import 'components/body.dart';

class ProdukScreen extends StatelessWidget {
  const ProdukScreen({Key? key}) : super(key: key);

  static String routeName = "/produk";

  @override
  Widget build(BuildContext context) {
    final ProdukScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as ProdukScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.judul),
        backgroundColor: Colors.red,
        actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildDeleteProdukDialog(context,args.produk);
                    });

              },
            )
        ],
      ),
      body:Body(produk: args.produk)
    );
  }

  AlertDialog _buildDeleteProdukDialog(BuildContext context, Product product) {
    return AlertDialog(
      title: const Text('Menghapus Produk !'),
      content: const Text('Anda yakin ingin menghapus produk ini ?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () async{
            APIService api = new APIService();
            ResponseModel res = await api.deleteProduk(product.id.toString());

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
}

class ProdukScreenArguments {
  final Product produk;
  final String judul;
  ProdukScreenArguments( {required this.produk, required this.judul});
}
