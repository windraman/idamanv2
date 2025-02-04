class ProfilPostResponseModel {
  int? apiStatus;
  String? apiMessage;
  String? apiAuthorization;
  DataProfil? data;

  ProfilPostResponseModel(
      {this.apiStatus, this.apiMessage, this.apiAuthorization, this.data});

  ProfilPostResponseModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiMessage = json['api_message'];
    apiAuthorization = json['api_authorization'];
    data = json['data'] != null ? new DataProfil.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_message'] = this.apiMessage;
    data['api_authorization'] = this.apiAuthorization;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataProfil {
  String? displayName;
  String? photo;
  String? icon;

  DataProfil({this.displayName, this.photo, this.icon});

  DataProfil.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    photo = json['photo'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    data['photo'] = this.photo;
    data['icon'] = this.icon;
    return data;
  }
}
