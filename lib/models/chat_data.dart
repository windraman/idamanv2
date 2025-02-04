import 'dart:convert';


class ChatDataModel{
  final String nama_table;
  final String key_id;
  final String user_id;
  final Map<String, dynamic> detail;
  ChatDataModel({
    required this.nama_table,
    required this.key_id,
    required this.user_id,
    required this.detail,
  });

  factory ChatDataModel.fromJson(Map<String, dynamic> json){
    return ChatDataModel(
        nama_table: json["nama_table"],
        key_id: json["key_id"],
        user_id: json["user_id"],
        detail: jsonDecode(json["detail"])
    );
  }
}