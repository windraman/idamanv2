import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/helper/stateful_wrapper.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/produk_post.dart';


import 'package:intl/intl.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class ProductDescriptionEdit extends StatelessWidget {
   ProductDescriptionEdit({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;
   List<KategoriModel> kategori_produk = [];
   KategoriModel? selKatItem;


  @override
  Widget build(BuildContext context) {
    List<String> errors = [];

    String selKategori = "";
    GlobalKey _formKey = new GlobalKey<FormState>();


    ProdukPostModel produkPostModel = ProdukPostModel(
        id: "0",
        nama_produk_jasa: "",
        harga: "0",
        mata_uang_id: "1",
        umkm_usaha_id: "0",
        lokasi_id: "0",
        deskripsi_singkat: "",
        deskripsi_produk: "",
        berat: "0",
        satuan_berat: "1",
        kategori_produk_id: "1",
        status_produk: "1",
        diskon: "0",
        etalase_id: "",
        updated_by: MyApp.localStorage.getString("id").toString()
    );

    //print(kategori_produk);
    return StatefulWrapper(
        onInit: () {
        _getThingsOnStartup().then((value) {
          print('Async done');
        });
    },
    child:Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                buildInputForm(
                    produkPostModel,
                    "Harap isi nama produk",
                    "Masukkan nama produk",
                    "Nama Produk",
                    product.title
                ),
                buildInputForm(
                    produkPostModel,
                    "Harap isi berat",
                    "Masukkan berat",
                    "Berat",
                    product.berat.toString()
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DropdownSearch<KategoriModel>(
                    items: kategori_produk,
                    //maxHeight: 300,
                    //onFind: (String? filter) => loadProvinsi(filter),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Pilih Kategori Produk",
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // dropdownSearchDecoration: InputDecoration(
                    //   labelText: "Pilih Kategori Produk",
                    //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                    //   border: OutlineInputBorder(),
                    // ),
                    onChanged: (KategoriModel? value) {
                      String? selected = value?.id;
                      print(value?.id);
                      selKategori = selected.toString();
                    },
                    selectedItem: selKatItem,
                    // showSearchBox: false,
                    dropdownBuilder: _customDropDown,
                    // popupItemBuilder: _customPopupItemBuilder,
                  ),
                ),
                buildInputForm(
                    produkPostModel,
                    "Harap isi nama produk",
                    "Masukkan nama produk",
                    "Satuan Berat",
                    product.satuan_berat
                ),
                buildInputForm(
                    produkPostModel,
                    "Harap isi nama produk",
                    "Masukkan nama produk",
                    "Deskripsi",
                    product.description
                ),
                buildInputForm(
                    produkPostModel,
                    "Harap isi nama produk",
                    "Masukkan nama produk",
                    "Nama Produk",
                    product.title
                ),
                buildInputForm(
                    produkPostModel,
                    "Harap isi nama produk",
                    "Masukkan nama produk",
                    "Nama Produk",
                    product.title
                ),
              ],
            ),
          ),
        )
    );
  }

  buildInputForm(ProdukPostModel model, String error, String hint, String label, String initValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
              //errors.add(error);
          }
          return null;
        },
        onChanged: (tempValue){
          if(label=="Nama Produk") {
            print(tempValue);
            model.nama_produk_jasa = tempValue;
          }else if(label=="Harga") {
            model.harga = tempValue;
          }
        },
        onSaved: (newValue) {
          if(label=="Nama Produk") {
            model.nama_produk_jasa = newValue!;
          }else if(label=="Harga") {
            model.harga = newValue!;
          }
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(
            label,
            style: TextStyle(
                fontSize: 20
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        initialValue: initValue,
      ),
    );
  }

   Widget _customDropDown(BuildContext context, KategoriModel? item) {
     if (item == null) {
       return Container();
     }

     return Padding(
       padding: const EdgeInsets.only(left:20.0),
       child: Container(
         child: ListTile(
           contentPadding: EdgeInsets.all(0),
           title: Text(item.nama_kategori),
         ),
       ),
     );
   }

   Widget _customPopupItemBuilder(BuildContext context, KategoriModel? item, bool isSelected) {
     return Container(
       margin: EdgeInsets.symmetric(horizontal: 8),
       decoration: !isSelected
           ? null
           : BoxDecoration(
         border: Border.all(color: Theme.of(context).primaryColor),
         borderRadius: BorderRadius.circular(5),
         color: Colors.white,
       ),
       child: ListTile(
         selected: isSelected,
         title: Text(item?.nama_kategori ?? ''),
       ),
     );
   }

   Future _getThingsOnStartup() async {
     //await Future.delayed(Duration(seconds: 2));
       APIService apiService = new APIService();
       await apiService.getKategoriProduk().then((value) {
         kategori_produk = value;
       });
       for(KategoriModel item in kategori_produk){
         if(item.id==product.kategori_produk_id){
           selKatItem = item;
         }
       }
   }
}
