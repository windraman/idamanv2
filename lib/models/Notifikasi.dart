class NotifikasiModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  List<Data>? data;

  NotifikasiModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  NotifikasiModel.fromJson(Map<String, dynamic> json) {
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
  String? idCmsUsers;
  String? masterNotifId;
  String? content;
  String? url;
  String? isRead;
  String? status;
  String? nik;
  String? style;
  String? gambar;
  String? createdAt;

  Data(
      {this.id,
        this.idCmsUsers,
        this.masterNotifId,
        this.content,
        this.url,
        this.isRead,
        this.status,
        this.nik,
        this.style,
        this.gambar,
        this.createdAt
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCmsUsers = json['id_cms_users'];
    masterNotifId = json['master_notif_id'];
    content = json['content'];
    url = json['url'];
    isRead = json['is_read'];
    status = json['status'];
    nik = json['nik'];
    style = json['style'];
    gambar = json['gambar'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_cms_users'] = this.idCmsUsers;
    data['master_notif_id'] = this.masterNotifId;
    data['content'] = this.content;
    data['url'] = this.url;
    data['is_read'] = this.isRead;
    data['status'] = this.status;
    data['nik'] = this.nik;
    data['style'] = this.style;
    data['gambar'] = this.gambar;
    data['created_at'] = this.createdAt;
    return data;
  }
}
