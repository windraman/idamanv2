class ProdukModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  ProdukModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  ProdukModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiMessage = json['api_message'];
    apiAuthorization = json['api_authorization'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_message'] = this.apiMessage;
    data['api_authorization'] = this.apiAuthorization;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? namaProdukJasa;
  String? harga;
  String? mataUangId;
  String? umkmUsahaId;
  String? lokasiId;
  String? deskripsiSingkat;
  String? deskripsiProduk;
  String? berat;
  String? satuanBerat;
  String? kategoriProdukId;
  String? statusProduk;
  Null etalaseId;
  String? hits;
  String? updatedBy;
  List<Photo>? photo;
  int? rating;
  int? isFavorite;
  bool? isPopular;
  List<String>? colors;
  String? satuanBeratId;
  String? lokasi;
  String? usaha;
  double? jarak;
  String? lat;
  String? lon;
  String? nik;
  String? kategori;
  String? kategoriIcon;
  String? verified;

  Data(
      {this.id,
        this.namaProdukJasa,
        this.harga,
        this.mataUangId,
        this.umkmUsahaId,
        this.lokasiId,
        this.deskripsiSingkat,
        this.deskripsiProduk,
        this.berat,
        this.satuanBerat,
        this.kategoriProdukId,
        this.statusProduk,
        this.etalaseId,
        this.hits,
        this.updatedBy,
        this.photo,
        this.rating,
        this.isFavorite,
        this.isPopular,
        this.colors,
        this.satuanBeratId,
        this.lokasi,
        this.usaha,
        this.jarak,
        this.lat,
        this.lon,
        this.nik,
        this.kategori,
        this.kategoriIcon,
        this.verified
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaProdukJasa = json['nama_produk_jasa'];
    harga = json['harga'];
    mataUangId = json['mata_uang_id'];
    umkmUsahaId = json['umkm_usaha_id'];
    lokasiId = json['lokasi_id'];
    deskripsiSingkat = json['deskripsi_singkat'];
    deskripsiProduk = json['deskripsi_produk'];
    berat = json['berat'];
    satuanBerat = json['satuan_berat'];
    kategoriProdukId = json['kategori_produk_id'];
    statusProduk = json['status_produk'];
    etalaseId = json['etalase_id'];
    hits = json['hits'];
    updatedBy = json['updated_by'];
    if (json['photo'] != null) {
      photo = <Photo>[];
      json['photo'].forEach((v) {
        photo!.add(new Photo.fromJson(v));
      });
    }
    rating = json['rating'];
    isFavorite = json['isFavorite'];
    isPopular = json['isPopular'];
    colors = json['colors'].cast<String>();
    satuanBeratId = json['satuan_berat_id'];
    lokasi = json['lokasi'];
    usaha = json['usaha'];
    jarak = json['jarak'];
    lat = json['lat'];
    lon = json['lon'];
    nik = json['nik'];
    kategori = json['kategori'];
    kategoriIcon = json['kategori_icon'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_produk_jasa'] = this.namaProdukJasa;
    data['harga'] = this.harga;
    data['mata_uang_id'] = this.mataUangId;
    data['umkm_usaha_id'] = this.umkmUsahaId;
    data['lokasi_id'] = this.lokasiId;
    data['deskripsi_singkat'] = this.deskripsiSingkat;
    data['deskripsi_produk'] = this.deskripsiProduk;
    data['berat'] = this.berat;
    data['satuan_berat'] = this.satuanBerat;
    data['kategori_produk_id'] = this.kategoriProdukId;
    data['status_produk'] = this.statusProduk;
    data['etalase_id'] = this.etalaseId;
    data['hits'] = this.hits;
    data['updated_by'] = this.updatedBy;
    if (this.photo != null) {
      data['photo'] = this.photo!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['isFavorite'] = this.isFavorite;
    data['isPopular'] = this.isPopular;
    data['colors'] = this.colors;
    data['satuan_berat_id'] = this.satuanBeratId;
    data['lokasi'] = this.lokasi;
    data['usaha'] = this.usaha;
    data['jarak'] = this.jarak;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['nik'] = this.nik;
    data['kategori'] = this.kategori;
    data['kategori_icon'] = this.kategoriIcon;
    data['verified'] = this.verified;
    return data;
  }
}

class Photo {
  String? id;
  String? produkId;
  String? file;
  String? parent;
  String? utama;
  String? createdAt;

  Photo(
      {this.id,
        this.produkId,
        this.file,
        this.parent,
        this.utama,
        this.createdAt});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produkId = json['produk_id'];
    file = json['file'];
    parent = json['parent'];
    utama = json['utama'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produk_id'] = this.produkId;
    data['file'] = this.file;
    data['parent'] = this.parent;
    data['utama'] = this.utama;
    data['created_at'] = this.createdAt;
    return data;
  }
}
