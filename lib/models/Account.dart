// To parse this JSON data, do
//
//     final accountModel = accountModelFromMap(jsonString);

import 'dart:convert';

class AccountModel {
  AccountModel({
    required this.apiStatus,
    required this.apiMessage,
    required this.apiResponseFields,
    required this.apiAuthorization,
    required this.id,
    required this.name,
    required this.photo,
    required this.email,
    required this.nik,
    required this.nip,
    required this.idCmsPrivileges,
    required this.cmsPrivilegesName,
    required this.cmsPrivilegesIsSuperadmin,
    required this.cmsPrivilegesThemeColor,
    required this.districtId,
    required this.villageId,
    required this.rt,
    required this.approveId,
    required this.rejectId,
    required this.rw,
    required this.status,
    required this.icon,
    required this.kelurahan,
    required this.kecamatan,
    required this.displayName,
    required this.multiPrivs,
    required this.kependudukan,
    required this.pemilik,
    required this.usaha,
  });

  final int apiStatus;
  final String apiMessage;
  final String apiResponseFields;
  final String apiAuthorization;
  final String id;
  final String name;
  final String photo;
  final String email;
  final String nik;
  final dynamic nip;
  final String idCmsPrivileges;
  final String cmsPrivilegesName;
  final String cmsPrivilegesIsSuperadmin;
  final String cmsPrivilegesThemeColor;
  final String districtId;
  final String villageId;
  final dynamic rt;
  final dynamic approveId;
  final dynamic rejectId;
  final dynamic rw;
  final String status;
  final dynamic icon;
  final String kelurahan;
  final String kecamatan;
  final String displayName;
  final List<MultiPriv> multiPrivs;
  final Kependudukan kependudukan;
  final Pemilik pemilik;
  final List<dynamic> usaha;

