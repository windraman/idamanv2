class TransaksiPostModel {
  String pembeli_id, total_item, total_harga, voucher_id, pembeli_lat, pembeli_lon;
  String list_item_json;
  String jarak,ongkir;
  String metode_pembayaran_id;

  TransaksiPostModel({
    required this.pembeli_id,
    required this.total_item,
    required this.total_harga,
    this.voucher_id = "0",
    required this.list_item_json,
    required this.pembeli_lat,
    required this.pembeli_lon,
    required this.jarak,
    required this.ongkir,
    required this.metode_pembayaran_id
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'pembeli_id': pembeli_id,
      'total_item': total_item,
      'total_harga': total_harga,
      'voucher_id': voucher_id,
      'list_item_json': list_item_json,
      'pembeli_lat': pembeli_lat,
      'pembeli_lon': pembeli_lon,
      'jarak': jarak,
      'ongkir': ongkir,
      'metode_pembayaran_id':metode_pembayaran_id
    };

    return map;
  }
}