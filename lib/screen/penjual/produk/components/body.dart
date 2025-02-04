import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/models/Berat.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/PostResponseModelNoId.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/produk_image_post.dart';
import 'package:idaman/models/produk_post.dart';
import 'package:idaman/models/status_produk.dart';
import 'package:idaman/screen/penjual/produk/components/photo_produk_slider.dart';

import '../../../../main.dart';

final formatCurrency  = new NumberFormat.simpleCurrency(locale: 'id_ID',decimalDigits: 0);

class Body extends StatefulWidget {
  const Body({Key? key, required this.produk}) : super(key: key);
  final Product produk;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<KategoriModel> kategori_produk = [];
  KategoriModel? selKatItem;

  List<BeratModel> berat = [];
  BeratModel? selBeratItem;

  List<StatusProdukModel> status_produk = [];

  ProdukPostModel produkPostModel = ProdukPostModel(
      id: "",
      nama_produk_jasa: "",
      harga: "",
      mata_uang_id: "",
      umkm_usaha_id: "",
      lokasi_id: "",
      deskripsi_singkat: "",
      deskripsi_produk: "",
      berat: "",
      satuan_berat: "",
      kategori_produk_id: "",
      status_produk: "",
      diskon: "",
      etalase_id: "",
      updated_by: MyApp.localStorage.getString("id").toString()
  );

  List<ProdukImagePostModel> newPhotos = [];

  List<String> errors = [];

