

class KeranjangResponseModel {
  final int api_status;
  int total = 0;
  int numOfItems = 0;
  final String error;
  final int tarif_per_km;
  final double avg_jarak;
  final int biaya_kurir;
  final String api_message;
  final List<dynamic> data;

  KeranjangResponseModel({
    required this.data,
    required this.numOfItems,
    required this.api_status,
    required this.api_message,
    required this.total,
    required this.error,
    required this.avg_jarak,
    required this.tarif_per_km,
    required this.biaya_kurir
  });

  factory KeranjangResponseModel.fromJson(Map<String, dynamic> json) {
    //print("periksa : ${json["biaya_kurir"]}");
    return KeranjangResponseModel(
      api_status: json["api_status"] != null ? json["api_status"] : 0,
      api_message: json["api_message"] != null ? json["api_message"] : "",
      numOfItems: json["numOfItems"] != null ? json["numOfItems"] : 0.0,
      total: json["total"] != null ? json["total"] : 0.0,
       error: json["error"] != null ? json["error"] : "none",
      avg_jarak: json["avg_jarak"] != null ? double.parse(json["avg_jarak"].toString()) : 0.0,
      tarif_per_km: json["tarif_per_km"] != null ? json["tarif_per_km"] : 0,
      biaya_kurir: json["biaya_kurir"] != null ? json["biaya_kurir"] : 0,
      data: json["data"] != null ? json["data"]: "",
    );
  }
}

class KeranjangCountModel {
  final int api_status;
  int numOfItems = 0;
  int belanjaan = 0;

  KeranjangCountModel({
    required this.numOfItems,
    required this.api_status,
    required this.belanjaan
  });

  factory KeranjangCountModel.fromJson(Map<String, dynamic> json) {
    return KeranjangCountModel(
      api_status: json["api_status"] != null ? json["api_status"] : 0,
      numOfItems: json["numOfItems"] != null ? json["numOfItems"] : 0,
      belanjaan: json["belanjaan"] != null ? json["belanjaan"] : 0
    );
  }
}

