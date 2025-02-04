

class StatsResposeModel {
  final int api_status;
  final String api_message;
  final int usaha,pemilik_usaha_lokal,pemilik_usaha_luar,nonekraf,ekraf;
  StatsResposeModel({
    required this.api_status,
    required this.api_message,
    required this.usaha,
    required this.pemilik_usaha_lokal,
    required this.pemilik_usaha_luar,
    required this.nonekraf,
    required this.ekraf
  });

  factory StatsResposeModel.fromJson(Map<String, dynamic> json){
    return StatsResposeModel(
        api_status: json["api_status"],
        api_message: json["api_message"],
        pemilik_usaha_luar: json["pemilik_usaha_luar"],
        pemilik_usaha_lokal: json["pemilik_usaha_lokal"],
        nonekraf: json["nonekraf"],
        ekraf: json["ekraf"],
        usaha: json["usaha"],
    );
  }

}