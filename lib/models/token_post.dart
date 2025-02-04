class TokenPostModel {
  String app_id,app_token;

  TokenPostModel({
    required this.app_id,
    required this.app_token,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'app_id': app_id,
      'app_token': app_token
    };

    return map;
  }
}