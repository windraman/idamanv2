class BeratModel {
  final String id,simbol, nama_berat;
  double konversi;
  BeratModel({
    required this.id,
    required this.simbol,
    required this.nama_berat,
    required this.konversi
  });

  factory BeratModel.fromJson(Map<String, dynamic> json) {
    return BeratModel(
      id: json["id"] != null ? json["id"] : "",
      simbol: json["simbol"] != null ? json["simbol"] : "",
      nama_berat: json["nama_berat"] != null ? json["nama_berat"] : "",
      konversi: json["konversi"] != null ? double.parse(json["konversi"]) : 0,
    );
  }
}
