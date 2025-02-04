class WilayahModel {
  final String name,id,parent ;
  WilayahModel({
    required this.name,
    required this.id,
    this.parent = "0",

  });

  factory WilayahModel.fromJson(Map<String, dynamic> json) {
    return WilayahModel(
      name: json["name"] != null ? json["name"] : "",
      id: json["id"] != null ? json["id"] : "",
      parent: json["parent"] != null ? json["parent"] : ""

    );
  }
}
