class ResponseLoginModel {
  final int status;
  final String reason;
  final String username;
  final String accessToken;

  ResponseLoginModel(
    this.status,
    this.reason,
    this.username,
    this.accessToken,
  );

  ResponseLoginModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as int,
        reason = json['reason'],
        username = json['username'],
        accessToken = json['accessToken'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'reason': reason,
        'username': username,
        'accessToken': accessToken
      };
}

// { "status": 1, "reason": "", "username": "", "accessToken": "" }
