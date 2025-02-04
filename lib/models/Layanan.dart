class LayananModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  LayananModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  LayananModel.fromJson(Map<String, dynamic> json) {
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
  String? aksi;
  String? createdByPriv;
  String? districtId;
  String? id;
  String? jenisSuratId;
  String? jumlahDigit;
  String? kodeBelakang;
  String? kodeDepan;
  String? noTerakhir;
  String? villageId;
  String? namaSurat;
  String? kelurahan;

  Data(
      {this.aksi,
        this.createdByPriv,
        this.districtId,
        this.id,
        this.jenisSuratId,
        this.jumlahDigit,
        this.kodeBelakang,
        this.kodeDepan,
        this.noTerakhir,
        this.villageId,
        this.namaSurat,
        this.kelurahan});

  Data.fromJson(Map<String, dynamic> json) {
    aksi = json['aksi'];
    createdByPriv = json['created_by_priv'];
    districtId = json['district_id'];
    id = json['id'];
    jenisSuratId = json['jenis_surat_id'];
    jumlahDigit = json['jumlah_digit'];
    kodeBelakang = json['kode_belakang'];
    kodeDepan = json['kode_depan'];
    noTerakhir = json['no_terakhir'];
    villageId = json['village_id'];
    namaSurat = json['nama_surat'];
    kelurahan = json['kelurahan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aksi'] = this.aksi;
    data['created_by_priv'] = this.createdByPriv;
    data['district_id'] = this.districtId;
    data['id'] = this.id;
    data['jenis_surat_id'] = this.jenisSuratId;
    data['jumlah_digit'] = this.jumlahDigit;
    data['kode_belakang'] = this.kodeBelakang;
    data['kode_depan'] = this.kodeDepan;
    data['no_terakhir'] = this.noTerakhir;
    data['village_id'] = this.villageId;
    data['nama_surat'] = this.namaSurat;
    data['kelurahan'] = this.kelurahan;
    return data;
  }
}
