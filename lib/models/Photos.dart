
import 'dart:convert';

class PhotoModel {
  final String id, parent_id, file, parent;
  final String utama, type, created_at;

  PhotoModel({
    required this.id,
    required this.parent_id,
    required this.file,
    required this.parent,
    required this.utama,
    required this.type,
    required this.created_at
  });

  factory PhotoModel.fromJson(String str) => PhotoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromMap(Map<String, dynamic> json) => PhotoModel(
    id: json["id"].toString(),
    parent_id: json["parent_id"].toString(),
    file: json["file"].toString(),
    parent: json["parent"].toString(),
    utama: json["utama"].toString(),
    created_at: json["created_at"].toString(),
    type: "network",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "parent_id": parent_id,
    "file": file,
    "parent": parent,
    "utama": utama,
    "created_at": created_at
  };
}