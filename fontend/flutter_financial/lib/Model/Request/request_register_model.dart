class RequestRegisterModel {
  late final String username;
  late final String password;

  RequestRegisterModel({
    required this.username,
    required this.password,
  });

  factory RequestRegisterModel.fromJson(Map<String, dynamic> json) {
    return RequestRegisterModel(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

// {
//   "username": "SA",
//   "password": "SA"
// }
