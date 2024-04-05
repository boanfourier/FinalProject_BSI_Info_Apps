import 'package:bsi_info_apps/domain/entities/role.dart';

class User{
  String username;
  String password = '';
  String token;

  List<Role> roles = [];

  User({required this.username, required this.token});

  factory User.fromJson(Map<String, dynamic> json){
    try{
      return User(username: json['Username'] ?? "Kosong", token: json['Token'] ?? "Kosong");
    } catch (e){
      throw ArgumentError(e);
    }
  }

  // factory User.fromJson(Map<String, dynamic> json){
  //   if (json.containsKey('Username') && json.containsKey('Token')) {
  //     return User(username: json['Username'], token: json['Token']);
  //   } else {
  //     throw const FormatException('Gagal membuat user');
  //   }
  // }

  Map<String, dynamic> toJson(){
    return {
      'username': this.username,
      'password': this.password,
      'token': this.token
    };
  }

  void info(){
    print('username: $username, token: $token');
  }
}