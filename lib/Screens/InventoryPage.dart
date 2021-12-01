import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hestia/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/NavigationBar.dart';
import 'package:hestia/Components/BottomActions.dart';
import '../Components/SwipableInventoryCard.dart';
import 'package:hestia/Screens/AddInventoryPopUp.dart';
import 'package:hestia/Database/inventory_database.dart';
import 'package:hestia/Model/inventory.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  _InventoryPageState({this.selectedPage});
  PageSelection? selectedPage;

  late List<Inventory> inventory;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshTask();
  }

  Future refreshTask() async {
    setState(() => isLoading = true);

    this.inventory = await InventoryDatabase.instance.readAllInventory();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
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
                  child: NavigationBar(selectedPage: PageSelection.inventory),
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
                    padding: new EdgeInsets.fromLTRB(30, 20, 0, 25),
                    decoration: BoxDecoration(
                      color: kMainDarkGreen,
                    ),
                    //constraints: BoxConstraints.expand(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Food Inventory',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: kGold,
                                fontSize: 32.0,
                                fontFamily: 'Poppins-Bold',
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              'Track your food items here',
                              textAlign: TextAlign.left,
                              style: kSubHeading,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 30),
                              child: FloatingActionButton(
                                //to be replaced by an icon
                                child: Text('+',
                                    style: TextStyle(
                                      color: kMainDarkGreen,
                                      fontSize: 40,
                                    )),
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: AddInventoryPopUp(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: new EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : inventory.isEmpty
                            ? Text('No Items', style: kLabelInputField)
                            : buildInventory(),
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

  Widget buildInventory() => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        crossAxisCount: 1,
        itemCount: inventory.length,
        shrinkWrap: true,
        mainAxisSpacing: 10,
        itemBuilder: (context, index) {
          final inventories = inventory[index];

          return GestureDetector(
            onTap: () {},
            child: Expanded(
              child:
                  SwipableInventoryCard(inventory: inventories, index: index),
            ),
          );
        },
      );
}
