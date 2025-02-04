import 'dart:convert';

class UsahaModel {
  UsahaModel( {
    required this.idUsaha,
    required this.wargaId,
    required this.namaUsaha,
    required this.bidangUsaha,
    required this.subBidangUsaha,
    required this.jenisProduk,
    required this.brand,
    required this.alamatUsaha,
    required this.provinceId,
    required this.regencyId,
    required this.districtId,
    required this.villageId,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
    required this.lat,
    required this.lon,
    required this.photo,
    required this.verified,
    required this.numOfProduk,
    required this.lokasiId,
  });

  final String idUsaha;
  final String wargaId;
  final String namaUsaha;
  final String bidangUsaha;
  final String subBidangUsaha;
  final String jenisProduk;
  final String brand;
  final String alamatUsaha;
  final String provinceId;
  final String regencyId;
  final String districtId;
  final String villageId;
  final String lat;
  final String lon;
  final String photo;
  final String verified;
  final String provinsi;
  final String kabupaten;
  final String kecamatan;
  final String kelurahan;
  final int numOfProduk;
  final String lokasiId;

  factory UsahaModel.fromJson(String str) => UsahaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsahaModel.fromMap(Map<String, dynamic> json) => UsahaModel(
    idUsaha: json["id"] ?? '',
    wargaId: json["warga_bjb_id"] ?? '',
    namaUsaha: json["nama_usaha"] ?? '',
    bidangUsaha: json["bidang_usaha"] ?? '',
    subBidangUsaha: json["sub_bidang_usaha"] ?? '',
    jenisProduk: json["jenis_produk"] ?? '',
    brand: json["brand"] ?? '',
    alamatUsaha: json["alamat_usaha"] ?? '',
    provinceId: json["province_id"] ?? '',
    districtId: json["district_id"] ?? '',
    regencyId: json["regency_id"] ?? '',
    villageId: json["village_id"] ?? '',
    lat: json["lat"] ?? '',
    lon: json["lon"] ?? '',
    photo: json["photo"] ?? '',
    verified: json["verified"] ?? '',
    provinsi: json["provinsi"]?? '',
    kabupaten: json["kabupaten"]?? '',
    kecamatan: json["kecamatan"]?? '',
    kelurahan: json["kelurahan"]?? '',
      numOfProduk: json["numOfProduk"]?? 0,
      lokasiId: json["lokasi_id"]?? ''
  );

  Map<String, dynamic> toMap() => {
    "id": idUsaha,
    "warga_bjb_id": wargaId,
    "nama_usaha": namaUsaha,
    "bidang_usaha": bidangUsaha,
    "sub_bidang_usaha": subBidangUsaha,
    "janie_produk": jenisProduk,
    "brand": brand,
    "alamat_usaha": alamatUsaha,
    "province_id": provinceId,
    "regency_id": regencyId,
    "district_id": districtId,
    "village_id": villageId,
    "lat": lat,
    "lon": lon,
    "verified": verified,
    "photo": photo,
    "provinsi": provinsi,
    "kabupaten": kabupaten,
    "kecamatan": kecamatan,
    "kelurahan": kelurahan,
    "numOfProduk": numOfProduk,
    "lokasi_id": lokasiId,
  };
}
