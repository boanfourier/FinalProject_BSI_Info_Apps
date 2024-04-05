import 'package:bsi_info_apps/presentation/provider/profile_provider.dart';
import 'package:bsi_info_apps/presentation/provider/tasks_provider.dart';
import 'package:bsi_info_apps/presentation/screens/SplashScreen.dart';
import 'package:bsi_info_apps/data/datasource/bsiinfo_source.dart';
import 'package:bsi_info_apps/data/datasource/source.dart';
import 'package:bsi_info_apps/presentation/provider/events_provider.dart';
import 'package:bsi_info_apps/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:bsi_info_apps/presentation/screens/welcome_screen.dart';
import 'package:bsi_info_apps/presentation/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;
void setup(){
  getIt.registerSingleton<Source>(bsiinfoSource());
}

void main() {
  setup();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => EventsProvider()),
          ChangeNotifierProvider(create: (context) => TasksProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const SpalshScreen(),
    );
  }
}
