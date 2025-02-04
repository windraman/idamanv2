class RegisterModel {
  final String nik,nama_lgkp, no_telp, password, otp;
  RegisterModel({
    required this.nik,
    required this.nama_lgkp,
    required this.no_telp,
    required this.password,
    required this.otp
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      nik: json["nik"] != null ? json["nik"] : "",
      nama_lgkp: json["nama_lgkp"] != null ? json["nama_lgkp"] : "",
      no_telp: json["no_telp"] != null ? json["no_telp"] : "",
      password: json["password"] != null ? json["password"] : "",
      otp: json["otp"] != null ? json["otp"] : "",
    );
  }
}
