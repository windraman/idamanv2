class LokasiModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  LokasiModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  LokasiModel.fromJson(Map<String, dynamic> json) {
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
  String? kategoriLokasiId;
  String? lat;
  String? lon;
  String? nama;
  Null icon;
  Null nomor;
  String? jalan;
  String? regencyId;
  String? districtId;
  String? villageId;
  Null kodePos;
  Null telepon;
  Null website;
  Null email;
  Null aksesInternet;
  String? selaluBuka;
  Null hariBuka;
  Null media;
  Null createdBy;
  String? updatedBy;
  String? kategori;
  String? tags;
  String? kecamatan;
  String? kelurahan;
  String? gambarUtama;
  String? provinceId;
  List<Gambar>? gambar;
  List<Produk>? produk;
  int? numOfProduk;

  Data(
      {this.id,
        this.kategoriLokasiId,
        this.lat,
        this.lon,
        this.nama,
        this.icon,
        this.nomor,
        this.jalan,
        this.regencyId,
        this.districtId,
        this.villageId,
        this.kodePos,
        this.telepon,
        this.website,
        this.email,
        this.aksesInternet,
        this.selaluBuka,
        this.hariBuka,
        this.media,
        this.createdBy,
        this.updatedBy,
        this.kategori,
        this.tags,
        this.kecamatan,
        this.kelurahan,
        this.gambarUtama,
        this.provinceId,
        this.gambar,
        this.produk,
        this.numOfProduk});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategoriLokasiId = json['kategori_lokasi_id'];
    lat = json['lat'];
    lon = json['lon'];
    nama = json['nama'];
    icon = json['icon'];
    nomor = json['nomor'];
    jalan = json['jalan'];
    regencyId = json['regency_id'];
    districtId = json['district_id'];
    villageId = json['village_id'];
    kodePos = json['kode_pos'];
    telepon = json['telepon'];
    website = json['website'];
    email = json['email'];
    aksesInternet = json['akses_internet'];
    selaluBuka = json['selalu_buka'];
    hariBuka = json['hari_buka'];
    media = json['media'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    kategori = json['kategori'];
    tags = json['tags'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    gambarUtama = json['gambar_utama'];
    provinceId = json['province_id'];
    if (json['gambar'] != null) {
      gambar = <Gambar>[];
      json['gambar'].forEach((v) {
        gambar!.add(new Gambar.fromJson(v));
      });
    }
    if (json['produk'] != null) {
      produk = <Produk>[];
      json['produk'].forEach((v) {
        produk!.add(new Produk.fromJson(v));
      });
    }
    numOfProduk = json['numOfProduk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kategori_lokasi_id'] = this.kategoriLokasiId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['nama'] = this.nama;
    data['icon'] = this.icon;
    data['nomor'] = this.nomor;
    data['jalan'] = this.jalan;
    data['regency_id'] = this.regencyId;
    data['district_id'] = this.districtId;
    data['village_id'] = this.villageId;
    data['kode_pos'] = this.kodePos;
    data['telepon'] = this.telepon;
    data['website'] = this.website;
    data['email'] = this.email;
    data['akses_internet'] = this.aksesInternet;
    data['selalu_buka'] = this.selaluBuka;
    data['hari_buka'] = this.hariBuka;
    data['media'] = this.media;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['kategori'] = this.kategori;
    data['tags'] = this.tags;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['gambar_utama'] = this.gambarUtama;
    data['province_id'] = this.provinceId;
    if (this.gambar != null) {
      data['gambar'] = this.gambar!.map((v) => v.toJson()).toList();
    }
    if (this.produk != null) {
      data['produk'] = this.produk!.map((v) => v.toJson()).toList();
    }
    data['numOfProduk'] = this.numOfProduk;
    return data;
  }
}

class Gambar {
  String? id;
  String? idOrtu;
  String? file;
  Null url;
  Null jenis;
  String? caption;
  String? parent;
  String? clicked;
  Null createdAt;
  Null createdBy;

  Gambar(
      {this.id,
        this.idOrtu,
        this.file,
        this.url,
        this.jenis,
        this.caption,
        this.parent,
        this.clicked,
        this.createdAt,
        this.createdBy});

  Gambar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idOrtu = json['id_ortu'];
    file = json['file'];
    url = json['url'];
    jenis = json['jenis'];
    caption = json['caption'];
    parent = json['parent'];
    clicked = json['clicked'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_ortu'] = this.idOrtu;
    data['file'] = this.file;
    data['url'] = this.url;
    data['jenis'] = this.jenis;
    data['caption'] = this.caption;
    data['parent'] = this.parent;
    data['clicked'] = this.clicked;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class Produk {
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
  String? diskon;
  Null etalaseId;
  String? hits;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;

  Produk(
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
        this.diskon,
        this.etalaseId,
        this.hits,
        this.createdAt,
        this.updatedAt,
        this.updatedBy});

  Produk.fromJson(Map<String, dynamic> json) {
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
    diskon = json['diskon'];
    etalaseId = json['etalase_id'];
    hits = json['hits'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
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
    data['diskon'] = this.diskon;
    data['etalase_id'] = this.etalaseId;
    data['hits'] = this.hits;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
