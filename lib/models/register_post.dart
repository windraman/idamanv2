

class RegisterPostModel {
  String nik;
  String nama_lgkp;
  String no_telp;
  String password;
  String file_ktp;
  String file_selfie;


  RegisterPostModel({
    required this.nik,
    required this.nama_lgkp,
    required this.no_telp,
    required this.password,
    required this.file_ktp,
    required this.file_selfie,
  });


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'nik': nik,
      'nama_lgkp': nama_lgkp,
      'no_telp': no_telp,
      'password': password,
      'file_ktp': file_ktp,
      'file_selfie': file_selfie,
    };

    return map;
  }
}