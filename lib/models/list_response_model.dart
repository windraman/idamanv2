

class ListResponseModel {
  final int api_status;
  final String api_message;
  final List<dynamic> data;

  ListResponseModel({
    required this.api_status,
    required this.api_message,
    required this.data,
  });

  factory ListResponseModel.fromJson(Map<String, dynamic> json) {
    return ListResponseModel(
      api_status: json["api_status"] != null ? json["api_status"] : "",
      api_message: json["api_message"] != null ? json["api_message"] : "",
      data: json["data"] != null ? json["data"] : "",
    );
  }
}