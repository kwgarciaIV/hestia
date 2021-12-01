import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hestia/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hestia/Components/NavigationBar.dart';
import 'package:hestia/Components/BottomActions.dart';
import 'package:hestia/Components/SwipableBudgetCard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hestia/Database/budget_database.dart';
import 'package:hestia/Model/budget.dart';
import 'package:hestia/Screens/AddBudgetPopUp.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late List<Budget> budget;
  bool isLoading = false;
  late TooltipBehavior _tooltipBehavior;
  final balance = new MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');

  int? displayBudget;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        displayBudget = prefs.getInt('displayBudget');
      },
    );
  }

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'PHP');
    return format.currencySymbol;
  }

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    refreshTask();
    getData();
  }

  Future refreshTask() async {
    setState(() => isLoading = true);

    this.budget = await BudgetDatabase.instance.readAllBudget();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    String displayBudgetPref() {
      if (displayBudget != null)
        return '$displayBudget';
      else
        return 'nothing to return';
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
                        'Total Expenses:',
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
                          Container(
                            width: 180,
                            child: Text(
                              formatCurrency
                                  .format(int.parse(displayBudgetPref()))
                                  .replaceAll('\$', ''),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontFamily: 'Poppins-Regular',
                              ),
                            ),
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
                                  child: Text("No Expenses Entries",
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
                      Text('EXPENSES ORGANIZER', style: kTitle),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String budget = balance.text;
                          prefs.setString('currentBudget', budget);
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
                            ? Text('No Set Expenses', style: kLabelInputField)
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
