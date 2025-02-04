import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/Bidang.dart';
import 'package:idaman/models/DataDiri.dart';
import 'package:idaman/models/Wilayah.dart';
import 'package:idaman/models/data_diri_post.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';



import '../../../../size_config.dart';
import '../../../models/PostResponseModelNoId.dart';

class EditDataDiri extends StatefulWidget {
  const EditDataDiri({
    Key? key,
    required this.idWarga, required this.data
  }) : super(key: key);

  final String idWarga;
  final DataDiriModel data;


  @override
  State<EditDataDiri> createState() => _EditDataDiriState();
}

class _EditDataDiriState extends State<EditDataDiri> {
  @override
  void initState(){
    super.initState();
    //loadWarga(widget.idWarga);
    loadWilayah(context, "list_provinsi", provinsi, "provinsi");
  }

  // LocationModel lm = new LocationModel(latitude: "", longitude: "", isMock: true);
  List<DropdownMenuItem<String>> provinsi = [];
  String selProvinsi = "";
  List<DropdownMenuItem<String>> kabupaten = [];
  String selKabupaten = "";
  List<DropdownMenuItem<String>> kecamatan = [];
  String selKecamatan = "";
  List<DropdownMenuItem<String>> kelurahan = [];
  String selKelurahan = "";

  List<WilayahModel> provinsiItems = [];
  WilayahModel? selProvItem;
  List<WilayahModel> kabupatenItems = [];
  WilayahModel? selKabItem;
  List<WilayahModel> kecamatanItems = [];
  WilayahModel? selKecItem;
  List<WilayahModel> kelurahanItems = [];
  WilayahModel? selKelItem;

  List<String> errors = [];
  final _formKey = new GlobalKey<FormState>();

  String selNik = "";
  String selNamaLengkap = "";
  String selJk = "";
  String selTmptLhr = "";
  String selTglLhr = "";
  String selAlamat2 = "";
  String selRt = "";
  String selRw = "";
  String selNokk = "";
  String selUpdatedBy = "";

  List<BidangModel> avalableBidang = [];
  List<BidangModel> avalableSubBidang = [];

  XFile? imageFile;
  File? croppedImage;

  DataDiriPostModel dataPostModel = new DataDiriPostModel(
      id:  "",
      nama_lgkp: "",
      jk: "",
      tmpt_lhr: "",
      tgl_lhr: "",
      pddk_akhir_id: "",
      pekerjaan_id: "",
      alamat2: "",
      rt: "",
      rw:"",
      nama_prop:"",
      nama_kab:  "",
      nama_kec: "",
      nama_kel: "",
      no_kk: "",
      updated_by: MyApp.localStorage.getString("id").toString()
  );

  // DataDiriModel data = new DataDiriModel(
  //     nik: "",
  //     nama_lgkp: "",
  //     jk: "",
  //     tmpt_lhr: "",
  //     tgl_lhr: "",
  //     pddk_akhir_id: "",
  //     pekerjaan_id: "",
  //     alamat2:  "",
  //     rt: "",
  //     rw: "",
  //     nama_prop: "",
  //     nama_kab: "",
  //     nama_kec: "",
  //     nama_kel: "",
  //     provinsi: "",
  //     kabupaten: "",
  //     kecamatan: "",
  //     kelurahan: "",
  //     no_kk: ""
  // );


  DateTime date = DateTime.now();


  String koordinat = "";

