class HomecareMedia {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  HomecareMedia(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  HomecareMedia.fromJson(Map<String, dynamic> json) {
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
  String? file;
  String? homecareId;
  String? id;
  String? nik;
  String? nama;
  String? alamat;
  String? status;
  Pengirim? pengirim;
  String? createdBy;
  String? createdAt;

  Data(
      {this.file,
        this.homecareId,
        this.id,
        this.nik,
        this.nama,
        this.alamat,
        this.status,
        this.pengirim,
        this.createdBy,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    homecareId = json['homecare_id'];
    id = json['id'];
    nik = json['nik'];
    nama = json['nama'];
    alamat = json['alamat'];
    status = json['status'];
    pengirim = json['pengirim'] != null
        ? new Pengirim.fromJson(json['pengirim'])
        : null;
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['homecare_id'] = this.homecareId;
    data['id'] = this.id;
    data['nik'] = this.nik;
    data['nama'] = this.nama;
    data['alamat'] = this.alamat;
    data['status'] = this.status;
    if (this.pengirim != null) {
      data['pengirim'] = this.pengirim!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Pengirim {
  String? id;
  String? name;
  String? displayName;
  String? photo;
  String? noTelp;

  Pengirim({this.id, this.name, this.displayName, this.photo, this.noTelp});

  Pengirim.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    photo = json['photo'];
    noTelp = json['no_telp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['photo'] = this.photo;
    data['no_telp'] = this.noTelp;
    return data;
  }
}
