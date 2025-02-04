

class ShortcutResponseModel {
  final int api_status;
  final String api_message;
  final List data;

  ShortcutResponseModel({
    required this.api_status,
    required this.api_message,
    required this.data,
  });

  factory ShortcutResponseModel.fromJson(Map<String, dynamic> json) {
    return ShortcutResponseModel(
      api_status: json["api_status"] != null ? json["api_status"] : "",
      api_message: json["api_message"] != null ? json["api_message"] : "",
      data: json["data"] != null ? json["data"] : "",
    );
  }
}

class Data{
  final int id;
  final String judul;
  final String photo;
  final String keterangan;

  Data({
    required this.id,
    required this.judul,
    required this.photo,
    required this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"] != null ? json["id"] : "",
      judul: json["judul"] != null ? json["judul"] : "",
      photo: json["photo"] != null ? json["photo"] : "",
      keterangan: json["keterangan"] != null ? json["keterangan"] : "",
    );
  }
}