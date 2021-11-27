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

//No NavBar button
//Cards not dismissive, still not a component
//Bottom NavBar no functionality

enum SelectedTab { add, home, weekly, inventory }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedTab = SelectedTab.home;
  late List<Task> task;
  bool isLoading = false;

  void handleIndexChanged(int i) {
    setState(() {
      selectedTab = SelectedTab.values[i];
    });
  }

  String? displayName = '';

  @override
  void initState() {
    super.initState();

    refreshTask();
    getData();
  }

  void dispose() {
    TaskDatabase.instance.close();

    super.dispose();
  }

  Future refreshTask() async {
    setState(() => isLoading = true);

    this.task = await TaskDatabase.instance.readAllTasks();

    setState(() => isLoading = false);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
    });
  }

  @override
  Widget build(BuildContext context) {
    String display() {
      if (displayName != null)
        return "Hi $displayName !";
      else
        return "Hi!";
    }

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => Scaffold(
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
                        'October 23, Wednesday',
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
                        //Text(
                        //  'Task Length: ' + task.length.toString(),
                        //style: kLabelInputField)
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'NOTIFICATIONS',
                          style: kTitle,
                        ),
                      ),
                      NotificationCard(
                          title: 'Lorem Ipsum',
                          categ: 'Category',
                          desc: 'Lorem ipsum dolor sit amet, consectetur '),
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
