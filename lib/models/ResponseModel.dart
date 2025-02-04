

class ResponseModel {
  final int api_status;
  final String api_message;
  // final String api_authorization;
  final List<dynamic> data;
  ResponseModel({
    required this.api_status,
    required this.api_message,
    // required this.api_authorization,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json){
    return ResponseModel(
        api_status: json["api_status"],
        api_message: json["api_message"],
        // api_authorization: json["api_authorization"],
        data: json["data"]
    );
  }

}