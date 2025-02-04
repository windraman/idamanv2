
class SlideData{
  final String id;
  final String judul;
  final String photo;

  SlideData({
    required this.id,
    required this.judul,
    required this.photo,
  });

  factory SlideData.fromJson(Map<String, dynamic> json) {
    return SlideData(
      id: json["id"] != null ? json["id"] : "",
      judul: json["judul"] != null ? json["judul"] : "",
      photo: json["photo"] != null ? json["photo"] : "",
    );
  }
}