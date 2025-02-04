class KeranjangPostModel {
  String catatan;
  String cms_users_id, produk_id, qty;

  KeranjangPostModel({
    required this.catatan,
    required this.cms_users_id,
    required this.produk_id,
    required this.qty
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'cms_users_id': cms_users_id,
      'produk_id': produk_id,
      'qty': qty,
      'catatan': catatan.trim()
    };

    return map;
  }
}