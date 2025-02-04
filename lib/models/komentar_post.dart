class KomentarRequestModel {
  String namaTable, keyId, userId, isi, terlibat;

  KomentarRequestModel({
    required this.namaTable,
    required this.keyId,
    required this.userId,
    required this.isi,
    required this.terlibat,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'nama_table': namaTable.trim(),
      'key_id': keyId.trim(),
      'user_id': userId.trim(),
      'isi': isi.trim(),
      'terlibat': terlibat.trim(),
    };

    return map;
  }
}