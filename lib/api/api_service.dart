
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:idaman/main.dart';
import 'package:idaman/models/App.dart';
import 'package:idaman/models/Bantuan.dart';
import 'package:idaman/models/Berat.dart';
import 'package:idaman/models/Bidang.dart';
import 'package:idaman/models/DataDiri.dart';
import 'package:idaman/models/Kategori.dart';
import 'package:idaman/models/Keranjang.dart';
import 'package:idaman/models/Notifikasi.dart';
import 'package:idaman/models/Pasar.dart';
import 'package:idaman/models/Pelatihan.dart';
import 'package:idaman/models/Photos.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/PostResponseModelNoId.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/models/ResponseModel.dart';
import 'package:idaman/models/Shortcut.dart';
import 'package:idaman/models/SingleResponseModel.dart';
import 'package:idaman/models/StatsResponseModel.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/models/Wilayah.dart';
import 'package:idaman/models/aspirasi_post.dart';
import 'package:idaman/models/chat_data.dart';
import 'package:idaman/models/data_diri_post.dart';
import 'package:idaman/models/del_response_model.dart';
import 'package:idaman/models/keranjang_post.dart';
import 'package:idaman/models/komentar_data.dart';
import 'package:idaman/models/komentar_post.dart';
import 'package:idaman/models/pelatihan_post.dart';
import 'package:idaman/models/produk_image_post.dart';
import 'package:idaman/models/produk_post.dart';
import 'package:idaman/models/profil_post.dart';
import 'package:idaman/models/reaksi_post.dart';
import 'package:idaman/models/register_post.dart';
import 'package:idaman/models/shorcut_model.dart';
import 'package:idaman/models/slide_model.dart';
import 'package:idaman/models/token_post.dart';
import 'package:idaman/models/transaksi_post.dart';
import 'package:idaman/models/usaha_post.dart';
import 'package:idaman/screen/home/components/promo_slider.dart';
import 'dart:convert';
import '../constants.dart';
import '../models/Homecare.dart';
import '../models/Layanan.dart';
import '../models/Transaksi.dart';
import '../models/bantuan_post.dart';
import '../models/homecare_media.dart';
import '../models/kategori_lokasi.dart';
import '../models/login_model.dart';
import '../models/lokasi_model.dart';
import '../models/profil_post_response_model.dart';
import 'package:crypto/crypto.dart';

