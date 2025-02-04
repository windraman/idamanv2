
class KomentarDataModel{
  final String id;
  final String key_id;
  final String user_id;
  final String nama_table;
  final String isi;
  final String gambar;
  final String jenis_gambar;
  final String created_at;
  final String is_read;
  final String nama;
  //final String? nama_tampilan;
  final String photo;
  //final List<String> penyuka;
  final String jpenyuka;
  final String ilike;
  final String isSender;
  KomentarDataModel({
    required this.id,
    required this.key_id,
    required this.user_id,
    required this.nama_table,
    required this.isi,
    required this.gambar,
    required this.jenis_gambar,
    required this.created_at,
    required this.is_read,
    required this.nama,
    //this.nama_tampilan,
    required this.photo,
    //required this.penyuka,
    required this.jpenyuka,
    required this.ilike,
    required this.isSender
  });

  factory KomentarDataModel.fromJson(Map<String, dynamic> json){
    return KomentarDataModel(
      id: json["id"],
      key_id: json["key_id"],
      user_id: json["user_id"],
      nama_table: json["nama_table"],
        isi: json["isi"],
      gambar: json["gambar"],
      jenis_gambar:  json["jenis_gambar"],
      created_at:  json["created_at"],
      is_read:   json["is_read"],
      nama:  json["nama"],
      //nama_tampilan:  json["nama_tampilan"],
      photo:  json["photo"],
      //penyuka:  json["penyuka"],
      jpenyuka:  json["jpenyuka"],
      ilike:  json["ilike"],
        isSender:  json["isSender"]
    );
  }
}