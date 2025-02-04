class BidangModel {
  final String bidang,icon, photo, banner, id;
  bool isChecked;
  BidangModel({
    required this.id,
    required this.bidang,
    required this.photo,
    required this.banner,
    required this.icon,
    required this.isChecked
  });

  factory BidangModel.fromJson(Map<String, dynamic> json) {
    return BidangModel(
      id: json["id"] != null ? json["id"] : "",
      bidang: json["bidang"] != null ? json["bidang"] : "",
      icon: json["icon"] != null ? json["icon"] : "",
      photo: json["photo"] != null ? json["photo"] : "",
      banner: json["banner"] != null ? json["banner"] : "",
        isChecked: false
    );
  }
}
