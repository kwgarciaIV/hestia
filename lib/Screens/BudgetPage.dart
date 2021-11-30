import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hestia/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/NavigationBar.dart';
import 'package:hestia/Components/BottomActions.dart';
import '../Components/SwipableBudgetCard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hestia/Database/budget_database.dart';
import 'package:hestia/Model/budget.dart';
import 'package:hestia/Components/AddBudgetPopUp.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:syncfusion_flutter_charts/charts.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late List<Budget> budget;
  bool isLoading = false;
  late TooltipBehavior _tooltipBehavior;
  var myRichRunesMessage = new Runes('\u20b1');

  Map<String, double> dataMap = {
    "All": 20000.0,
    "Malls": 2000.0,
    "Xamarin": 4000.0,
    "Ionic": 10000,
  };

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    refreshTask();
  }

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'PHP');
    return format.currencySymbol;
  }

  Future refreshTask() async {
    setState(() => isLoading = true);

    this.budget = await BudgetDatabase.instance.readAllBudget();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
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
                  child: NavigationBar(selectedPage: PageSelection.budget),
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
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 32),
                  decoration: BoxDecoration(
                    color: kMainDarkGreen,
                  ),
                  //constraints: BoxConstraints.expand(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Balance:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: kGold,
                          fontSize: 22.0,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            getCurrency(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            // ' ${String.fromCharCode(0x0020B1)} '
                            '70,000.00',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          FaIcon(
                            FontAwesomeIcons.pen,
                            color: kOffWhite,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        color: kOffWhite,
                        height: 300,
                        child: budget.isNotEmpty
                            ? SfCircularChart(
                                legend: Legend(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                    fontFamily: 'Montserrat-Bold',
                                    fontSize: 18,
                                    color: kVeryDarkGreen,
                                  ),
                                ),
                                tooltipBehavior: _tooltipBehavior,
                                series: <CircularSeries>[
                                  PieSeries<Budget, String>(
                                    dataSource: budget,
                                    xValueMapper: (Budget budget, _) =>
                                        budget.budgetName,
                                    yValueMapper: (Budget budget, _) =>
                                        budget.budgetQuantity,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(
                                        fontFamily: 'Montserrat-Bold',
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                color: kOffWhite,
                                height: 50.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("No Budget Entries",
                                      style: kLabelInputField),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('BUDGET ORGANIZER', style: kTitle),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: AddBudgetPopUp(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: kMainDarkGreen,
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            color: kOffWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: new EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : budget.isEmpty
                            ? Text('No Set Budget', style: kLabelInputField)
                            : buildBudget(),
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

  Widget buildBudget() => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        crossAxisCount: 1,
        itemCount: budget.length,
        shrinkWrap: true,
        mainAxisSpacing: 10,
        itemBuilder: (context, index) {
          final budgets = budget[index];

          return GestureDetector(
            onTap: () {},
            child: Expanded(
              child: SwipableBudgetCard(budget: budgets, index: index),
            ),
          );
        },
      );
}
