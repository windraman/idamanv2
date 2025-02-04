

class BantuanPostModel {
  String cms_user_id;
  String umkm_usaha_id;
  String bantuan_id;


  BantuanPostModel({
    required this.cms_user_id,
    required this.umkm_usaha_id,
    required this.bantuan_id
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'cms_user_id': cms_user_id,
      'umkm_usaha_id': umkm_usaha_id,
      'bantuan_id': bantuan_id
    };

    return map;
  }
}