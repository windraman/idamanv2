import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/Bidang.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/models/Wilayah.dart';
import 'package:idaman/models/usaha_post.dart';
import 'package:idaman/screen/penjual/usaha/components/profile_pic_edit.dart';
import 'package:idaman/screen/penjual/usaha/components/profile_pic_new.dart';
import 'package:permission_handler/permission_handler.dart';



import '../../../../models/Pasar.dart';
import '../../../../models/PostResponseModelNoId.dart';
import '../../../../size_config.dart';

class EditUsaha extends StatefulWidget {
  const EditUsaha({
    Key? key,
    required this.usaha
  }) : super(key: key);

  final Umkm usaha;


  @override
  State<EditUsaha> createState() => _EditUsahaState();
}

class _EditUsahaState extends State<EditUsaha> {
  LocationModel lm = new LocationModel(latitude: "", longitude: "", isMock: true);
  List<DropdownMenuItem<String>> provinsi = [];
  String selProvinsi = "";
  List<DropdownMenuItem<String>> kabupaten = [];
  String selKabupaten = "";
  List<DropdownMenuItem<String>> kecamatan = [];
  String selKecamatan = "";
  List<DropdownMenuItem<String>> kelurahan = [];
  String selKelurahan = "";
  List<DropdownMenuItem<String>> pasar = [];
  String selPasar = "";

  List<WilayahModel> provinsiItems = [];
  WilayahModel? selProvItem;
  List<WilayahModel> kabupatenItems = [];
  WilayahModel? selKabItem;
  List<WilayahModel> kecamatanItems = [];
  WilayahModel? selKecItem;
  List<WilayahModel> kelurahanItems = [];
  WilayahModel? selKelItem;
  List<PasarModel> pasarItems = [];
  PasarModel? selPasarItem;

  List<String> errors = [];
  final _formKey = new GlobalKey<FormState>();

  String selId = "";
  String selNamaUsaha = "";
  String selBidangUsaha = "";
  String selSubBidangUsaha = "";
  String selAlamatUsaha = "";
  String selLat = "";
  String selLon = "";
  String selKeterangan = "";
  String selPhoto = "";
  String selPetaIcon = "";
  String selUpdatedBy = "";

  List<BidangModel> avalableBidang = [];
  List<BidangModel> avalableSubBidang = [];

  XFile? imageFile;
  File? croppedImage;

  UsahaPostModel usahaPostModel = new UsahaPostModel(
      id: "0",
      //warga_bjb_id: MyApp.localStorage.getString("id").toString(),
      nama_usaha: "",
      bidang_usaha: "",
      sub_bidang_usaha: "",
      alamat_usaha: "",
      province_id: "",
      regency_id: "",
      district_id: "",
      village_id: "",
      lat:"",
      lon:"",
      keterangan:  "",
      photo: "",
      peta_icon: "",
      updated_by: MyApp.localStorage.getString("id").toString(),
      perizinan: "",
      j_kary_l : "",
      j_kary_p : "",
      aset_tetap : "",
      omset : "",
      update_omset : "",
      lokasi_id: ""
  );

  @override
  void initState(){
    loadWilayah(context, "list_provinsi", provinsi, "provinsi");
    loadBidang(context);
    loadSubBidang(context);
    loadPasar(context);
    super.initState();
  }

  String koordinat = "";

