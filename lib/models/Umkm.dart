class UmkmModel {
  int? apiStatus;
  String? apiMessage;
  List<Data>? data;
  int? numOfData;

  UmkmModel(
      {this.apiStatus,
        this.apiMessage,
        this.data,
        this.numOfData});

  UmkmModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiMessage = json['api_message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    numOfData = json['numOfData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_message'] = this.apiMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['numOfData'] = this.numOfData;
    return data;
  }
}

class Data {
  String? id;
  String? wargaBjbId;
  String? namaUsaha;
  String? bidangUsaha;
  String? subBidangUsaha;
  String? jenisProduk;
  String? brand;
  String? mulaiUsaha;
  String? alamatUsaha;
  String? noTelpUsaha;
  String? provinceId;
  String? regencyId;
  String? districtId;
  String? villageId;
  String? statusUsahaId;
  String? perizinan;
  String? permodalanId;
  String? pemasaranId;
  String? penerimaBantuan;
  String? jKaryL;
  String? jKaryP;
  String? jKary;
  String? modalAwal;
  String? modalSaatIni;
  String? updateModal;
  String? asetTetap;
  String? omset;
  String? updateOmset;
  String? keterangan;
  String? gps;
  String? lat;
  String? lon;
  String? photo;
  String? petaIcon;
  String? updatedBy;
  String? updatedAt;
  String? verified;
  String? statusId;
  String? sandi;
  String? username;
  String? kecamatan;
  String? kelurahan;
  String? jarakKm;

  Data(
      {this.id,
        this.wargaBjbId,
        this.namaUsaha,
        this.bidangUsaha,
        this.subBidangUsaha,
        this.jenisProduk,
        this.brand,
        this.mulaiUsaha,
        this.alamatUsaha,
        this.noTelpUsaha,
        this.provinceId,
        this.regencyId,
        this.districtId,
        this.villageId,
        this.statusUsahaId,
        this.perizinan,
        this.permodalanId,
        this.pemasaranId,
        this.penerimaBantuan,
        this.jKaryL,
        this.jKaryP,
        this.jKary,
        this.modalAwal,
        this.modalSaatIni,
        this.updateModal,
        this.asetTetap,
        this.omset,
        this.updateOmset,
        this.keterangan,
        this.gps,
        this.lat,
        this.lon,
        this.photo,
        this.petaIcon,
        this.updatedBy,
        this.updatedAt,
        this.verified,
        this.statusId,
        this.sandi,
        this.username,
        this.kecamatan,
        this.kelurahan,
        this.jarakKm});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wargaBjbId = json['warga_bjb_id'];
    namaUsaha = json['nama_usaha'];
    bidangUsaha = json['bidang_usaha'];
    subBidangUsaha = json['sub_bidang_usaha'];
    jenisProduk = json['jenis_produk'];
    brand = json['brand'];
    mulaiUsaha = json['mulai_usaha'];
    alamatUsaha = json['alamat_usaha'];
    noTelpUsaha = json['no_telp_usaha'];
    provinceId = json['province_id'];
    regencyId = json['regency_id'];
    districtId = json['district_id'];
    villageId = json['village_id'];
    statusUsahaId = json['status_usaha_id'];
    perizinan = json['perizinan'];
    permodalanId = json['permodalan_id'];
    pemasaranId = json['pemasaran_id'];
    penerimaBantuan = json['penerima_bantuan'];
    jKaryL = json['j_kary_l'];
    jKaryP = json['j_kary_p'];
    jKary = json['j_kary'];
    modalAwal = json['modal_awal'];
    modalSaatIni = json['modal_saat_ini'];
    updateModal = json['update_modal'];
    asetTetap = json['aset_tetap'];
    omset = json['omset'];
    updateOmset = json['update_omset'];
    keterangan = json['keterangan'];
    gps = json['gps'];
    lat = json['lat'];
    lon = json['lon'];
    photo = json['photo'];
    petaIcon = json['peta_icon'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    verified = json['verified'];
    statusId = json['status_id'];
    sandi = json['sandi'];
    username = json['username'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    jarakKm = json['jarak_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warga_bjb_id'] = this.wargaBjbId;
    data['nama_usaha'] = this.namaUsaha;
    data['bidang_usaha'] = this.bidangUsaha;
    data['sub_bidang_usaha'] = this.subBidangUsaha;
    data['jenis_produk'] = this.jenisProduk;
    data['brand'] = this.brand;
    data['mulai_usaha'] = this.mulaiUsaha;
    data['alamat_usaha'] = this.alamatUsaha;
    data['no_telp_usaha'] = this.noTelpUsaha;
    data['province_id'] = this.provinceId;
    data['regency_id'] = this.regencyId;
    data['district_id'] = this.districtId;
    data['village_id'] = this.villageId;
    data['status_usaha_id'] = this.statusUsahaId;
    data['perizinan'] = this.perizinan;
    data['permodalan_id'] = this.permodalanId;
    data['pemasaran_id'] = this.pemasaranId;
    data['penerima_bantuan'] = this.penerimaBantuan;
    data['j_kary_l'] = this.jKaryL;
    data['j_kary_p'] = this.jKaryP;
    data['j_kary'] = this.jKary;
    data['modal_awal'] = this.modalAwal;
    data['modal_saat_ini'] = this.modalSaatIni;
    data['update_modal'] = this.updateModal;
    data['aset_tetap'] = this.asetTetap;
    data['omset'] = this.omset;
    data['update_omset'] = this.updateOmset;
    data['keterangan'] = this.keterangan;
    data['gps'] = this.gps;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['photo'] = this.photo;
    data['peta_icon'] = this.petaIcon;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['verified'] = this.verified;
    data['status_id'] = this.statusId;
    data['sandi'] = this.sandi;
    data['username'] = this.username;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['jarak_km'] = this.jarakKm;
    return data;
  }
}
