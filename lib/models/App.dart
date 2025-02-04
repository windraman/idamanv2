class AppModel {
  int? apiStatus;
  String? apiMessage;
  int? id;
  String? name;
  String? owner;
  String? url;
  String? photo;

  AppModel(
      {
        this.apiStatus,
        this.apiMessage,
        this.id,
        this.name,
        this.owner,
        this.url,
        this.photo
      });

  AppModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiMessage = json['api_message'].toString();
    id = json['id'];
    name = json['name'].toString();
    owner = json['owner'].toString();
    url = json['url'].toString();
    photo = json['photo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_message'] = this.apiMessage;
    data['id'] = this.id;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['url'] = this.url;
    data['photo'] = this.photo;
    return data;
  }
}