class APIService {
  Future getServer() async {
    Uri url = Uri.parse("https://admin.indera.id/public/api/app?app_id=1208&app_token=124177417") ;
    try{
      final response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 400) {
        AppModel appModel = AppModel.fromJson(json.decode(response.body));
        if(appModel.apiStatus==1){
          endPointUrl = appModel.url.toString();
          endPoint = appModel.url.toString() + "/api/";
          endPointLogin = appModel.url.toString() + "/api/";
          endPointPublic = appModel.url.toString() + "/";
          banner = appModel.photo.toString();
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

 Map<String, String>  buildHeader() {
    String secret = "c6bdff967c15b7ea1081bd0f0098fcc5";
    String unixtime = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    String useragent =  "Dart/3.3 (dart:io) / Idaman";
    // print("User-Agent : " + useragent);
    var bytes = utf8.encode(secret+unixtime+useragent);
    String token = md5.convert(bytes).toString();
    Map<String, String> requestHeaders = {
      'X-Authorization-Token': token,
      'X-Authorization-Time': unixtime,
      'User-Agent' : useragent
    };

    return requestHeaders;

  }

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse(endPointLogin + "siapkk") ;

    final response = await http.post(
        url,
        body: requestModel.toJson(),
        headers: buildHeader(),
    );

    if (response.statusCode == 200 || response.statusCode == 400) {

      LoginResponseModel lrm = LoginResponseModel.fromJson(
        json.decode(response.body),
      );
      print("kode kelurahan =" + lrm.toString());
      return lrm;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<int> berubah(LoginRequestModel requestModel) async {
    Uri url = Uri.parse(endPointLogin + "siapkk") ;

    final response = await http.post(
        url,
        body: requestModel.toJson(),
        headers: buildHeader(),
    );

    if (response.statusCode == 200 || response.statusCode == 400) {

      LoginResponseModel lrm = LoginResponseModel.fromJson(
        json.decode(response.body),
      );

      return lrm.apiStatus;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getSlider(String kategori) async {
    Uri url = Uri.parse(endPoint + "get_slider?aktif=1&kategori_id=${kategori}") ;

    PromoSlider.isApiCallProcess = true;
    try{
      final response = await http.get(
          url,
          headers: buildHeader(),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));

        if(it.api_status == 1) {
          List<SlideData> slides = [];
          for(var i = 0; i < it.data.length; i++) {
            // debugPrint(it.data[i].toString());
            slides.add(
                new SlideData(
                    id: it.data[i]["id"].toString(),
                    judul: it.data[i]["judul"].toString(),
                    photo: it.data[i]["photo"].toString()
                )
            );
          }
          return slides;
        }else{
          return it.api_message;
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getWilayah(String query) async {
    Uri url = Uri.parse(endPoint + query) ;
    PromoSlider.isApiCallProcess = true;
    try{
      final response = await http.get(
          url,
        headers: buildHeader(),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        if(it.api_status == 1) {
          List<WilayahModel> wilayah = [];
          for(var i = 0; i < it.data.length; i++) {
            wilayah.add(
                new WilayahModel(
                    id: it.data[i]["id"],
                    parent: it.data[i]["parent"].toString(),
                    name: it.data[i]["name"].toString()
                )
            );
          }
          return wilayah;
        }else{
          return it.api_message;
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getIcon(String utama, int limit) async {
    Uri url = Uri.parse(endPoint + "list_menu?utama=" + utama + "&limit=" + limit.toString() + "&kategori_id=") ;
    try {
      final response = await http.get(
          url,
        headers: buildHeader(),
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        if (it.api_status == 1) {
          List<ShortcutModel> shortcuts = [] ;
          for (var i = 0; i < it.data.length; i++) {
            shortcuts.add(
                new ShortcutModel(
                  id: it.data[i]["id"],
                  nama: it.data[i]["nama"].toString(),
                  icon: it.data[i]["icon"].toString(),
                  deskripsi: it.data[i]["deskripsi"].toString(),
                  aksi: it.data[i]["aksi"].toString(),
                  showText: it.data[i]["show_text"].toString(),
                  ortunya: it.data[i]["ortunya"],
                  utama: it.data[i]["utama"].toString(),
                  ortu: it.data[i]["ortu"].toString(),
                )
            );
          }
          return shortcuts;
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getIcon2(String utama, int limit, String kategori, String login_req) async {
    Uri url = Uri.parse(endPoint + "list_menu2?utama=" + utama + "&limit=" + limit.toString() + "&kategori_id=" + kategori + "&login_required=" + login_req) ;
    try {
      final response = await http.get(
          url,
        headers: buildHeader(),
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        // debugPrint(response.body);
        if (it.api_status == 1) {
          List<ShortcutModel> shortcuts = [] ;
          for (var i = 0; i < it.data.length; i++) {
            shortcuts.add(
                new ShortcutModel(
                  id: it.data[i]["id"],
                  nama: it.data[i]["nama"].toString(),
                  icon: it.data[i]["icon"].toString(),
                  deskripsi: it.data[i]["deskripsi"].toString(),
                  aksi: it.data[i]["aksi"].toString(),
                  showText: it.data[i]["show_text"].toString(),
                  ortunya: it.data[i]["ortunya"],
                  utama: it.data[i]["utama"].toString(),
                  ortu: it.data[i]["ortu"].toString(),
                )
            );
          }
          return shortcuts;
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future<ShortcutResponseModel> getIconByOrtu(String ortu) async {
    Uri url = Uri.parse(endPoint + "list_menu?ortu=" + ortu) ;

    final response = await http.get(
        url,
      headers: buildHeader(),
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return Future.delayed(Duration(seconds: 2), () =>  ShortcutResponseModel.fromJson(
          json.decode(response.body)
      )
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getUmkm(String query, String lat, String lon,int radius, int batas) async {
    Uri url = Uri.parse(endPoint + "get_usaha?id=1&user_lon=$lon&user_lat=$lat&radius=$radius&batas=$batas$query");
     // print(url.toString());
    // try {
      final response = await http.get(
          url,
        headers: buildHeader(),
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        // debugPrint(response.body);
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        // debugPrint(it.data.toString());
        if (it.api_status == 1) {
          // debugPrint(it.data.toString());
          List<Umkm> umkm = [];
          for (var i = 0; i < it.data.length; i++) {
            umkm.add(
              new Umkm(
                  id: int.parse(it.data[i]["id"]),
                  warga_bjb_id: it.data[i]["warga_bjb_id"],
                  nama_usaha: it.data[i]["nama_usaha"].toString(),
                  bidang_usaha: it.data[i]["bidang_usaha"].toString(),
                  sub_bidang_usaha: it.data[i]["sub_bidang_usaha"].toString(),
                  jenis_produk: it.data[i]["jenis_produk"].toString(),
                  brand: it.data[i]["brand"].toString(),
                  alamat_usaha: it.data[i]["alamat_usaha"].toString(),
                  province_id: it.data[i]["province_id"].toString(),
                  regency_id: it.data[i]["regency_id"].toString(),
                  district_id: it.data[i]["district_id"].toString(),
                  village_id: it.data[i]["village_id"].toString(),
                  lat: it.data[i]["lat"].toString(),
                  lon: it.data[i]["lon"].toString(),
                  photo: it.data[i]["photo"].toString(),
                  peta_icon: it.data[i]["peta_icon"].toString(),
                  provinsi: it.data[i]["provinsi"].toString(),
                  kabupaten: it.data[i]["kabupaten"].toString(),
                  kecamatan: it.data[i]["kecamatan"].toString(),
                  kelurahan: it.data[i]["kelurahan"].toString(),
                  jarak_km: double.parse(it.data[i]["jarak_km"].toString()),
                  numOfProduk: it.data[i]["numOfProduk"],
                  verified: it.data[i]["verified"].toString(),
                  nik: it.data[i]["nik"].toString(),
                  lokasi_id: it.data[i]["lokasi_id"].toString(),
                  keterangan: it.data[i]["keterangan"].toString(),
                  perizinan: it.data[i]["perizinan"].toString(),
                  aset_tetap: it.data[i]["aset_tetap"].toString().length > 0 ? double.parse(it.data[i]["aset_tetap"].toString()) : 0,
                  omset: double.parse(it.data[i]["omset"].toString()),
                  update_omset: it.data[i]["update_omset"].toString(),
                j_kary_p: int.parse(it.data[i]["j_kary_p"].toString()),
                j_kary_l: int.parse(it.data[i]["j_kary_l"].toString()),
              )
            );
          }
          return umkm;
        }else{
          debugPrint("lain satu");
        }
      } else {
        throw Exception('Failed to load data!');
      }
    // }catch (e){
    //   print(e.toString());
    // }
  }

  Future getBidang(String query) async {
    Uri url = Uri.parse(endPoint + "bidang" + query) ;
    try {
      final response = await http.get(
          url,
          headers: buildHeader()
    );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        if (it.api_status == 1) {
          List<BidangModel> bidang = [] ;
          for (var i = 0; i < it.data.length; i++) {
            bidang.add(
                new BidangModel(
                    id: it.data[i]["id"],
                    bidang: it.data[i]["bidang"].toString(),
                    icon: it.data[i]["icon"].toString(),
                    photo: it.data[i]["photo"].toString(),
                    banner: it.data[i]["banner"].toString(),
                    isChecked: false,

                )
            );
          }
          return bidang;
        }else{
          debugPrint("lain satu");
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getKategoriProduk() async {
    Uri url = Uri.parse(endPoint + "kategori_produk") ;
    try {
      final response = await http.get(
          url,
        headers: buildHeader(),
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        if (it.api_status == 1) {
          List<KategoriModel> kategori_produk = [] ;
          for (var i = 0; i < it.data.length; i++) {
           // print(it.data[i]["nama_kategori"]);
            kategori_produk.add(
                new KategoriModel(
                  id: it.data[i]["id"],
                  nama_kategori: it.data[i]["nama_kategori"].toString(),
                  icon: it.data[i]["icon"].toString(),
                  photo: it.data[i]["photo"].toString(),
                  banner: it.data[i]["banner"].toString(),
                  hits: it.data[i]["hits"],
                  numOfProduk: it.data[i]["numOfProduk"]
                )
            );
          }
          return kategori_produk;
        }else{
          debugPrint("lain satu");
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getBerat() async {
    Uri url = Uri.parse(endPoint + "list_berat") ;
    try {
      final response = await http.get(
          url,
        headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        if (it.api_status == 1) {
          List<BeratModel> berat = [] ;
          for (var i = 0; i < it.data.length; i++) {
            berat.add(
                new BeratModel(
                  id: it.data[i]["id"],
                  simbol: it.data[i]["simbol"].toString(),
                  nama_berat: it.data[i]["nama_berat"].toString(),
                  konversi: double.parse(it.data[i]["konversi"])

                )
            );
          }
          return berat;
        }else{
          debugPrint("lain satu");
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getPasar() async {
    Uri url = Uri.parse(endPoint + "lokasi?kategori_lokasi_id=34") ;

    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        // debugPrint(response.body);
        if (it.api_status == 1) {
          List<PasarModel> pasar = [] ;
          for (var i = 0; i < it.data.length; i++) {
            pasar.add(
                new PasarModel(
                    id: it.data[i]["id"].toString(),
                    nama: it.data[i]["nama"].toString(),
                    kategori_lokasi_id: it.data[i]["kategori_lokasi_id"].toString(),
                    lat: it.data[i]["lat"].toString(),
                    lon: it.data[i]["lon"].toString(),
                    alamat: it.data[i]["jalan"].toString(),
                    gambar_utama: it.data[i]["gambar_utama"].toString(),
                    numOfProduk: it.data[i]["numOfProduk"]
                )
            );
          }
          return pasar;
        }else{
          debugPrint("lain satu");
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future<LokasiModel> getLokasi(String kategori) async {
    // print(idWarga);
    Uri url = Uri.parse(endPoint + "lokasi?kategori_lokasi_id=" + kategori) ;
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      LokasiModel it = LokasiModel.fromJson(json.decode(response.body));
      return it;
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future findProduk(String query, int page, int limit) async {
    Uri url = Uri.parse(endPoint + "produk?$query&offset=${(page-1)*limit}&limit=$limit") ;
    // debugPrint(url.toString());
    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));

        if (it.api_status == 1) {
          List<Product> produk = [] ;
          for (var i = 0; i < it.data.length; i++) {
            //debugPrint(it.data[i]["photo"].toString());
            //List<String> photoList = convertStringArray(it.data[i]["photo"]);
            // debugPrint(" Banyaknya : " + it.data[i]["nama_produk_jasa"].toString());
            List<PhotoModel> photos = [];
            for(Map<String, dynamic> photo in it.data[i]["photo"]) {
              // debugPrint(photo.toString());
              // PhotoModel pn = new PhotoModel.fromMap(photo);
              // debugPrint(pn.toJson());
                photos.add(PhotoModel.fromMap(photo));
            }
            //List<Color> colors = convertColorArray(it.data[i]["colors"]);
            produk.add(
                new Product(
                  id: int.parse(it.data[i]["id"].toString()),
                  title: it.data[i]["nama_produk_jasa"].toString(),
                    umkm_usaha_id: int.parse(it.data[i]["umkm_usaha_id"].toString()),
                  price: double.parse(it.data[i]["harga"].toString()),
                  berat: double.parse(it.data[i]["berat"].toString()),
                  satuan_berat: it.data[i]["satuan_berat"].toString(),
                  description: it.data[i]["deskripsi_singkat"].toString(),
                    longDesc: it.data[i]["deskripsi_produk"].toString(),
                  rating: double.parse(it.data[i]["rating"].toString()),
                  isFavourite: int.parse(it.data[i]["isFavorite"].toString()),
                  isPopular: it.data[i]["isPopular"] == true,
                  colors: new List<Color>.empty() ,
                  images: photos,
                  lokasi: it.data[i]["lokasi"].toString(),
                  jarak: double.parse(it.data[i]["jarak"].toString()),
                    usaha: it.data[i]["usaha"].toString(),
                    nik: it.data[i]["nik"].toString(),
                    kategori_produk_id: int.parse(it.data[i]["kategori_produk_id"].toString()),
                    satuan_berat_id: int.parse(it.data[i]["satuan_berat_id"].toString()),
                    status_produk: int.parse(it.data[i]["status_produk"].toString()),
                  verified: it.data[i]["verified"].toString(),
                )
            );
          }

          return produk;
        }else{
          debugPrint("lain satu");
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getNotif(String nik,String status, int offset, int limit) async {
    Uri url = Uri.parse(endPoint + "ambil_notif?nik=${nik}&status=${status}&offset=${offset}&limit=${limit}") ;
    //debugPrint("notif baru : " +  url.toString());
    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        NotifikasiModel it = NotifikasiModel.fromJson(json.decode(response.body));

        if (it.apiStatus == 1) {
          //print("notif baru : " + it.toJson().toString());
          return it;
        }else{
          debugPrint("lain satu");
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }
  
  convertStringArray(List<dynamic> string){
    List<String> list = [];
    for(var item in string){

      list.add(item);
    }
    return list;
  }

  convertColorArray(List<dynamic> string){
    List<Color> list = [];

    for(var item in string){
      String color = item.toString();
      String valueString = color.split('(0x')[1].split(')')[0];
      int value = int.parse(valueString,radix: 16);
      list.add(new Color(value));
    }
    return list;
  }

  Future getListChat(String userId) async {
    Uri url = Uri.parse(endPoint + "list_chats?user_id=" + userId);
    List<ChatDataModel> chats = [];
    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));

        if(it.api_status == 1) {
          for(var i = 0; i < it.data.length; i++) {
              // print(it.data[i].toString());
            chats.add(
                new ChatDataModel(
                    nama_table: it.data[i]["nama_table"].toString(),
                    key_id: it.data[i]["key_id"].toString(),
                    user_id: userId,
                    detail: it.data[i]["detail"]
                )
            );

          }
        }else{
          return it.api_message;
        }
      } else {
        throw Exception('Failed to load data!');
      }
      return chats;
    }catch (e){
      print(e.toString());
    }
  }

  Future getKomentar(String userId, String keyId, String namaTable) async {
    //print(endPoint + "komentar2?key_id="+ keyId + "&nama_table=" + namaTable + "&req_by=" + userId);
    Uri url = Uri.parse(endPoint + "komentar2?key_id="+ keyId + "&nama_table=" + namaTable + "&req_by=" + userId);

    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));

        if(it.api_status == 1) {
          List<KomentarDataModel> komentar = [];
          //komentar = it.data.map<KomentarDataModel>((json) => KomentarDataModel.fromJson(json)).toList();
           for(var i = 0; i < it.data.length; i++) {
             //print(it.data[i]);
             komentar.add(
                 new KomentarDataModel(
                   id: it.data[i]["id"].toString(),
                   nama_table: it.data[i]["nama_table"].toString(),
                   key_id: it.data[i]["key_id"].toString(),
                   user_id: it.data[i]["user_id"].toString(),
                   isi: it.data[i]["isi"].toString(),
                   gambar: it.data[i]["gambar"].toString(),
                   jenis_gambar: it.data[i]["jenis_gambar"].toString(),
                   created_at: it.data[i]["created_at"].toString(),
                   is_read: it.data[i]["is_read"].toString(),
                   nama: it.data[i]["nama"].toString(),
                   photo: it.data[i]["photo"].toString(),
                   jpenyuka: it.data[i]["jpenyuka"].toString(),
                   ilike: it.data[i]["ilike"].toString(),
                   isSender: it.data[i]["isSender"].toString()
                 )
             );
           }

            // );
          return komentar;
        }else{
          return it.api_message;
        }
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future<ResponseModel> sendKomentar(KomentarRequestModel requestModel) async {
    Uri url = Uri.parse(endPoint + "add_komentar") ;

    final response = await http.post(
        url,
        body: requestModel.toJson(),
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      // print(response.body);
      return ResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<PostResponseModel> addKeranjang(KeranjangPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "add_keranjang") ;

    final response = await http.post(
        url,
        body: postModel.toJson(),
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      return PostResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<StatsResposeModel> getStats() async {
    Uri url = Uri.parse(endPoint + "laporan_umkm") ;
    TokenPostModel tpm = new TokenPostModel(app_id: "7656", app_token: "123456");
    final response = await http.post(
        url,
        body: tpm.toJson(),
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return StatsResposeModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future getKeranjang(String userId, String user_lat, String user_lon) async {
    DateTime now = DateTime.now();
    Uri url = Uri.parse("${endPoint}keranjang?cms_users_id=$userId&user_lat=$user_lat&user_lon=$user_lon&waktu="+ DateFormat('yyyy-MM-dd  kk:mm').format(now));
    print(url.toString());
    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        //print(json.decode(response.body));
        KeranjangResponseModel it = KeranjangResponseModel.fromJson(json.decode(response.body));

        return it;
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }
  }

  Future getKeranjangCount(String userId) async {
    DateTime now = DateTime.now();
    Uri url = Uri.parse("${endPoint}keranjang_count?cms_users_id=$userId");
    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        // print(endPoint +" keranjang count " + response.body.toString());
        KeranjangCountModel it = KeranjangCountModel.fromJson(json.decode(response.body));
        return it;
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString() + "wduuu");
    }
  }

  Future<int> delKeranjang(String id) async {
    //print(endPoint + "keranjang?cms_users_id="+ userId);
    Uri url = Uri.parse(endPoint + "del_keranjang?id="+ id);

    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        DelResponseModel it = DelResponseModel.fromJson(json.decode(response.body));
        // print(it.toString());
        return it.api_status;
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
      return 0;
    }
  }

  Future<PostResponseModel> addTansaksi(TransaksiPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "add_transaksi") ;
    // print(postModel.total_harga);
    final response = await http.post(
        url,
        body: postModel.toJson(),
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return PostResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response.body);
      throw Exception('Failed to send data!');
    }
  }

  Future getTransakasiByUser(String userId) async {
    DateTime now = DateTime.now();
    Uri url = Uri.parse("${endPoint}get_transaksi?pembeli_id=$userId");
    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(endPoint +" transaksi saya " + response.body.toString());
        TransaksiModel it = TransaksiModel.fromJson(json.decode(response.body));
        return it.data;
      } else {
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString() + "wduuu");
    }
  }

  Future<PostResponseModel> sukai(String namaTable, String reaksi, String keyId) async {
    ReaksiPostModel postModel = new ReaksiPostModel(
        userId: MyApp.localStorage.get("id").toString(),
        namaTable: namaTable,
        keyId: keyId,
        masterReaksiId: reaksi
    );
    Uri url = Uri.parse(endPoint + "sukai") ;
    final response = await http.post(
        url,
        body: postModel.toJson(),
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return PostResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PostResponseModel> addUsaha(UsahaPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "add_usaha") ;
    // print(postModel.toJson());
    http.MultipartRequest mpr = http.MultipartRequest(
        "POST",
        url
    );
    mpr.headers.addAll(buildHeader());
    //print(MyApp.localStorage.get("nik").toString());
    mpr.fields["warga_bjb_id"] = MyApp.localStorage.get("nik").toString();
    //jangan lupa di interceot di api nya ubah nik jadi id
    mpr.fields["nama_usaha"] = postModel.nama_usaha;
    mpr.fields["bidang_usaha"] = postModel.bidang_usaha;
    mpr.fields["sub_bidang_usaha"] = postModel.sub_bidang_usaha;
    mpr.fields["alamat_usaha"] = postModel.alamat_usaha;
    mpr.fields["province_id"] = postModel.province_id;
    mpr.fields["regency_id"] = postModel.regency_id;
    mpr.fields["district_id"] = postModel.district_id;
    mpr.fields["village_id"] = postModel.village_id;
    mpr.fields["lat"] = postModel.lat;
    mpr.fields["lon"] = postModel.lon;
    mpr.fields["updated_by"] = postModel.updated_by;
    mpr.fields["keterangan"] = postModel.keterangan;
    mpr.fields["lokasi_id"] = postModel.lokasi_id;
    if(postModel.photo.isNotEmpty) {
      mpr.files.add(await http.MultipartFile.fromPath(
          'photo',
          postModel.photo)
      );
    }

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);
      // print(responseData);
      return PostResponseModel.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PostResponseModelNoId> updateUsaha(UsahaPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "update_usaha") ;
    //print(postModel.catatan);
    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["id"] = postModel.id;
    if(postModel.nama_usaha.isNotEmpty)
    mpr.fields["nama_usaha"] = postModel.nama_usaha;
    if(postModel.bidang_usaha.isNotEmpty)
    mpr.fields["bidang_usaha"] = postModel.bidang_usaha;
    if(postModel.sub_bidang_usaha.isNotEmpty)
    mpr.fields["sub_bidang_usaha"] = postModel.sub_bidang_usaha;
    if(postModel.alamat_usaha.isNotEmpty)
    mpr.fields["alamat_usaha"] = postModel.alamat_usaha;
    if(postModel.province_id.isNotEmpty)
    mpr.fields["province_id"] = postModel.province_id;
    if(postModel.regency_id.isNotEmpty)
    mpr.fields["regency_id"] = postModel.regency_id;
    if(postModel.district_id.isNotEmpty)
    mpr.fields["district_id"] = postModel.district_id;
    if(postModel.village_id.isNotEmpty)
    mpr.fields["village_id"] = postModel.village_id;
    if(postModel.lat.isNotEmpty)
    mpr.fields["lat"] = postModel.lat;
    if(postModel.lon.isNotEmpty)
    mpr.fields["lon"] = postModel.lon;

    mpr.fields["updated_by"] = postModel.updated_by;
    if(postModel.keterangan.isNotEmpty)
    mpr.fields["keterangan"] = postModel.keterangan;
    if(postModel.aset_tetap.isNotEmpty)
      mpr.fields["aset_tetap"] = postModel.aset_tetap;
    if(postModel.omset.isNotEmpty)
      mpr.fields["omset"] = postModel.omset;
    if(postModel.j_kary_l.isNotEmpty)
      mpr.fields["j_kary_l"] = postModel.j_kary_l;
    if(postModel.j_kary_p.isNotEmpty)
      mpr.fields["j_kary_p"] = postModel.j_kary_p;
    if(postModel.update_omset.isNotEmpty)
      mpr.fields["update_omset"] = postModel.update_omset;
    if(postModel.lokasi_id.isNotEmpty)
      mpr.fields["lokasi_id"] = postModel.lokasi_id;
    if(postModel.photo.isNotEmpty) {
      mpr.files.add(await http.MultipartFile.fromPath(
          'photo',
          postModel.photo)
      );
    }

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return PostResponseModelNoId.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<ResponseModel> deleteUsaha(String id, String wargaId) async {
    Uri url = Uri.parse(endPoint + "del_usaha_saya?id=" + id + "&warga_bjb_id=" + wargaId);
      final response = await http.get(
          url,
          headers: buildHeader()
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
        print(response.body);
        return it;
      } else {
        throw Exception('Failed to load data!');
      }

  }

  Future<PostResponseModel> addProduk(ProdukPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "add_produk") ;
    //print(postModel.nama_usaha);
    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["nama_produk_jasa"] = postModel.nama_produk_jasa;
    mpr.fields["harga"] = postModel.harga;
    mpr.fields["umkm_usaha_id"] = postModel.umkm_usaha_id;
    mpr.fields["deskripsi_singkat"] = postModel.deskripsi_singkat;
    mpr.fields["deskripsi_produk"] = postModel.deskripsi_produk;
    mpr.fields["berat"] = postModel.berat;
    mpr.fields["satuan_berat"] = postModel.satuan_berat;
    mpr.fields["kategori_produk_id"] = postModel.kategori_produk_id;
    mpr.fields["status_produk"] = postModel.status_produk;
    if(postModel.diskon.isNotEmpty)
      mpr.fields["diskon"] = postModel.diskon;
    mpr.fields["updated_by"] = postModel.updated_by;

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);
      // print(responseData);
      return PostResponseModel.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PostResponseModelNoId> updateProduk(ProdukPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "update_produk") ;
    //print(postModel.catatan);
    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["id"] = postModel.id;
    if(postModel.nama_produk_jasa.isNotEmpty)
      mpr.fields["nama_produk_jasa"] = postModel.nama_produk_jasa;
    if(postModel.harga.isNotEmpty)
      mpr.fields["harga"] = postModel.harga;
    if(postModel.mata_uang_id.isNotEmpty)
      mpr.fields["mata_uang_id"] = postModel.mata_uang_id;
    if(postModel.umkm_usaha_id.isNotEmpty)
      mpr.fields["umkm_usaha_id"] = postModel.umkm_usaha_id;
    if(postModel.lokasi_id.isNotEmpty)
      mpr.fields["lokasi_id"] = postModel.lokasi_id;
    if(postModel.deskripsi_singkat.isNotEmpty)
      mpr.fields["deskripsi_singkat"] = postModel.deskripsi_singkat;
    if(postModel.deskripsi_produk.isNotEmpty)
      mpr.fields["deskripsi_produk"] = postModel.deskripsi_produk;
    if(postModel.berat.isNotEmpty)
      mpr.fields["berat"] = postModel.berat;
    if(postModel.satuan_berat.isNotEmpty)
      mpr.fields["satuan_berat"] = postModel.satuan_berat;
    if(postModel.kategori_produk_id.isNotEmpty)
      mpr.fields["kategori_produk_id"] = postModel.kategori_produk_id;
    // if(postModel.status_produk.isNotEmpty)
    //   mpr.fields["status_produk"] = postModel.status_produk;
    if(postModel.diskon.isNotEmpty)
      mpr.fields["diskon"] = postModel.diskon;
    if(postModel.etalase_id.isNotEmpty)
      mpr.fields["etalase_id"] = postModel.etalase_id;

    mpr.fields["updated_by"] = postModel.updated_by;

    // if(postModel.photo.isNotEmpty) {
    //   mpr.files.add(await http.MultipartFile.fromPath(
    //       'photo',
    //       postModel.photo)
    //   );
    // }

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      print(responseData);
      return PostResponseModelNoId.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PostResponseModel> uploadProdukImage(ProdukImagePostModel postModel) async {
    Uri url = Uri.parse(endPoint + "upload_produk_image") ;
    //print(postModel.catatan);
    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["produk_id"] = postModel.parent_id;
    if(postModel.parent.isNotEmpty)
      mpr.fields["parent"] = postModel.parent;
    if(postModel.utama.isNotEmpty)
      mpr.fields["utama"] = postModel.utama;

      mpr.files.add(await http.MultipartFile.fromPath(
          'file',
          postModel.file)
      );

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return PostResponseModel.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<ResponseModel> deleteProduk(String id) async {
    Uri url = Uri.parse(endPoint + "delete_produk?id=" + id );
    final response = await http.get(
        url,
        headers: buildHeader()
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
      print(response.body);
      return it;
    } else {
      throw Exception('Failed to load data!');
    }

  }

  Future<int> deleteProdukImage(String id) async {
    print(id);
    Uri url = Uri.parse(endPoint + "del_produk_image?id=" + id );
    final response = await http.get(
        url,
        headers: buildHeader()
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
      print(response.body);
      if(it.api_status==1) {
        return 1;
      }else{
        return 0;
      }
    } else {
      throw Exception('Failed to load data!');
    }

  }

  Future<PostResponseModel> registrasiV2(RegisterPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "registrasiv2") ;
    //print(postModel.catatan);
    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["nik"] = postModel.nik;
    mpr.fields["nama_lgkp"] = postModel.nama_lgkp;
    mpr.fields["no_telp"] = postModel.no_telp;
    mpr.fields["password"] = postModel.password;

    if(postModel.file_ktp.isNotEmpty)
      mpr.files.add(await http.MultipartFile.fromPath(
          'file_ktp',
          postModel.file_ktp)
      );

    // mpr.files.add(await http.MultipartFile.fromPath(
    //     'file_selfie',
    //     postModel.file_selfie)
    // );

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return PostResponseModel.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  // Future<ResponseModel> registerV2(String nik, String nama_lgkp, String no_telp) async {
  //
  //   Uri url = Uri.parse(endPoint + "register_v2?nik="+ nik + "&nama_lgkp=" + nama_lgkp + "&no_telp=" + no_telp);
  //
  //   try {
  //     final response = await http.get(url);
  //     print(json.decode(response.body));
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       ResponseModel it = ResponseModel.fromJson(json.decode(response.body));
  //
  //       return it;
  //
  //     } else {
  //
  //       return ResponseModel(api_status: 0, api_message: "request failed !", api_authorization: "", data: []);
  //       throw Exception('Failed to load data!');
  //     }
  //   }catch (e){
  //     print(e.toString());
  //   }
  //
  //   return ResponseModel(api_status: 0, api_message: "request gagal !", api_authorization: "", data: []);
  // }

  Future<ResponseModel> sendOtp(String nik, String no_telp, String nama_lgkp,String password, String otp) async {

    Uri url = Uri.parse(endPoint + "send_otp?nik="+ nik + "&no_telp=" + no_telp + "&nama_lgkp=" + nama_lgkp + "&password=" + password  + "&otp=" + otp);

    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      // print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel it = ResponseModel.fromJson(json.decode(response.body));

        return it;

      } else {

        return ResponseModel(api_status: 0, api_message: "request failed !",  data: []);
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }

    return ResponseModel(api_status: 1, api_message: "request pass !", data: []);
  }

  Future<ProfilPostResponseModel> updateProfil(ProfilPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "update_profil_user") ;
    //print(postModel.catatan);
    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["id"] = postModel.id;
    if(postModel.display_name.isNotEmpty)
      mpr.fields["display_name"] = postModel.display_name;
    if(postModel.email.isNotEmpty)
      mpr.fields["email"] = postModel.email;
    if(postModel.photo.isNotEmpty) {
      mpr.files.add(await http.MultipartFile.fromPath(
          'photo',
          postModel.photo)
      );
    }
    if(postModel.icon.isNotEmpty) {
      mpr.files.add(await http.MultipartFile.fromPath(
          'icon',
          postModel.icon)
      );
    }
    if(postModel.spesimen_tte.isNotEmpty) {
      mpr.files.add(await http.MultipartFile.fromPath(
          'spesimen_tte',
          postModel.spesimen_tte)
      );
    }

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return ProfilPostResponseModel.fromJson(responseData);
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<SingleResponseModel> cekNik(String nik) async {

    Uri url = Uri.parse(endPoint + "cek_nik?nik="+ nik );

    try {
      final response = await http.get(
          url,
          headers: buildHeader()
      );
      // print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        SingleResponseModel it = SingleResponseModel.fromJson(json.decode(response.body));

        return it;

      } else {

        return SingleResponseModel(api_status: 0, api_message: "request gagal !", id: "", value: "");
        throw Exception('Failed to load data!');
      }
    }catch (e){
      print(e.toString());
    }

    return SingleResponseModel(api_status: 0, api_message: "request failed !", id: "", value: "");;
  }

  Future<PostResponseModelNoId> updateDataDiri(DataDiriPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "update_warga") ;
    // print(postModel.toJson());
    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["id"] = postModel.id;
    if(postModel.nama_lgkp.isNotEmpty)
      mpr.fields["nama_lgkp"] = postModel.nama_lgkp;
    if(postModel.jk.isNotEmpty)
      mpr.fields["jk"] = postModel.jk;
    if(postModel.tmpt_lhr.isNotEmpty)
      mpr.fields["tmpt_lhr"] = postModel.tmpt_lhr;
    if(postModel.tgl_lhr.isNotEmpty)
      mpr.fields["tgl_lhr"] = postModel.tgl_lhr;
    if(postModel.pddk_akhir_id.isNotEmpty)
      mpr.fields["pddk_akhir_id"] = postModel.pddk_akhir_id;
    if(postModel.pekerjaan_id.isNotEmpty)
      mpr.fields["pekerjaan_id"] = postModel.pekerjaan_id;
    if(postModel.alamat2.isNotEmpty)
      mpr.fields["alamat2"] = postModel.alamat2;
    if(postModel.rt.isNotEmpty)
      mpr.fields["rt"] = postModel.rt;
    if(postModel.rw.isNotEmpty)
      mpr.fields["rw"] = postModel.rw;
    if(postModel.nama_prop.isNotEmpty)
      mpr.fields["nama_prop"] = postModel.nama_prop;
    if(postModel.nama_kab.isNotEmpty)
      mpr.fields["nama_kab"] = postModel.nama_kab;
    if(postModel.nama_kec.isNotEmpty)
      mpr.fields["nama_kec"] = postModel.nama_kec;
    if(postModel.nama_kel.isNotEmpty)
      mpr.fields["nama_kel"] = postModel.nama_kel;
    if(postModel.no_kk.isNotEmpty)
      mpr.fields["no_kk"] = postModel.no_kk;
    mpr.fields["updated_by"] = postModel.updated_by;


    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return PostResponseModelNoId.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<DataDiriModel> getWarga(String idWarga) async {
    // print(idWarga);
    Uri url = Uri.parse(endPoint + "get_warga?id=" + idWarga) ;
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      DataDiriModel it = DataDiriModel.fromJson(response.body);
      return it;
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PelatihanModel> listPelatihan(String query, int page, int limit) async {
    Uri url = Uri.parse(endPoint + "list_pelatihan?$query&offset=${(page-1)*limit}&limit=$limit");
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      PelatihanModel it = PelatihanModel.fromJson(jsonDecode(response.body));
      return it;
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<BantuanModel> listBantuan(String query, int page, int limit) async {
    Uri url = Uri.parse(endPoint + "list_bantuan?$query&offset=${(page-1)*limit}&limit=$limit");
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      BantuanModel it = BantuanModel.fromJson(jsonDecode(response.body));
      return it;
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<KategoriLokasiModel> getKategoriLokasi() async {
    Uri url = Uri.parse(endPoint + "list_kategori?aktif=1");
    final response = await http.get(
        url,
        headers: buildHeader()
    );
   // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      KategoriLokasiModel it = KategoriLokasiModel.fromJson(jsonDecode(response.body));
      print(jsonEncode(it.data).toString());
      return it;
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PostResponseModel> addAspirasi(AspirasiPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "add_aspirasi") ;

    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    if(postModel.cms_user_id.isNotEmpty)
      mpr.fields["cms_user_id"] = postModel.cms_user_id;
    if(postModel.privilege_tujuan.isNotEmpty)
      mpr.fields["privilege_tujuan"] = postModel.privilege_tujuan;
    if(postModel.judul.isNotEmpty)
      mpr.fields["judul"] = postModel.judul;
    if(postModel.isi.isNotEmpty)
      mpr.fields["isi"] = postModel.isi;

    if(postModel.gambar.isNotEmpty)
    mpr.files.add(await http.MultipartFile.fromPath(
        'gambar',
        postModel.gambar)
    );

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return PostResponseModel.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PostResponseModel> daftarPelatihan(PelatihanPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "daftar_pelatihan") ;

    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["cms_user_id"] = postModel.cms_user_id;
    mpr.fields["pelatihan_id"] = postModel.pelatihan_id;
    mpr.fields["umkm_usaha_id"] = postModel.umkm_usaha_id;

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return PostResponseModel.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<PostResponseModel> daftarBantuan(BantuanPostModel postModel) async {
    Uri url = Uri.parse(endPoint + "daftar_bantuan") ;

    http.MultipartRequest mpr = http.MultipartRequest("POST",url);
    mpr.headers.addAll(buildHeader());
    mpr.fields["cms_user_id"] = postModel.cms_user_id;
    mpr.fields["bantuan_id"] = postModel.bantuan_id;
    mpr.fields["umkm_usaha_id"] = postModel.umkm_usaha_id;

    final response = await mpr.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      // print(responseData);
      return PostResponseModel.fromJson(
        json.decode(responsed.body),
      );
    } else {
      throw Exception('Failed to send data!');
    }
  }

  Future<int> deleteAccount() async {
    Uri url = Uri.parse(endPoint + "hapus_akun?id=${MyApp.localStorage.getString("id")}&nik=${MyApp.localStorage.getString("nik")}&password=${MyApp.localStorage.getString("password")}&no_telp=${MyApp.localStorage.getString("telp")}") ;
    try{
      final response = await http.get(
          url,
          headers: buildHeader()
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        ResponseModel resp = ResponseModel.fromJson(json.decode(response.body));
        print(resp.api_message);
        return resp.api_status;
      } else {
        return 0;
      }
    }catch (e){
      print(e.toString());
    }
    return 0;
  }

  Future getAllHomecare() async {
    Uri url = Uri.parse(endPoint + "get_homecare");
    //print(url.toString());
    // try {
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      Homecare it = Homecare.fromJson(json.decode(response.body));
      if (it.apiStatus == 1) {
        return it.data;
      }else{
        return [];
      }
    } else {
      throw Exception('Failed to load data!');
    }
    // }catch (e){
    //   print(e.toString());
    // }
  }

  Future getHomecare(String status) async {
    Uri url = Uri.parse(endPoint + "get_homecare?nik="+MyApp.localStorage.getString("nik").toString()+"&status="+status);
    //print(url.toString());
    // try {
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      Homecare it = Homecare.fromJson(json.decode(response.body));
      if (it.apiStatus == 1) {
        //debugPrint(it.data![0]?.nik);
        return it.data;
      }else{
        return null;
      }
    } else {
      throw Exception('Failed to load data!');
    }
    // }catch (e){
    //   print(e.toString());
    // }
  }

  Future getHomecareMedia(int page, int limit) async {
    Uri url = Uri.parse(endPoint + "homecare_media?status=open&offset=${(page-1)*limit}&limit=$limit");
    //print(url.toString());
    // try {
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      HomecareMedia it = HomecareMedia.fromJson(json.decode(response.body));
      if (it.apiStatus == 1) {
        return it.data;
      }else{
        return [];
      }
    } else {
      throw Exception('Failed to load data!');
    }
    // }catch (e){
    //   print(e.toString());
    // }
  }

  Future getLayananKeluranan(String villageId) async {
    Uri url = Uri.parse(endPoint + "get_layanan?village_id=" + villageId);

    // try {
    final response = await http.get(
        url,
        headers: buildHeader()
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      LayananModel it = LayananModel.fromJson(json.decode(response.body));
      if (it.apiStatus == 1) {
        return it.data;
      }else{
        return [];
      }
    } else {
      throw Exception('Failed to load data!');
    }
    // }catch (e){
    //   print(e.toString());
    // }
  }
}