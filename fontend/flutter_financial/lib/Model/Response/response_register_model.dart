class ResponseRegisterModel {
  final int status;
  final String reason;

  ResponseRegisterModel(
    this.status,
    this.reason,
  );

  ResponseRegisterModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as int,
        reason = json['reason'];

  Map<String, dynamic> toJson() => {'status': status, 'reason': reason};
}

//{ "status": 1, "reason": ""}
