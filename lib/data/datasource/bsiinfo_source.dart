import 'dart:convert';

import 'package:bsi_info_apps/data/datasource/source.dart';
import 'package:http/http.dart' as http;

class bsiinfoSource extends Source{
  static const URL = "https://app.actualsolusi.com/bsi/Bsiinfo/api";

  @override
  Future<String> login(Map<String, dynamic> user) async{
    var response = await http.post(
        Uri.parse('$URL/User/login'),
        headers: {
          'accept' : '*/*',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'Username': user['username'],
          'Password': user['password']
        })
    );
    return response.body;
  }
  Future<String> getEventslist(Map<String, dynamic> user) async{
    var response = await http.get(
        Uri.parse('$URL/Events'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user['token']}'
        }
    );
    return response.body;
  }
  Future<String> getProfile(String username) async{
    var response = await  http.get(
        Uri.parse('$URL/User/${username}'),
      headers: <String,String>{
        'accept' : '*/*'
      }
    );
    return response.body;
  }
  Future<String> getTasklist(Map<String, dynamic> user) async{
    var response = await  http.get(
        Uri.parse('$URL/Tasks'),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user['token']}'
        }
    );
    return response.body;
  }
}