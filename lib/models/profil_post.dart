

class ProfilPostModel {
  String id;
  String display_name;
  String photo;
  String email;
  String icon;
  String spesimen_tte;
  String sharing;


  ProfilPostModel({
    required this.id,
    required this.display_name,
    required this.photo,
    required this.email,
    required this.icon,
    required this.spesimen_tte,
    required this.sharing
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'display_name': display_name,
      'photo': photo,
      'email': email,
      'icon': icon,
      'spesimen_tte': spesimen_tte,
      'sharing' : sharing
    };

    return map;
  }
}