  factory AccountModel.fromJson(String str) => AccountModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountModel.fromMap(Map<String, dynamic> json) => AccountModel(
    apiStatus: json["api_status"],
    apiMessage: json["api_message"],
    apiResponseFields: json["api_response_fields"],
    apiAuthorization: json["api_authorization"],
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    email: json["email"],
    nik: json["nik"],
    nip: json["nip"],
    idCmsPrivileges: json["id_cms_privileges"],
    cmsPrivilegesName: json["cms_privileges_name"],
    cmsPrivilegesIsSuperadmin: json["cms_privileges_is_superadmin"],
    cmsPrivilegesThemeColor: json["cms_privileges_theme_color"],
    districtId: json["district_id"],
    villageId: json["village_id"],
    rt: json["rt"],
    approveId: json["approve_id"],
    rejectId: json["reject_id"],
    rw: json["rw"],
    status: json["status"],
    icon: json["icon"],
    kelurahan: json["kelurahan"],
    kecamatan: json["kecamatan"],
    displayName: json["display_name"],
    multiPrivs: List<MultiPriv>.from(json["multi_privs"].map((x) => MultiPriv.fromMap(x))),
    kependudukan: Kependudukan.fromMap(json["kependudukan"]),
    pemilik: Pemilik.fromMap(json["pemilik"]),
    usaha: List<dynamic>.from(json["usaha"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "api_status": apiStatus,
    "api_message": apiMessage,
    "api_response_fields": apiResponseFields,
    "api_authorization": apiAuthorization,
    "id": id,
    "name": name,
    "photo": photo,
    "email": email,
    "nik": nik,
    "nip": nip,
    "id_cms_privileges": idCmsPrivileges,
    "cms_privileges_name": cmsPrivilegesName,
    "cms_privileges_is_superadmin": cmsPrivilegesIsSuperadmin,
    "cms_privileges_theme_color": cmsPrivilegesThemeColor,
    "district_id": districtId,
    "village_id": villageId,
    "rt": rt,
    "approve_id": approveId,
    "reject_id": rejectId,
    "rw": rw,
    "status": status,
    "icon": icon,
    "kelurahan": kelurahan,
    "kecamatan": kecamatan,
    "display_name": displayName,
    "multi_privs": List<dynamic>.from(multiPrivs.map((x) => x.toMap())),
    "kependudukan": kependudukan.toMap(),
    "pemilik": pemilik.toMap(),
    "usaha": List<dynamic>.from(usaha.map((x) => x)),
  };
}

class Kependudukan {
  Kependudukan({
    required this.id,
    required this.nik,
    required this.alamat,
    required this.rt,
    required this.rw,
    required this.namaKel,
    required this.namaKec,
    required this.namaKab,
    required this.namaProp,
    required this.kelurahan,
    required this.kecamatan,
    required this.kabupaten,
    required this.provinsi,
  });

  final String id;
  final String nik;
  final String alamat;
  final String rt;
  final String rw;
  final String namaKel;
  final String namaKec;
  final String namaKab;
  final String namaProp;
  final String kelurahan;
  final String kecamatan;
  final String kabupaten;
  final String provinsi;

  factory Kependudukan.fromJson(String str) => Kependudukan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Kependudukan.fromMap(Map<String, dynamic> json) => Kependudukan(
    id: json["id"],
    nik: json["nik"],
    alamat: json["alamat"],
    rt: json["rt"],
    rw: json["rw"],
    namaKel: json["nama_kel"],
    namaKec: json["nama_kec"],
    namaKab: json["nama_kab"],
    namaProp: json["nama_prop"],
    kelurahan: json["kelurahan"],
    kecamatan: json["kecamatan"],
    kabupaten: json["kabupaten"],
    provinsi: json["provinsi"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nik": nik,
    "alamat": alamat,
    "rt": rt,
    "rw": rw,
    "nama_kel": namaKel,
    "nama_kec": namaKec,
    "nama_kab": namaKab,
    "nama_prop": namaProp,
    "kelurahan": kelurahan,
    "kecamatan": kecamatan,
    "kabupaten": kabupaten,
    "provinsi": provinsi,
  };
}

class MultiPriv {
  MultiPriv({
    required this.cmsPrivilegesId,
    required this.name,
  });

  final String cmsPrivilegesId;
  final String name;

  factory MultiPriv.fromJson(String str) => MultiPriv.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MultiPriv.fromMap(Map<String, dynamic> json) => MultiPriv(
    cmsPrivilegesId: json["cms_privileges_id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "cms_privileges_id": cmsPrivilegesId,
    "name": name,
  };
}

class Pemilik {
  Pemilik({
    required this.id,
    required this.wargaBjbId,
    required this.noIumk,
    required this.nibSku,
    required this.noNpwp,
    required this.noTelp,
    required this.fax,
    required this.email,
    required this.facebookId,
    required this.instagramId,
    required this.pelatihan,
    required this.bantuan,
    required this.keterangan,
    required this.statusUmkmId,
    required this.updatedBy,
    required this.updatedAt,
  });

  final String id;
  final String wargaBjbId;
  final dynamic noIumk;
  final dynamic nibSku;
  final dynamic noNpwp;
  final dynamic noTelp;
  final dynamic fax;
  final dynamic email;
  final dynamic facebookId;
  final dynamic instagramId;
  final dynamic pelatihan;
  final dynamic bantuan;
  final dynamic keterangan;
  final dynamic statusUmkmId;
  final String updatedBy;
  final DateTime updatedAt;

  factory Pemilik.fromJson(String str) => Pemilik.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pemilik.fromMap(Map<String, dynamic> json) => Pemilik(
    id: json["id"],
    wargaBjbId: json["warga_bjb_id"],
    noIumk: json["no_iumk"],
    nibSku: json["nib_sku"],
    noNpwp: json["no_npwp"],
    noTelp: json["no_telp"],
    fax: json["fax"],
    email: json["email"],
    facebookId: json["facebook_id"],
    instagramId: json["instagram_id"],
    pelatihan: json["pelatihan"],
    bantuan: json["bantuan"],
    keterangan: json["keterangan"],
    statusUmkmId: json["status_umkm_id"],
    updatedBy: json["updated_by"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "warga_bjb_id": wargaBjbId,
    "no_iumk": noIumk,
    "nib_sku": nibSku,
    "no_npwp": noNpwp,
    "no_telp": noTelp,
    "fax": fax,
    "email": email,
    "facebook_id": facebookId,
    "instagram_id": instagramId,
    "pelatihan": pelatihan,
    "bantuan": bantuan,
    "keterangan": keterangan,
    "status_umkm_id": statusUmkmId,
    "updated_by": updatedBy,
    "updated_at": updatedAt.toIso8601String(),
  };
}
