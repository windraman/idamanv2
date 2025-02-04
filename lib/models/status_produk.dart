class StatusProdukModel {
  int id;
  String name;

  StatusProdukModel({required this.id, required this.name});

  static List<StatusProdukModel> getStatusProduk() {
    return <StatusProdukModel>[
      StatusProdukModel(id: 1, name: "Tersedia"),
      StatusProdukModel(id: 0, name: "Habis"),
      StatusProdukModel(id: -1, name: "Sembunyikan")
    ];
  }
}