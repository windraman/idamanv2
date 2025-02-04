import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/Bidang.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/PostResponseModelNoId.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/models/Wilayah.dart';
import 'package:idaman/models/usaha_post.dart';



import '../../../../size_config.dart';

class EditUsahaLanjutan extends StatefulWidget {
  const EditUsahaLanjutan({
    Key? key
  }) : super(key: key);



  static String routeName = "usahalanjutan";



  @override
  State<EditUsahaLanjutan> createState() => _EditUsahaLanjutanState();
}

class _EditUsahaLanjutanState extends State<EditUsahaLanjutan> {
  LocationModel lm = new LocationModel(latitude: "", longitude: "", isMock: true);
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
    lokasi_id:  ""
  );

  late Umkm usaha ;

  @override
  void initState(){
    //loadWilayah(context, "list_provinsi", provinsi, "provinsi");
    //loadBidang(context);
    //loadSubBidang(context);
    super.initState();
  }

  String koordinat = "";



  @override
  Widget build(BuildContext context) {
    final UsahaLanjutanArguments args =
    ModalRoute.of(context)!.settings.arguments as UsahaLanjutanArguments;

    usaha = args.usaha;

    return Scaffold(
      appBar: AppBar(
        title: Text("Data Lanjutan"),
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
                          usahaPostModel,
                          "Harap masukkan Keterangan",
                          "Masukkan keterangan",
                          "Tentang ${usaha.nama_usaha}",
                          usaha.keterangan
                        ),
                        buildInputNumberForm(
                            usahaPostModel,
                            "Harap masukkan jumlah aset",
                            "Masukkan jumlah aset",
                            "Aset",
                            usaha.aset_tetap.toString()
                        ),
                        buildInputNumberForm(
                            usahaPostModel,
                            "Harap masukkan jumlah omset",
                            "Masukkan jumlah omset",
                            "Omset",
                            usaha.omset.toString()
                        ),
                        SizedBox(height: getProportionateScreenWidth(15)),
                        Text("Jumlah Karyawan"),
                        Row(
                          children: [
                            Expanded(
                                child: buildInputNumberForm(
                                    usahaPostModel,
                                    "Harap masukkan jumlah karyawan laki laki",
                                    "Masukkan jumlah karyawan laki laki",
                                    "Laki-laki",
                                    usaha.j_kary_l.toString()
                                ),
                            ),
                            Expanded(
                              child: buildInputNumberForm(
                                  usahaPostModel,
                                  "Harap masukkan jumlah karyawan perempuan",
                                  "Masukkan jumlah karyawan perempuan",
                                  "Perempuan",
                                  usaha.j_kary_p.toString()
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: getProportionateScreenWidth(15)),
                        Text("Update terakhir ${usaha.update_omset}"),
                        SizedBox(height: getProportionateScreenWidth(15)),
                        DefaultButton(
                          text: "PERBAHARUI",
                          press: () async {
                            usahaPostModel.id = usaha.id.toString();
                            usahaPostModel.update_omset = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
                            validateAndSave();
                            if(usaha.nama_usaha.isNotEmpty){
                              print("edit");
                              print(usahaPostModel.toJson());
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
                              print(usahaPostModel.toJson());
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
      ),
    );
  }

   buildInputForm(UsahaPostModel model, String error, String hint, String label, String initValue) {
    return Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: Container(
          height: 180,
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
              if(label=="Tentang ${usaha.nama_usaha}") {
                print(tempValue);
                model.keterangan = tempValue;
              }
            },
            onSaved: (newValue) {
              if(label=="Tentang ${usaha.nama_usaha}") {
                model.keterangan = newValue!;
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
            maxLines: 5,
          ),
        ),
      );
  }

  buildInputNumberForm(UsahaPostModel model, String error, String hint, String label, String initValue) {
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
          if(label=="Aset") {
            print(tempValue);
            model.aset_tetap = tempValue;
          }else if(label=="Omset") {
            model.omset = tempValue;
          }else if(label=="Laki-laki") {
            model.j_kary_l = tempValue;
          } else if(label=="Perempuan") {
            model.j_kary_p = tempValue;
          }
        },
        onSaved: (newValue) {
          if(label=="Aset") {
            model.aset_tetap = newValue!;
          }else if(label=="Omset") {
            model.omset = newValue!;
          }else if(label=="Laki-laki") {
            model.j_kary_l = newValue!;
          } else if(label=="Perempuan") {
            model.j_kary_p = newValue!;
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
          if(item.id==usaha.province_id){
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
          if(item.id==usaha.regency_id){
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
          if(item.id==usaha.district_id){
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
          if(item.id==usaha.village_id){
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


  loadBidang(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getBidang("?sub_bidang=Tidak").then((value) {
      setState(() {
        avalableBidang = value;
        //for(var i = 0; i < usahaSaya.length; i++){
          for(var j = 0; j < avalableBidang.length; j++){
            if(usaha.bidang_usaha.split(";").contains(avalableBidang[j].bidang)){
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
            if(usaha.sub_bidang_usaha.split(";").contains(avalableSubBidang[j].bidang)){
              avalableSubBidang[j].isChecked=true;
            }
          }
        // }
      });

    });

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

class UsahaLanjutanArguments {
  final String namaUsaha;
  final int idUsaha;
  final Umkm usaha;
  UsahaLanjutanArguments({required this.namaUsaha,required this.idUsaha, required this.usaha});
}

