import 'package:bsi_info_apps/domain/entities/role.dart';

class ProfileEntitiy{
  String FirstName;
  String LastName ;
  String Address;
  String Email;
  String Telp;

  ProfileEntitiy({required this.FirstName, required this.LastName, required this.Address, required this.Email, required this.Telp});

  factory ProfileEntitiy.fromJson(Map<String, dynamic> json){
    try {
      return ProfileEntitiy(
        FirstName: json["FirstName"] ?? "Kosong",
        LastName: json["LastName"] ?? "Kosong",
        Address: json["Address"].toString() ?? "Kosong",
        Email: json["Email"].toString() ?? "Kosong",
        Telp: json["Telp"].toString() ?? "Kosong",);
    }
    catch (e) {
      throw const FormatException('Gagal membuat profile');
    }
  }
  String toString(){
    return
      "${FirstName},""${LastName},""${Address},""${Email}," "${Telp},";
  }
}