import 'package:bsi_info_apps/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:bsi_info_apps/presentation/provider/events_provider.dart';
import 'package:bsi_info_apps/presentation/provider/tasks_provider.dart';
import 'package:bsi_info_apps/domain/entities/events.dart';
import 'package:bsi_info_apps/domain/entities/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _showEventDetailsDialog(EventsEntity event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Provider.of<EventsProvider>(context, listen: false).getEvents();
        });
        return AlertDialog(
          title: Text(event.event_name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Description: ${event.description}'),
                SizedBox(height: 10),
                Text('Start Date: ${event.start_date}'),
                Text('End Date: ${event.end_date}'),
                Text('Location ID: ${event.location_id}'),
                Text('Organizer ID: ${event.organizer_id}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTaskDetailsDialog(TasksEntity task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Provider.of<TasksProvider>(context, listen: false).getTasks();
        });
        return AlertDialog(
          title: Text('Task Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Event ID: ${task.event_id}'),
                SizedBox(height: 10),
                Text('Description: ${task.description}'),
                SizedBox(height: 10),
                Text('Deadline: ${task.deadline}'),
                SizedBox(height: 10),
                Text('Status: ${task.status}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
    });
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
                    radius: 40,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      final event = provider.listProfile![0];
                      return Text(
                        '${event.FirstName.toString()} ${event.LastName.toString()}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 240,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Consumer<EventsProvider>(
                    builder: (context, provider, child) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Provider.of<EventsProvider>(context, listen: false).getEvents();
                      });
                      if (provider.listEvents.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16/9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        items: provider.listEvents.map((event) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  _showEventDetailsDialog(event);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          event.event_name,
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Date: ${event.start_date}',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        ElevatedButton(
                                          onPressed: () {
                                            _showEventDetailsDialog(event);
                                          },
                                          child: Text(
                                            'Details',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Dashboard Content',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Consumer<TasksProvider>(
                    builder: (context, provider, child) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Provider.of<TasksProvider>(context, listen: false).getTasks();
                      });
                      if (provider.listTasks.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16/9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        items: provider.listTasks.map((task) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        task.event_id,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Description: ${task.description}',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      SizedBox(height: 5),
                                      ElevatedButton(
                                        onPressed: () {
                                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                            _showTaskDetailsDialog(task);
                                          });
                                        },
                                        child: Text(
                                          'Details',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