  String selKategori = "";
  String selNamaProduk = "";
  String selHarga = "";
  String selBerat = "";
  String selSatuanBerat = "";
  String selDeskSingkat = "";
  String selDeskripsi = "";
  String selStatus = "";
  StatusProdukModel? selStatusProduk;
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    loadKategori();
    loadBerat();
    status_produk = StatusProdukModel.getStatusProduk();
    for(StatusProdukModel status in status_produk){
      if(status.id == widget.produk.status_produk){
        setSelectedStatus(status);
      }
    }
    super.initState();
  }

  setSelectedStatus(StatusProdukModel model) {
    setState(() {
      selStatusProduk = model;
      selStatus = model.id.toString();
      produkPostModel.status_produk = model.id.toString();
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (StatusProdukModel model in status_produk) {
      widgets.add(
        RadioListTile(
          value: model,
          groupValue: selStatusProduk,
          title: Text(model.name),
          onChanged: (StatusProdukModel? currentStatus) {
            //print(currentStatus?.id);
            setSelectedStatus(currentStatus!);
          },
          selected: selStatusProduk == model,
          activeColor: Colors.red,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.produk.umkm_usaha_id);
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PhotoProdukSlider(
                  images: widget.produk.images,
                  parentId: widget.produk.id.toString(),
                  newPath: (val){
                    print(val);
                    newPhotos.add(ProdukImagePostModel(
                        parent_id: widget.produk.id.toString(),
                        file: val,
                        parent: "produk",
                        utama: "0"
                    )
                    );
                  },
                  delPhotoId: (val){
                    print(val);
                  }),
              Container(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
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
                          dropdownBuilder: _customDropDownExample,
                          // popupItemBuilder: _customPopupItemBuilderExample2,
                        ),
                      ),
                      buildInputForm(
                          produkPostModel,
                          "Harap isi nama produk",
                          "Masukkan nama produk",
                          "Nama Produk",
                          widget.produk.title
                      ),
                      buildInputNumberForm(
                          produkPostModel,
                          "Harap isi harga",
                          "Masukkan harga",
                          "Harga (${formatCurrency.currencySymbol})" ,
                          "${widget.produk.price==0 ? "" : widget.produk.price}"
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: buildInputNumberForm(
                                produkPostModel,
                                "Harap isi berat",
                                "Masukkan berat",
                                "Berat",
                                "${widget.produk.berat==0?"":widget.produk.berat}"
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownSearch<BeratModel>(
                                items: berat,
                                // maxHeight: 300,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "",
                                    contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                // dropdownSearchDecoration: InputDecoration(
                                //   labelText: "",
                                //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                                //   border: OutlineInputBorder(),
                                // ),
                                onChanged: (BeratModel? value) {
                                  String? selected = value?.id;
                                  selSatuanBerat = selected.toString();
                                },
                                selectedItem: selBeratItem,
                                // showSearchBox: false,
                                dropdownBuilder: _beratDropDown,
                                // popupItemBuilder: _beratPopupItemBuilder,
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildInputForm(
                          produkPostModel,
                          "Harap isi deskripsi singkat",
                          "Masukkan deskripsi singkat",
                          "Deskripsi Singkat",
                          widget.produk.description
                      ),
                      buildMultilineInputForm(
                          produkPostModel,
                          "Harap isi deskripsi lengkap",
                          "Masukkan deskripsi lengkap",
                          "Deskripsi Lengkap",
                          widget.produk.longDesc
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children:[
                    Container(
                      decoration: BoxDecoration(
                            border: Border.all(
                            color: Colors.grey
                            ),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children:createRadioListUsers()
                      ),
                    ),
                    Positioned(
                      left: 40,
                      top: -6,
                      child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 0),
                          color: Colors.white,
                          child: Text(
                            'Pilih Status Produk',
                            style: TextStyle(
                                backgroundColor: Colors.white
                            ),
                          )
                      ),
                    )
                  ]
                ),
              ),
              DefaultButton(
                  text: "SIMPAN",
                  press: () async {
                    if(widget.produk.title.isNotEmpty){
                      //update
                      produkPostModel.id = widget.produk.id.toString();
                      APIService api = new APIService();
                      PostResponseModelNoId res = await api.updateProduk(produkPostModel);
                      print(produkPostModel.toJson());
                      if (res.api_status == 1){
                        int numOfnew = newPhotos.length;
                        int uploaded = 0;
                        for(ProdukImagePostModel pimp in newPhotos) {
                          print(pimp.toJson());
                          PostResponseModel res = await api.uploadProdukImage(pimp);
                          print(res);
                          if (res.api_status == 1) {
                            uploaded+=1;
                          }
                        }
                        newPhotos = [];
                        Navigator.pop(context);
                      }

                    }else{
                      produkPostModel.umkm_usaha_id = widget.produk.umkm_usaha_id.toString();
                      produkPostModel.satuan_berat = selSatuanBerat;
                      produkPostModel.kategori_produk_id = selKategori;
                      print(produkPostModel.toJson());
                      APIService api = new APIService();
                      PostResponseModel res = await api.addProduk(produkPostModel);
                      print(res);
                      if (res.api_status == 1) {
                        String newId = res.id.toString();
                        int numOfnew = newPhotos.length;
                        int uploaded = 0;
                        for (ProdukImagePostModel pimp in newPhotos) {
                          pimp.parent_id = newId;
                          print(pimp.toJson());
                          PostResponseModel res = await api.uploadProdukImage(pimp);
                          print(res);
                          if (res.api_status == 1) {
                            uploaded += 1;
                          }
                        }
                        newPhotos = [];
                        Navigator.pop(context);
                      }
                    }

                  },
                  warna: Colors.red
              )
            ]
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
            errors.add(error);
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

  buildMultilineInputForm(ProdukPostModel model, String error, String hint, String label, String initValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        minLines: 1,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            errors.add(error);
          }
          return null;
        },
        onChanged: (tempValue){
          if(label=="Deskripsi Singkat") {
            print(tempValue);
            model.deskripsi_singkat = tempValue;
          }else if(label=="Deskripsi Lengkap") {
            model.deskripsi_produk = tempValue;
          }
        },
        onSaved: (newValue) {
          if(label=="Deskripsi Singkat") {
            model.deskripsi_singkat = newValue!;
          }else if(label=="Deskripsi Lengkap") {
            model.deskripsi_produk = newValue!;
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

  buildInputNumberForm(ProdukPostModel model, String error, String hint, String label, String initValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            errors.add(error);
          }
          return null;
        },
          keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (tempValue){
          if(label=="Harga (Rp)") {
            print(tempValue);
            model.harga = tempValue;
          }else if(label=="Berat") {
            model.berat = tempValue;
          }
        },
        onSaved: (newValue) {
          if(label=="Harga (Rp)") {
            model.harga = newValue!;
          }else if(label=="Berat") {
            model.berat = newValue!;
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

  Widget _customDropDownExample(BuildContext context, KategoriModel? item) {
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

  Widget _customPopupItemBuilderExample2(BuildContext context, KategoriModel? item, bool isSelected) {
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

  Widget _beratDropDown(BuildContext context, BeratModel? item) {
    if (item == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(left:20.0),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.all(0),

          title: Text(item.simbol),
        ),
      ),
    );
  }

  Widget _beratPopupItemBuilder(BuildContext context, BeratModel? item, bool isSelected) {
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
        title: Text(item?.nama_berat ?? ''),
      ),
    );
  }

  loadKategori() async{
    APIService apiService = new APIService();
    await apiService.getKategoriProduk().then((value) {
      kategori_produk = value;
    });

    for(KategoriModel item in kategori_produk){
      //print("samakah " + item.id + " dengan " + widget.produk.kategori_produk_id.toString());
      if(item.id==widget.produk.kategori_produk_id.toString()){
        //print("sama");
        selKatItem = item;
      }
    }
    setState(() {

    });

  }

  loadBerat() async{
    APIService apiService = new APIService();
    await apiService.getBerat().then((value) {
      berat = value;
    });

    for(BeratModel item in berat){
      if(item.id==widget.produk.satuan_berat_id.toString()){
        selBeratItem = item;
      }
    }
    setState(() {

    });

  }
}


