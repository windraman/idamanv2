class PelatihanModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  PelatihanModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  PelatihanModel.fromJson(Map<String, dynamic> json) {
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
  String? namaPelatihan;
  String? penyelenggara;
  String? awalDaftar;
  String? akhirDaftar;
  String? tanggalMulai;
  String? tanggalAkhir;
  String? tempat;
  String? kuota;
  String? keterangan;
  String? gambar;
  String? usahaRequired;
  String? createdBy;
  String? createdByPriv;
  String? updatedBy;
  String? updatedByPriv;

  Data(
      {this.id,
        this.namaPelatihan,
        this.penyelenggara,
        this.awalDaftar,
        this.akhirDaftar,
        this.tanggalMulai,
        this.tanggalAkhir,
        this.tempat,
        this.kuota,
        this.keterangan,
        this.gambar,
        this.usahaRequired,
        this.createdBy,
        this.createdByPriv,
        this.updatedBy,
        this.updatedByPriv});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    namaPelatihan = json['nama_pelatihan'].toString();
    penyelenggara = json['penyelenggara'].toString();
    awalDaftar = json['awal_daftar'].toString();
    akhirDaftar = json['akhir_daftar'].toString();
    tanggalMulai = json['tanggal_mulai'].toString();
    tanggalAkhir = json['tanggal_akhir'].toString();
    tempat = json['tempat'].toString();
    kuota = json['kuota'].toString();
    keterangan = json['keterangan'].toString();
    gambar = json['gambar'].toString();
    usahaRequired = json['usaha_required'].toString();
    createdBy = json['created_by'].toString();
    createdByPriv = json['created_by_priv'].toString();
    updatedBy = json['updated_by'].toString();
    updatedByPriv = json['updated_by_priv'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_pelatihan'] = this.namaPelatihan;
    data['penyelenggara'] = this.penyelenggara;
    data['awal_daftar'] = this.awalDaftar;
    data['akhir_daftar'] = this.akhirDaftar;
    data['tanggal_mulai'] = this.tanggalMulai;
    data['tanggal_akhir'] = this.tanggalAkhir;
    data['tempat'] = this.tempat;
    data['kuota'] = this.kuota;
    data['keterangan'] = this.keterangan;
    data['gambar'] = this.gambar;
    data['usaha_required'] = this.usahaRequired;
    data['created_by'] = this.createdBy;
    data['created_by_priv'] = this.createdByPriv;
    data['updated_by'] = this.updatedBy;
    data['updated_by_priv'] = this.updatedByPriv;
    return data;
  }
}
