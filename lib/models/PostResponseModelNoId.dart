

class PostResponseModelNoId {
  final int api_status;
  final String api_message;
  // final String api_authorization;
  PostResponseModelNoId({
    required this.api_status,
    required this.api_message,
    // required this.api_authorization,
  });

  factory PostResponseModelNoId.fromJson(Map<String, dynamic> json){
    return PostResponseModelNoId(
        api_status: json["api_status"],
        api_message: json["api_message"],
        // api_authorization: json["api_authorization"],
    );
  }

}