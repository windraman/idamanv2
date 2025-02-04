import 'dart:convert';

class DataDiriModel {
  DataDiriModel( {
    required this.nik,
    required this.nama_lgkp,
    required this.jk,
    required this.tmpt_lhr,
    required this.tgl_lhr,
    required this.pddk_akhir_id,
    required this.pekerjaan_id,
    required this.alamat2,
    required this.rt,
    required this.rw,
    required this.nama_prop,
    required this.nama_kab,
    required this.nama_kec,
    required this.nama_kel,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
    required this.no_kk
  });

  final String nik;
  final String nama_lgkp;
  final String jk;
  final String tmpt_lhr;
  final String tgl_lhr;
  final String pddk_akhir_id;
  final String pekerjaan_id;
  final String alamat2;
  final String rt;
  final String rw;
  final String nama_prop;
  final String nama_kab;
  final String nama_kec;
  final String nama_kel;
  final String no_kk;
  final String provinsi;
  final String kabupaten;
  final String kecamatan;
  final String kelurahan;

  factory DataDiriModel.fromJson(String str) => DataDiriModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataDiriModel.fromMap(Map<String, dynamic> json) => DataDiriModel(
    nik: json["nik"].toString(),
    nama_lgkp: json["nama_lgkp"].toString(),
    jk: json["jk"].toString(),
    tmpt_lhr: json["tmpt_lhr"].toString(),
    tgl_lhr: json["tgl_lhr"].toString(),
    pddk_akhir_id: json["pddk_akhir_id"].toString(),
    pekerjaan_id: json["pekerjaan_id"].toString(),
    alamat2: json["alamat2"].toString(),
    rt: json["rt"].toString(),
    rw: json["rw"].toString(),
    nama_prop: json["nama_prop"].toString(),
    nama_kab: json["nama_kab"].toString(),
    nama_kec: json["nama_kec"].toString(),
    nama_kel: json["nama_kel"].toString(),
    no_kk: json["no_kk"].toString(),
    provinsi: json["provinsi"].toString(),
    kabupaten: json["kabupaten"].toString(),
    kecamatan: json["kecamatan"].toString(),
    kelurahan: json["kelurahan"].toString()
  );

  Map<String, dynamic> toMap() => {
    "nik": nik,
    "nama_lgkp": nama_lgkp,
    "jk": jk,
    "tmpt_lhr": tmpt_lhr,
    "tgl_lhr": tgl_lhr,
    "pddk_akhir_id": pddk_akhir_id,
    "pekerjaan_id": pekerjaan_id,
    "alamat2": alamat2,
    "rt": rt,
    "rw": rw,
    "nama_prop": nama_prop,
    "nama_kab": nama_kab,
    "nama_kec": nama_kec,
    "no_kk": no_kk,
    "provinsi": provinsi,
    "kabupaten": kabupaten,
    "kecamatan": kecamatan,
    "kelurahan": kelurahan
  };
}
