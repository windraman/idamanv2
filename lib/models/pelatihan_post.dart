

class PelatihanPostModel {
  String cms_user_id;
  String umkm_usaha_id;
  String pelatihan_id;


  PelatihanPostModel({
    required this.cms_user_id,
    required this.umkm_usaha_id,
    required this.pelatihan_id
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'cms_user_id': cms_user_id,
      'umkm_usaha_id': umkm_usaha_id,
      'pelatihan_id': pelatihan_id
    };

    return map;
  }
}