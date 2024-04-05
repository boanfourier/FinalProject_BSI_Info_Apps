import 'package:bsi_info_apps/domain/entities/profile.dart';
import 'package:bsi_info_apps/domain/entities/user.dart';
import 'package:bsi_info_apps/domain/use_case/get_all_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  late List<ProfileEntitiy> listProfile = [];
  late SharedPreferences prefs;

  ProfileProvider() {
    _init();
  }

  void _init() async {
    prefs = await SharedPreferences.getInstance();
    getProfile();
  }

  void clearListProfile() async {
    listProfile.clear();
    notifyListeners();
  }

  void getProfile() async {
    var username = prefs.getString('username') ?? '';
    var token = prefs.getString('token') ?? '';

    ProfileEntitiy profile = await GetAllProfileInfo().execute(User(username: username, token: token));
    print(profile.FirstName);
    print(profile.LastName);
    listProfile.add(profile);
    notifyListeners();
  }
}