  @override
  Widget build(BuildContext context) {
    if(widget.data.tgl_lhr.isNotEmpty){
      date = DateTime.parse(widget.data.tgl_lhr);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Diri"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildInputForm(
                          dataPostModel,
                          "Harap masukkan Nama Lengkap",
                          "Masukkan nama lengkap",
                          "Nama Lengkap",
                            widget.data.nama_lgkp,
                          []
                        ),
                        buildInputForm(
                            dataPostModel,
                            "Harap masukkan Tampat lahir",
                            "Masukkan Tempat lahir",
                            "Tempat Lahir",
                            widget.data.tmpt_lhr,
                          []
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey
                                ),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${date.day} / ${date.month} / ${date.year}",
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async{
                                          DateTime? newDate = await showDatePicker(
                                              context: context,
                                              initialDate: widget.data.tgl_lhr.isNotEmpty ? DateTime.parse(widget.data.tgl_lhr) : date,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime.now()
                                          );

                                          setState(() {
                                            date = newDate!;
                                            selTglLhr = "${date.year}-${date.month}-${date.day}";
                                          });
                                        },
                                        child: Text("Pilih"))
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: -6,
                              child: Container(
                                  padding: EdgeInsets.only(left: 5,right: 5),
                                  color: Colors.white,
                                  child: Text(
                                    'Tanggal Lahir',
                                    style: TextStyle(
                                        backgroundColor: Colors.white
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                        buildInputForm(
                            dataPostModel,
                            "Harap masukkan alamat",
                            "Masukkan alamat",
                            "Alamat",
                            widget.data.alamat2,
                          []
                        ),
                        Stack(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: buildInputForm(
                                        dataPostModel,
                                        "Harap masukkan RT",
                                        "Masukkan RT",
                                        "RT",
                                        widget.data.rt,
                                        [FilteringTextInputFormatter.digitsOnly]
                                    ),
                                  ),
                                  Text(
                                      "/",
                                    style: TextStyle(
                                      fontSize: 30
                                    ),
                                  ),
                                  Flexible(
                                    child: buildInputForm(
                                        dataPostModel,
                                        "Harap masukkan RW",
                                        "Masukkan RW",
                                        "RW",
                                        widget.data.rw,
                                        [FilteringTextInputFormatter.digitsOnly]
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownSearch<WilayahModel>(
                            items: provinsiItems,
                            //maxHeight: 300,
                            //onFind: (String? filter) => loadProvinsi(filter),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Pilih Provinsi",
                                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            // dropdownSearchDecoration: InputDecoration(
                            //   labelText: "Pilih Provinsi",
                            //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            //   border: OutlineInputBorder(),
                            // ),
                            onChanged: (WilayahModel? value){
                              String? selected = value?.id;
                              print(value?.id);
                              selProvinsi = selected.toString();
                              loadWilayah(context, "list_kabupaten?province_id=" + selected.toString() , kabupaten, "kabupaten");
                            },
                            selectedItem: selProvItem ,
                            // showSearchBox: false,
                            dropdownBuilder: _customDropDownExample,
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              itemBuilder: _customPopupItemBuilderExample2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownSearch<WilayahModel>(
                            items: kabupatenItems,
                            //maxHeight: 300,
                            //onFind: (String? filter) => loadProvinsi(filter),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Pilih Kabupaten",
                                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            // dropdownSearchDecoration: InputDecoration(
                            //   labelText: "Pilih Kabupaten",
                            //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            //   border: OutlineInputBorder(),
                            // ),
                            onChanged: (WilayahModel? value){
                              String? selected = value?.id;
                              print(value?.id);
                              selKabupaten = selected.toString();
                              loadWilayah(context, "list_kecamatan?regency_id=" + selected.toString() , kecamatan, "kecamatan");
                            },
                            selectedItem: selKabItem ,
                            // showSearchBox: false,
                            dropdownBuilder: _customDropDownExample,
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              itemBuilder: _customPopupItemBuilderExample2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownSearch<WilayahModel>(
                            items: kecamatanItems,
                            //maxHeight: 300,
                            //onFind: (String? filter) => loadProvinsi(filter),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Pilih Kecamatan",
                                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            // dropdownSearchDecoration: InputDecoration(
                            //   labelText: "Pilih Kecamatan",
                            //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            //   border: OutlineInputBorder(),
                            // ),
                            onChanged: (WilayahModel? value){
                              String? selected = value?.id;
                              print(value?.id);
                              selKecamatan = selected.toString();
                              loadWilayah(context, "list_kelurahan?district_id=" + selected.toString() , kelurahan, "kelurahan");
                            },
                            selectedItem: selKecItem ,
                            // showSearchBox: false,
                            dropdownBuilder: _customDropDownExample,
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              itemBuilder: _customPopupItemBuilderExample2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownSearch<WilayahModel>(
                            items: kelurahanItems,
                            //maxHeight: 300,
                            //onFind: (String? filter) => loadProvinsi(filter),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Pilih Kelurahan",
                                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            // dropdownSearchDecoration: InputDecoration(
                            //   labelText: "Pilih Kelurahan",
                            //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            //   border: OutlineInputBorder(),
                            // ),
                            onChanged: (WilayahModel? value){
                              String? selected = value?.id;
                              print(value?.id);
                              selKelurahan = selected.toString();
                            },
                            selectedItem: selKelItem ,
                            // showSearchBox: false,
                            dropdownBuilder: _customDropDownExample,
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              itemBuilder: _customPopupItemBuilderExample2,
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(15)),
                        DefaultButton(
                          text: "SIMPAN",
                          press: () async {
                            dataPostModel.id = widget.idWarga;
                            dataPostModel.nama_lgkp = selNamaLengkap;
                            dataPostModel.alamat2 = selAlamat2;
                            dataPostModel.rt = selRt;
                            dataPostModel.rw = selRw;
                            dataPostModel.nama_prop = selProvinsi;
                            dataPostModel.nama_kab = selKabupaten;
                            dataPostModel.nama_kec = selKecamatan;
                            dataPostModel.nama_kel = selKelurahan;
                            dataPostModel.jk = selJk;
                            dataPostModel.tmpt_lhr = selTmptLhr;
                            dataPostModel.tgl_lhr = selTglLhr;
                            validateAndSave();
                            if(widget.data.tmpt_lhr.isNotEmpty){
                              print("edit");
                              print(dataPostModel.toJson());
                              APIService api = new APIService();

                              PostResponseModelNoId res = await api.updateDataDiri(dataPostModel);
                              print(res);
                              if (res.api_status == 1){
                                final snackBar = SnackBar(
                                    content: Text("Data diri anda berhasil diubah.")
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                Navigator.pop(context);
                              }
                            }
                            setState(() {

                            });
                          },
                          warna: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),


              ]
          ),
        ),
      ),
    );
  }

   buildInputForm(DataDiriPostModel model, String error, String hint, String label, String initValue, List<TextInputFormatter> format) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          inputFormatters: format,
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                errors.add(error);
              });
            }
            return null;
          },
          onChanged: (tempValue){
            if(label=="Nama Lengkap") {
              model.nama_lgkp = tempValue;
            }else if(label=="Alamat") {
              model.alamat2 = tempValue;
            }else if(label=="Tempat Lahir") {
              model.tmpt_lhr = tempValue;
            }else if(label=="RT") {
              model.rt = tempValue;
            }else if(label=="RW") {
              model.rw = tempValue;
            }
          },
          onSaved: (newValue) {
            if(label=="Nama Lengkap") {
              model.nama_lgkp = newValue!;
            }else if(label=="Alamat") {
              model.alamat2 = newValue!;
            }else if(label=="Tempat Lahir") {
              model.tmpt_lhr = newValue!;
            }else if(label=="RT") {
              model.rt = newValue!;
            }else if(label=="RW") {
              model.rw = newValue!;
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

  resetKab(){
    kabupaten = [DropdownMenuItem(
        child: Text("Pilih Kab/Kota"),
        value: "0"
    )];
    selKabupaten = "0";
  }

  loadWilayah(BuildContext context,String query,List<DropdownMenuItem<String>> target,String untuk) async{
    APIService apiService = new APIService();
    await apiService.getWilayah(query).then((value) {

      target.clear();
      List<WilayahModel> wm = value;
      if(untuk=="provinsi") {
        provinsiItems = [];
        provinsiItems = value;
        for(WilayahModel item in provinsiItems){
          if(item.id==widget.data.nama_prop){
            print(item.name);
            selProvItem = item;
            loadWilayah(context, "list_kabupaten?province_id=" + item.id , kabupaten, "kabupaten");
          }
        }
      }
      if(untuk=="kabupaten") {
        kelurahan = [];
        kabupatenItems = [];
        kabupatenItems = value;
        for(WilayahModel item in kabupatenItems){
          if(item.id==widget.data.nama_kab){
            print(item.name);
            selKabItem = item;
            loadWilayah(context, "list_kecamatan?regency_id=" + item.id , kecamatan, "kecamatan");
          }
        }
      }
      if(untuk=="kecamatan") {
        kecamatanItems = [];
        kecamatanItems = value;
        for(WilayahModel item in kecamatanItems){
          if(item.id==widget.data.nama_kec){
            print(item.name);
            selKecItem = item;
            loadWilayah(context, "list_kelurahan?district_id=" + item.id , kelurahan, "kelurahan");
          }
        }
      }
      if(untuk=="kelurahan") {
        kelurahanItems = [];
        kelurahanItems = value;
        for(WilayahModel item in kelurahanItems){
          if(item.id== widget.data.nama_kel){
            print(item.name);
            selKelItem = item;
          }
        }
      }
      setState((){

      });
    });
  }

  Widget _customDropDownExample(BuildContext context, WilayahModel? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),

        title: Text(item.name),
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(BuildContext context, WilayahModel? item, bool isSelected) {
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
        title: Text(item?.name ?? ''),
      ),
    );
  }








  bool validateAndSave() {
    final form = _formKey.currentState;
    debugPrint(form?.validate().toString());
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // void loadWarga(String idWarga) async{
  //   APIService api = new APIService();
  //   widget.data = await api.getWarga(idWarga);
  //   setState(() {
  //     print(widget.data.nama_lgkp);
  //   });
  // }

}

