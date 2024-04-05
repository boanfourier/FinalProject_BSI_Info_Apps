
import 'package:bsi_info_apps/domain/entities/events.dart';
import 'package:bsi_info_apps/domain/entities/user.dart';
import 'package:bsi_info_apps/domain/use_case/get_all_events_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsProvider extends ChangeNotifier{
  var listEvents = <EventsEntity>[];
  SharedPreferences? prefs = null;

  void getEvents() async{
    prefs = await SharedPreferences.getInstance();
    var username = await prefs?.getString('username') ?? '';
    var token = await prefs?.getString('token') ?? '';

    listEvents = await GetAllEventsInfo().execute(User(username: username, token: token));
    notifyListeners();
  }
}