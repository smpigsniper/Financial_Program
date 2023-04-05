class RequestLoginModel {
  final String username;
  final String password;

  RequestLoginModel({
    required this.username,
    required this.password,
  });

  factory RequestLoginModel.fromJson(Map<String, dynamic> json) {
    return RequestLoginModel(
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
