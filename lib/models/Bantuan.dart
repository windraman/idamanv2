class BantuanModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  BantuanModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  BantuanModel.fromJson(Map<String, dynamic> json) {
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
  String? tanggal;
  String? bantuan;
  String? pemberiBantuan;
  String? jumlah;
  String? satuanId;
  String? total;
  String? satuanTotal;
  String? photo;
  String? keterangan;
  String? usahaRequired;
  String? aktif;
  String? createdBy;
  String? createdByPriv;
  String? updatedBy;
  String? updatedByPriv;

  Data(
      {this.id,
        this.tanggal,
        this.bantuan,
        this.pemberiBantuan,
        this.jumlah,
        this.satuanId,
        this.total,
        this.satuanTotal,
        this.photo,
        this.keterangan,
        this.usahaRequired,
        this.aktif,
        this.createdBy,
        this.createdByPriv,
        this.updatedBy,
        this.updatedByPriv});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    tanggal = json['tanggal'].toString();
    bantuan = json['bantuan'].toString();
    pemberiBantuan = json['pemberi_bantuan'].toString();
    jumlah = json['jumlah'].toString();
    satuanId = json['satuan_id'].toString();
    total = json['total'].toString();
    satuanTotal = json['satuan_total'].toString();
    photo = json['photo'].toString();
    keterangan = json['keterangan'].toString();
    usahaRequired = json['usaha_required'].toString();
    aktif = json['aktif'].toString();
    createdBy = json['created_by'].toString();
    createdByPriv = json['created_by_priv'].toString();
    updatedBy = json['updated_by'].toString();
    updatedByPriv = json['updated_by_priv'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tanggal'] = this.tanggal;
    data['bantuan'] = this.bantuan;
    data['pemberi_bantuan'] = this.pemberiBantuan;
    data['jumlah'] = this.jumlah;
    data['satuan_id'] = this.satuanId;
    data['total'] = this.total;
    data['satuan_total'] = this.satuanTotal;
    data['photo'] = this.photo;
    data['keterangan'] = this.keterangan;
    data['usaha_required'] = this.usahaRequired;
    data['aktif'] = this.aktif;
    data['created_by'] = this.createdBy;
    data['created_by_priv'] = this.createdByPriv;
    data['updated_by'] = this.updatedBy;
    data['updated_by_priv'] = this.updatedByPriv;
    return data;
  }
}
