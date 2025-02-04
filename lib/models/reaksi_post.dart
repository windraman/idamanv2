class ReaksiPostModel {
  String userId, namaTable, keyId, masterReaksiId;

  ReaksiPostModel({
    required this.userId,
    required this.namaTable,
    required this.keyId,
    required this.masterReaksiId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userId,
      'nama_table': namaTable,
      'key_id': keyId,
      'master_reaksi_id': masterReaksiId
    };

    return map;
  }
}