  @override
  Widget build(BuildContext context) {
    //loadWilayah(context, "list_provinsi", provinsi);

    // usahaPostModel.updated_by = MyApp.localStorage.getString("id").toString();
    // usahaPostModel.id = widget.usaha.id.toString();
    // usahaPostModel.nama_usaha = widget.usaha.nama_usaha;
    // usahaPostModel.alamat_usaha = widget.usaha.alamat_usaha;
    // usahaPostModel.province_id = widget.usaha.province_id.toString();
    // usahaPostModel.regency_id = widget.usaha.regency_id.toString();
    // usahaPostModel.district_id = widget.usaha.district_id.toString();
    // usahaPostModel.village_id = widget.usaha.village_id.toString();
    // usahaPostModel.lat = widget.usaha.lat;
    // usahaPostModel.lon = widget.usaha.lon;
    // usahaPostModel.bidang_usaha = widget.usaha.bidang_usaha;
    // usahaPostModel.sub_bidang_usaha = widget.usaha.sub_bidang_usaha;

    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
            children: [
              if(widget.usaha.photo.isNotEmpty && croppedImage == null)
                ProfilePicEdit(
                    photo: Image.network(
                        widget.usaha.photo,
                      fit: BoxFit.cover,
                    ),
                  take:() {
                    _pickImageDialog(context);
                  } ,
                ),
              if(widget.usaha.photo.isEmpty && croppedImage == null)
                ProfilePicNew(
                  photo:Image.asset(
                      "assets/images/noimage.png",
                      fit: BoxFit.cover,
                    ),
                  take:() {
                    _pickImageDialog(context);
                  }),
              if( croppedImage != null)
                ProfilePicNew(
                    photo:Image.file(
                        File(croppedImage!.path),
                      fit: BoxFit.cover,
                    ),
                    take:() {
                      Navigator.pop(context);
                      _pickImageDialog(context);
                    }),
              SizedBox(height: 20),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildInputForm(
                        usahaPostModel,
                        "Harap masukkan Nama Usaha",
                        "Masukkan nama usaha",
                        "Nama Usaha",
                        widget.usaha.nama_usaha
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownSearch<PasarModel>(
                          items: pasarItems,
                          //maxHeight: 300,
                          //onFind: (String? filter) => loadProvinsi(filter),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Tempat Berusaha (Opsional)",
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          // dropdownSearchDecoration: InputDecoration(
                          //   labelText: "Tempat Berusaha (Opsional)",
                          //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                          //   border: OutlineInputBorder(),
                          // ),
                          onChanged: (PasarModel? value){
                            String? selected = value?.id;
                            // String? selectedProv = value?.provinceId;
                            String? selectedLat= value?.lat;
                            String? selectedLon= value?.lon;
                            print(value?.id);
                            selPasar = selected.toString();
                            // selKecamatan = selectedProv.toString();
                            koordinat = selectedLat.toString() + "," + selectedLon.toString();
                            setState(() {

                            });
                          },
                          selectedItem: selPasarItem ,
                          // showSearchBox: false,
                          dropdownBuilder: _pasarDropDown,
                          popupProps: PopupProps.menu(
                            fit: FlexFit.loose,
                            itemBuilder: _pasarPopupItemBuilder,
                          ),
                        ),
                      ),
                      buildInputForm(
                          usahaPostModel,
                          "Harap masukkan alamat",
                          "Masukkan alamat usaha",
                          "Alamat Usaha",
                          widget.usaha.alamat_usaha
                      ),
                      DefaultButton(
                        text: "Ambil Koordinat GPS",
                        press: () async {
                          LocationService lc = new LocationService();
                          lm = await lc.getCurrentPosition();
                          koordinat = lm.latitude + "," + lm.longitude;
                          selLat = lm.latitude;
                          selLon = lm.longitude;
                          setState(() {

                          });
                        },
                        warna: Colors.orangeAccent,
                      ),
                      Text(koordinat),
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
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                    children: avalableBidang.map((bidang) {
                                      return CheckboxListTile(
                                          value:  bidang.isChecked,
                                          title: Text(bidang.bidang),
                                          onChanged: (newValue) {
                                            setState(() {
                                              bidang.isChecked = newValue!;
                                              List<String> bidang_usaha = [];
                                              for(var bdg in avalableBidang){
                                                if(bdg.isChecked==true) {
                                                  bidang_usaha.add(bdg.bidang);
                                                }
                                              }
                                              selBidangUsaha = bidang_usaha.join(";").toString();


                                            });
                                          });
                                    }).toList()
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: -6,
                                child: Container(
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    color: Colors.white,
                                    child: Text(
                                        'Pilih Bidang',
                                        style: TextStyle(
                                          backgroundColor: Colors.white
                                        ),
                                    )
                                ),
                              )
                            ],
                          ),
                      ),
                      SizedBox(height: getProportionateScreenWidth(15)),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey
                                ),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                  children: avalableSubBidang.map((subbidang) {
                                    return CheckboxListTile(
                                        value:  subbidang.isChecked,
                                        title: Text(subbidang.bidang),
                                        onChanged: (newValue) {
                                          subbidang.isChecked = newValue!;
                                          List<String> sub_bidang_usaha = [];
                                          for(var bdg in avalableSubBidang){
                                            if(bdg.isChecked==true) {
                                              sub_bidang_usaha.add(bdg.bidang);
                                            }
                                          }
                                          print(sub_bidang_usaha.join(";").toString());
                                          selSubBidangUsaha = sub_bidang_usaha.join(";").toString();

                                          setState(() {

                                          });
                                        },
                                    );
                                  }).toList()
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: -6,
                              child: Container(
                                  padding: EdgeInsets.only(left: 5,right: 5),
                                  color: Colors.white,
                                  child: Text(
                                    'Pilih Sub Bidang (EKRAF)',
                                    style: TextStyle(
                                        backgroundColor: Colors.white
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                      DefaultButton(
                        text: "SIMPAN",
                        press: () async {
                          usahaPostModel.id = widget.usaha.id.toString();
                          usahaPostModel.photo = selPhoto;
                          usahaPostModel.province_id = selProvinsi;
                          usahaPostModel.regency_id = selKabupaten;
                          usahaPostModel.district_id = selKecamatan;
                          usahaPostModel.village_id = selKelurahan;
                          usahaPostModel.bidang_usaha = selBidangUsaha;
                          usahaPostModel.sub_bidang_usaha = selSubBidangUsaha;
                          usahaPostModel.lat = selLat;
                          usahaPostModel.lon = selLon;
                          usahaPostModel.lokasi_id = selPasar;
                          validateAndSave();
                          if(widget.usaha.nama_usaha.isNotEmpty){
                            print("edit");
                            //print(usahaPostModel.toJson());
                            APIService api = new APIService();

                            PostResponseModelNoId res = await api.updateUsaha(usahaPostModel);
                            print(res);
                            if (res.api_status == 1){
                              final snackBar = SnackBar(
                                  content: Text("Usaha anda berhasil diubah.")
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context);
                            }else{
                              final snackBar = SnackBar(
                                  content: Text(res.api_message)
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }else{
                            print("add");
                            APIService api = new APIService();
                            //print(usahaPostModel.toJson());
                           // print(api.addUsaha(usahaPostModel));
                            PostResponseModel res = await api.addUsaha(usahaPostModel);
                            if (res.api_status == 1){
                              final snackBar = SnackBar(
                                  content: Text("Usaha anda berhasil ditambahkan.")
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context);
                            }else{
                              final snackBar = SnackBar(
                                  content: Text(res.api_message)
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    );
  }

   buildInputForm(UsahaPostModel model, String error, String hint, String label, String initValue) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                errors.add(error);
              });
            }
            return null;
          },
          onChanged: (tempValue){
            if(label=="Nama Usaha") {
              print(tempValue);
              model.nama_usaha = tempValue;
            }else if(label=="Alamat Usaha") {
              model.alamat_usaha = tempValue;
            }
          },
          onSaved: (newValue) {
            if(label=="Nama Usaha") {
              model.nama_usaha = newValue!;
            }else if(label=="Alamat Usaha") {
              model.alamat_usaha = newValue!;
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
          if(item.id==widget.usaha.province_id){
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
          if(item.id==widget.usaha.regency_id){
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
          if(item.id==widget.usaha.district_id){
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
          if(item.id==widget.usaha.village_id){
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

  Widget _pasarDropDown(BuildContext context, PasarModel? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),

        title: Text(item.nama.toString()),
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

  Widget _pasarPopupItemBuilder(BuildContext context, PasarModel? item, bool isSelected) {
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
        title: Text(item?.nama ?? ''),
      ),
    );
  }


  loadBidang(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getBidang("?sub_bidang=Tidak").then((value) {
      setState(() {
        avalableBidang = value;
        //for(var i = 0; i < usahaSaya.length; i++){
          for(var j = 0; j < avalableBidang.length; j++){
            if(widget.usaha.bidang_usaha.split(";").contains(avalableBidang[j].bidang)){
              avalableBidang[j].isChecked=true;
            }
          }
        //}
      });

    });

  }

  loadSubBidang(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getBidang("?sub_bidang=Ya").then((value) {
      setState(() {
        avalableSubBidang = value;
        // for(var i = 0; i < usahaSaya.length; i++){
          for(var j = 0; j < avalableSubBidang.length; j++){
            if(widget.usaha.sub_bidang_usaha.split(";").contains(avalableSubBidang[j].bidang)){
              avalableSubBidang[j].isChecked=true;
            }
          }
        // }
      });

    });

  }

  loadPasar(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getPasar().then((value) {
      setState(() {
        pasarItems = value!;
        pasarItems.add(new PasarModel(id:"0",nama: "Tempat Sendiri", kategori_lokasi_id: '0', lat: '0', lon: '0', alamat: '', gambar_utama: '', numOfProduk: 0));
        for(PasarModel item in pasarItems){
          if(item.id==widget.usaha.lokasi_id){
            print(item.nama);
            selPasarItem = item;
          }
        }
      });

    });

  }

  void _pickImageDialog(BuildContext context) async{
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Ambil Dari : '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    ElevatedButton(
                      child: const Text('Gallery'),
                      onPressed: (){
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                    ),
                    Spacer(),
                    ElevatedButton(
                      child: const Text('Camera'),
                      onPressed: () async{
                        print(await Permission.camera.status);
                        if(await Permission.camera.status.isDenied){
                          MyApp.useCamera(
                              context,
                              "Akses Kamera",
                              "Aplikasi ini membutuhkan akses kamera untuk mengambil gambar aktual",
                                  () {
                                Navigator.pop(context);
                              },
                                  () {
                                Navigator.pop(context);
                                getImage(ImageSource.camera);
                              }
                          );
                        }else{
                          Navigator.pop(context);
                          getImage(ImageSource.camera);
                        }
                      },
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void getImage(ImageSource source) async {
        try {
          final pickedImage = await ImagePicker().pickImage(source: source);
          if (pickedImage != null) {
            CroppedFile? cropped = await ImageCropper().cropImage(
                sourcePath: pickedImage.path,
                compressFormat: ImageCompressFormat.jpg,
                compressQuality: 100
            );
            croppedImage = File((await cropped?.path)!);
            selPhoto = (await cropped?.path)!;
            setState(() {

            });
          }
        } catch (e) {
          print("take camera " + e.toString());
          imageFile = null;
          setState(() {});
        }
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

}

