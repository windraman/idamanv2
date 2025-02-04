

class SingleResponseModel {
  final int api_status;
  final String api_message;
  // final String api_authorization;
  final String id;
  final String value;
  SingleResponseModel({
    required this.api_status,
    required this.api_message,
    // required this.api_authorization,
    required this.id,
    required this.value,
  });

  factory SingleResponseModel.fromJson(Map<String, dynamic> json){
    return SingleResponseModel(
        api_status: json["api_status"],
        api_message: json["api_message"],
        // api_authorization: json["api_authorization"],
        id: json["id"],
        value: json["value"]
    );
  }

}