

class AspirasiPostModel {
  String cms_user_id;
  String privilege_tujuan;
  String judul;
  String isi;
  String gambar;


  AspirasiPostModel({
    required this.cms_user_id,
    required this.privilege_tujuan,
    required this.judul,
    required this.isi,
    required this.gambar
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'cms_user_id': cms_user_id,
      'privilege_tujuan': privilege_tujuan,
      'judul': judul,
      'isi': isi,
      'gambar': gambar
    };

    return map;
  }
}