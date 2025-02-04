class StasModel {
  final int usaha, pemilik_lokal, pemilik_luar, nonekraf, ekraf;
  StasModel({
    required this.usaha,
    required this.pemilik_lokal,
    required this.pemilik_luar,
    required this.ekraf,
    required this.nonekraf
  });

  factory StasModel.fromJson(Map<String, dynamic> json) {
    return StasModel(
      usaha: json["usaha"] != null ? json["usaha"] : 0,
      pemilik_lokal: json["pemilik_lokal"] != null ? json["pemilik_lokal"] : 0,
      pemilik_luar: json["pemilik_luar"] != null ? json["pemilik_luar"] : 0,
      ekraf: json["ekraf"] != null ? json["ekraf"] : 0,
      nonekraf: json["nonekraf"] != null ? json["nonekraf"] : 0,
    );
  }
}
