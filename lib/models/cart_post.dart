

class CartPost {
  final String produk_id;
  final String qty;
  final String catatan;

  CartPost({ required this.produk_id, required this.qty, required this.catatan});

  factory CartPost.fromJson(Map<String, dynamic> json) {
    return CartPost(
        produk_id: json["produk_id"] != null ? json["produk_id"] : "",
      qty: json["qty"] != null ? json["qty"] : "",
      catatan: json["catatan"] != null ? json["catatan"] : ""
    );
  }

  Map<String, dynamic> toJson() => {
    "produk_id":produk_id,
    "qty":qty,
    "catatan":catatan,
  };

}




// Demo data for our cart

// List<Cart> demoCarts = [
//   Cart(product: demoProducts[0], numOfItem: 2),
//   Cart(product: demoProducts[1], numOfItem: 1),
//   Cart(product: demoProducts[3], numOfItem: 1),
// ];
