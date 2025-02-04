

class PostResponseModel {
  final int api_status;
  final String api_message;
  // final String api_authorization;
  final int id;
  PostResponseModel({
    required this.api_status,
    required this.api_message,
    // required this.api_authorization,
    this.id = 0
  });

  factory PostResponseModel.fromJson(Map<String, dynamic> json){
    return PostResponseModel(
        api_status: json["api_status"],
        api_message: json["api_message"],
        // api_authorization: json["api_authorization"],
        id: json["id"],
    );
  }

}