import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bsi_info_apps/presentation/provider/profile_provider.dart';
import 'package:bsi_info_apps/presentation/screens/signin_screen.dart';
import 'package:bsi_info_apps/presentation/screens/welcome_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  late Future<void> _prefsInitialized;

  @override
  void initState() {
    super.initState();
    _prefsInitialized = initializePrefs();
    Provider.of<ProfileProvider>(context, listen: false).getProfile();

  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _prefsInitialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,

                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.lightBlueAccent,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Konfirmasi Logout",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            "Apakah Anda yakin ingin keluar?",
                            style: TextStyle(fontSize: 20),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                "Batal",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () async {
                                await prefs.remove('username');
                                await prefs.remove('token');
                                Provider.of<ProfileProvider>(context, listen: false).clearListProfile();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(),
                                  ),
                                      (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<ProfileProvider>(
                builder: (context, provider, child) {
                  if (provider.listProfile == null || provider.listProfile!.isEmpty) {
                    return Center(
                      child: Text(
                        'No profile data available',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final event = provider.listProfile![0]; // Ambil data profil pertama

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/images/user_avatar.jpg'), // Ganti dengan path gambar profil
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${event.FirstName.toString()} ${event.LastName.toString()}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 12),

                        Text(
                          'Address: ${event.Address.toString()}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Email: ${event.Email.toString()}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Phone: ${event.Telp.toString()}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          );
        }
      },
    );
  }

  void logout() {
    prefs?.setString('username', '');
    prefs?.setString('token', '');
    prefs.remove('username');
    prefs.remove('token');
    prefs.setBool('isLogin', false);
  }
}
