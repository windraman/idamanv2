import 'dart:convert';

class AkunModel {
  AkunModel({
    required this.cmsPrivilegesId,
    required this.name,
  });

  final String cmsPrivilegesId;
  final String name;

  factory AkunModel.fromJson(String str) => AkunModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AkunModel.fromMap(Map<String, dynamic> json) => AkunModel(
    cmsPrivilegesId: json["cms_privileges_id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "cms_privileges_id": cmsPrivilegesId,
    "name": name,
  };
}
