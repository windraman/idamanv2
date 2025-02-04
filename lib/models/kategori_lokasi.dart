class KategoriLokasiModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  KategoriLokasiModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  KategoriLokasiModel.fromJson(Map<String, dynamic> json) {
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
  String? slug;
  String? nama;
  String? icon;
  String? ortu;
  String? aktif;
  String? showText;
  List<Anak>? anak;

  Data(
      {this.id,
        this.slug,
        this.nama,
        this.icon,
        this.ortu,
        this.aktif,
        this.showText,
        this.anak});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    nama = json['nama'];
    icon = json['icon'];
    ortu = json['ortu'];
    aktif = json['aktif'];
    showText = json['show_text'];
    if (json['anak'] != null) {
      anak = <Anak>[];
      json['anak'].forEach((v) {
        anak!.add(new Anak.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['nama'] = this.nama;
    data['icon'] = this.icon;
    data['ortu'] = this.ortu;
    data['aktif'] = this.aktif;
    data['show_text'] = this.showText;
    if (this.anak != null) {
      data['anak'] = this.anak!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Anak {
  String? id;
  String? slug;
  String? nama;
  String? icon;
  String? ortu;
  String? aktif;
  String? hit;
  String? showText;

  Anak(
      {this.id,
        this.slug,
        this.nama,
        this.icon,
        this.ortu,
        this.aktif,
        this.hit,
        this.showText});

  Anak.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    nama = json['nama'];
    icon = json['icon'];
    ortu = json['ortu'];
    aktif = json['aktif'];
    hit = json['hit'];
    showText = json['show_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['nama'] = this.nama;
    data['icon'] = this.icon;
    data['ortu'] = this.ortu;
    data['aktif'] = this.aktif;
    data['hit'] = this.hit;
    data['show_text'] = this.showText;
    return data;
  }
}
