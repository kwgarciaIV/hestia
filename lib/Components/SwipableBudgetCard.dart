import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hestia/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hestia/Database/budget_database.dart';
import 'package:hestia/Model/budget.dart';
import 'package:hestia/Screens/BudgetPage.dart';
import 'package:hestia/Screens/EditBudgetPopUp.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

final formatCurrency = new NumberFormat.simpleCurrency();

class SwipableBudgetCard extends StatefulWidget {
  final Budget budget;
  final int index;

  const SwipableBudgetCard(
      {Key? key, required this.budget, required this.index})
      : super(key: key);

  @override
  _SwipableBudgetCardState createState() =>
      _SwipableBudgetCardState(budget: budget, index: index);
}

class _SwipableBudgetCardState extends State<SwipableBudgetCard> {
  @override
  _SwipableBudgetCardState({required this.budget, required this.index});

  final Budget budget;
  final int index;

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'PHP');
    return format.currencySymbol;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  int? displayBudget;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        displayBudget = prefs.getInt('displayBudget');
      },
    );
  }

  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async {
            await BudgetDatabase.instance.delete(budget.budgetID!);
            SharedPreferences budgPref = await SharedPreferences.getInstance();
            budgPref.setInt(
                'displayBudget', displayBudget! - budget.budgetQuantity);
            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                type: PageTransitionType.fade,
                child: BudgetPage(),
              ),
              (route) => false,
            );
          },
        ),
        children: const [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF9AB6B4),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        budget.budgetName,
                        style: kBudgetCardTitle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        getCurrency() + '',
                        style: TextStyle(
                          color: kMainDarkGreen,
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        formatCurrency
                            .format(budget.budgetQuantity)
                            .replaceAll('\$', ''),
                        style: kBudgetCardTitle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: EditBudgetPopUp(budget: budget),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.more_vert,
                          size: 30,
                          color: Color(0xFF959595),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
