class KategoriModel {
  final int numOfProduk;
  final String nama_kategori,icon, photo, banner, id, hits;
  KategoriModel({
    required this.id,
    required this.nama_kategori,
    required this.photo,
    required this.banner,
    required this.icon,
    required this.hits,
    required this.numOfProduk,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      id: json["id"] != null ? json["id"] : "",
      icon: json["icon"] != null ? json["icon"] : "",
      nama_kategori: json["nama_kategori"] != null ? json["nama_kategori"] : "",
      photo: json["photo"] != null ? json["photo"] : "",
      banner: json["banner"] != null ? json["banner"] : "",
      numOfProduk: json["numOfProduk"] != null ? json["numOfProduk"] : "",
      hits: json["hits"] != null ? json["hits"] : ""
    );
  }
}
