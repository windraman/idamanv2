

class ProdukImagePostModel {
  String parent_id;
  String file;
  String parent;
  String utama;


  ProdukImagePostModel({
    required this.parent_id,
    required this.file,
    required this.parent,
    required this.utama

  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'parent_id': parent_id,
      'file': file,
      'parent': parent,
      'utama': utama
    };

    return map;
  }
}