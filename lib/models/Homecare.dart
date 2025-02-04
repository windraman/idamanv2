class Homecare {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  Homecare({this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  Homecare.fromJson(Map<String, dynamic> json) {
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
  String? alamat;
  Null dinasId;
  Null faskesId;
  String? id;
  String? keterangan;
  String? lat;
  String? lon;
  String? nama;
  String? nik;
  String? status;
  Null userId;
  String? createdBy;
  String? createdAt;
  Pengirim? pengirim;
  List<Handler>? handler;
  List<Photos>? photos;

  Data(
      {this.alamat,
        this.dinasId,
        this.faskesId,
        this.id,
        this.keterangan,
        this.lat,
        this.lon,
        this.nama,
        this.nik,
        this.status,
        this.userId,
        this.createdBy,
        this.createdAt,
        this.pengirim,
        this.handler,
        this.photos});

  Data.fromJson(Map<String, dynamic> json) {
    alamat = json['alamat'];
    dinasId = json['dinas_id'];
    faskesId = json['faskes_id'];
    id = json['id'];
    keterangan = json['keterangan'];
    lat = json['lat'];
    lon = json['lon'];
    nama = json['nama'];
    nik = json['nik'];
    status = json['status'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    pengirim = json['pengirim'] != null
        ? new Pengirim.fromJson(json['pengirim'])
        : null;
    if (json['handler'] != null) {
      handler = <Handler>[];
      json['handler'].forEach((v) {
        handler!.add(new Handler.fromJson(v));
      });
    }
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alamat'] = this.alamat;
    data['dinas_id'] = this.dinasId;
    data['faskes_id'] = this.faskesId;
    data['id'] = this.id;
    data['keterangan'] = this.keterangan;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['nama'] = this.nama;
    data['nik'] = this.nik;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    if (this.pengirim != null) {
      data['pengirim'] = this.pengirim!.toJson();
    }
    if (this.handler != null) {
      data['handler'] = this.handler!.map((v) => v.toJson()).toList();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
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

class Handler {
  String? id;
  String? homecareId;
  String? dinasId;
  Null keterangan;
  String? satuanKerja;

  Handler(
      {this.id,
        this.homecareId,
        this.dinasId,
        this.keterangan,
        this.satuanKerja});

  Handler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    homecareId = json['homecare_id'];
    dinasId = json['dinas_id'];
    keterangan = json['keterangan'];
    satuanKerja = json['satuan_kerja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['homecare_id'] = this.homecareId;
    data['dinas_id'] = this.dinasId;
    data['keterangan'] = this.keterangan;
    data['satuan_kerja'] = this.satuanKerja;
    return data;
  }
}

class Photos {
  String? id;
  String? homecareId;
  String? file;
  String? updatedAt;

  Photos({this.id, this.homecareId, this.file, this.updatedAt});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    homecareId = json['homecare_id'];
    file = json['file'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['homecare_id'] = this.homecareId;
    data['file'] = this.file;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
