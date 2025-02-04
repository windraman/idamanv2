

class DelResponseModel {
  final int api_status;
  final String api_message;

  DelResponseModel({
    required this.api_status,
    required this.api_message
  });

  factory DelResponseModel.fromJson(Map<String, dynamic> json) {
    return DelResponseModel(
      api_status: json["api_status"] != null ? json["api_status"] : "",
      api_message: json["api_message"] != null ? json["api_message"] : ""
    );
  }
}