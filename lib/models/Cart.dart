
import 'Product.dart';

class Cart {
  final Product product;
  late final int numOfItem;
  final int id;
  final String error;
  final int tarif_per_km;
  final int biaya_kurir;
  final double avg_jarak;

  Cart({
    required this.id,
    required this.product,
    this.numOfItem = 0,
    required this.tarif_per_km,
    required this.biaya_kurir,
    required this.error,
    required this.avg_jarak
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json["id"] != null ? json["id"] : "",
      numOfItem: json["qty"] != null ? json["qty"] : 0,
        tarif_per_km: json["tarif_per_km"] != null ? int.parse(json["tarif_per_km"]) : 0,
        biaya_kurir: json["biaya_kurir"] != null ? json["biaya_kurir"] : 0,
      product: json["produk"] != null ? json["produk"] : "",
        error: json["error"] != null ? json["error"] : "",
        avg_jarak: json["avg_jarak"] != null ? json["avg_jarak"] : 0
    );
  }

}
