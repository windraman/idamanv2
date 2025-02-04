
class ShortcutModel {
  final String icon, aksi, deskripsi, nama;
  final String id, ortu, utama, showText;
  final List<dynamic> ortunya;
  ShortcutModel({
    required this.id,
    required this.icon,
    required this.aksi,
    required this.deskripsi,
    required this.nama,
    required this.ortu,
    required this.utama,
    required this.showText,
    required this.ortunya
  });

  factory ShortcutModel.fromJson(Map<String, dynamic> json) {
    return ShortcutModel(
      id: json["id"] != null ? json["id"] : "",
      icon: json["icon"] != null ? json["icon"] : "",
      aksi: json["aksi"] != null ? json["aksi"] : "",
      deskripsi: json["deskripsi"] != null ? json["deskripsi"] : "",
      nama: json["nama"] != null ? json["nama"] : "",
      ortu: json["ortu"] != null ? json["ortu"] : "",
      utama: json["utama"] != null ? json["utama"] : "",
      showText: json["show_text"] != null ? json["show_text"] : "",
      ortunya: json["ortunya"] != null ? json["ortunya"] : "",
    );
  }
}
