import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hestia/Components/BottomActions.dart';
import 'package:hestia/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/NavigationBar.dart';
import '../Components/NotificationCard.dart';
import '../Components/SwipableTaskCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hestia/Model/task.dart';
import 'package:hestia/Database/task_database.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

//No NavBar button
//Cards not dismissive, still not a component
//Bottom NavBar no functionality

enum SelectedTab { add, home, weekly, inventory }

class HomePage extends StatefulWidget {
  HomePage({this.locationWeather});

  final locationWeather;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedTab = SelectedTab.home;
  late List<Task> task;
  bool isLoading = false;
  late int temperature = 0;

  //Quote archiving code
  Future getQuotesData() async {
    var response = await http.get(Uri.parse('https://type.fit/api/quotes'));

    //declare var json data
    var jsonData = jsonDecode(response.body);
    List<Quotes> quote = [];

    for (var q in jsonData) {
      Quotes quotes = Quotes(q['text'], q['author']);
      quote.add(quotes);
    }
    //to check whow many quotes
    //print(quote.length);
    return quote;
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
    });
  }

  void handleIndexChanged(int i) {
    setState(() {
      selectedTab = SelectedTab.values[i];
    });
  }

  String? displayName = '';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    refreshTask();
    getData();
  }

  Future refreshTask() async {
    setState(() => isLoading = true);

    this.task = await TaskDatabase.instance.readAllTasks();

    setState(() => isLoading = false);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        displayName = prefs.getString('displayName');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Date format : Month ##, ####
    var now = new DateTime.now();
    var formatter = new DateFormat.MMMMEEEEd();
    String formattedDate = formatter.format(now);
    int randomNumber = Random().nextInt(1644);

    //Temperature to string
    String temperatureString = temperature.toString();

    String display() {
      if (displayName != null)
        return "Hi $displayName!";
      else
        return "Hi!";
    }

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kOffWhite,
        appBar: AppBar(
          backgroundColor: kMainDarkGreen,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon:
                Image.asset('images/navigation_button_white.png', height: 20.0),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: NavigationBar(selectedPage: PageSelection.home),
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: new EdgeInsets.fromLTRB(30, 15, 0, 25),
                  decoration: BoxDecoration(
                    color: kMainDarkGreen,
                  ),
                  //constraints: BoxConstraints.expand(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        display(),
                        textAlign: TextAlign.left,
                        style: kHeading,
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'How are you feeling today?',
                        textAlign: TextAlign.left,
                        style: kSubHeading,
                      ),
                      Text(
                        temperatureString + ' °C',
                        textAlign: TextAlign.left,
                        style: kSubHeading,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: new EdgeInsets.fromLTRB(30, 20, 30, 30),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TASKS',
                        style: kTitle,
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 17,
                          color: kGrayButton,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : task.isEmpty
                                ? Text('No Tasks', style: kLabelInputField)
                                : buildTask(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'NOTIFICATIONS',
                          style: kTitle,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Card(
                            child: FutureBuilder(
                              future: getQuotesData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    color: kOffWhite,
                                    child: CircularProgressIndicator(),
                                  );
                                } else if ((((snapshot.data
                                            as dynamic)[randomNumber]
                                        .author)) ==
                                    null) {
                                  return NotificationCard(
                                      title: "Anonymous",
                                      categ: "Quotes",
                                      desc: (snapshot.data
                                              as dynamic)[randomNumber]
                                          .text);
                                } else if (((snapshot.data
                                                as dynamic)[randomNumber]
                                            .author)
                                        .length <
                                    18) {
                                  return NotificationCard(
                                      title: (((snapshot.data
                                              as dynamic)[randomNumber]
                                          .author)),
                                      categ: "Quotes",
                                      desc: (snapshot.data
                                              as dynamic)[randomNumber]
                                          .text);
                                } else {
                                  return NotificationCard(
                                      title: 'Thomas Edison',
                                      categ: 'Quotes',
                                      desc:
                                          'Genius is one percent inspiration and ninety-nine percent perspiration.');
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAction(),
      ),
    );
  }

  Widget buildTask() => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        itemCount: task.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final tasks = task[index];

          return GestureDetector(
            onTap: () {},
            child: Expanded(
              child: SwipableTaskCard(task: tasks, index: index),
            ),
          );
        },
      );
}

class Quotes {
  final String text, author;

  //Constructor for final var
  Quotes(this.text, this.author);
}
