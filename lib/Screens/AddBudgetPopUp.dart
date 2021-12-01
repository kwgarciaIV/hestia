import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Database/budget_database.dart';
import 'package:hestia/Model/budget.dart';
import 'package:flutter/services.dart';
import 'package:hestia/Screens/BudgetPage.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBudgetPopUp extends StatefulWidget {
  final Budget? budget;

  const AddBudgetPopUp({Key? key, this.budget}) : super(key: key);

  @override
  _AddBudgetPopUpState createState() => _AddBudgetPopUpState();
}

class _AddBudgetPopUpState extends State<AddBudgetPopUp> {
  final _formBudgetKey = GlobalKey<FormState>();

  String error = 'This is required.';
  String currentBudget = '';

  final valueBudgetTitle = TextEditingController();
  final valueBudgetQuantity = new MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');
  final valueBudgetDescription = TextEditingController();

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

  String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'PHP');
    return format.currencySymbol;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
          decoration: BoxDecoration(
            color: kOffWhite,
          ),
          child: Form(
            key: _formBudgetKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Save Category'.toUpperCase(),
                    style: kTitlePopUp,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Category Name',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                      maxLength: 15,
                      style: kInputTextStyle,
                      decoration: InputDecoration(
                        errorStyle: kErrorStyle,
                        border: InputBorder.none,
                        filled: true,
                        fillColor: kGrayTextField,
                        hintText: 'Enter Name',
                        hintStyle: kHintTextStyle,
                      ),
                      controller: valueBudgetTitle,
                      validator: (valueBudgetTitle) {
                        if (valueBudgetTitle == null ||
                            valueBudgetTitle.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Category Expenses',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                    style: kInputTextStyle,
                    decoration: InputDecoration(
                      errorStyle: kErrorStyle,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: kGrayTextField,
                      hintText: 'Enter Budget Quantity',
                      hintStyle: kHintTextStyle,
                      prefixText: getCurrency() + '\t',
                      prefixStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: valueBudgetQuantity,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (valueBudgetQuantity) {
                      if (valueBudgetQuantity == null ||
                          valueBudgetQuantity.isEmpty) {
                        return error;
                      } else
                        return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Category Description',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                    style: kInputTextStyle,
                    decoration: InputDecoration(
                      errorStyle: kErrorStyle,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: kGrayTextField,
                      hintText: 'Enter Description',
                      hintStyle: kHintTextStyle,
                    ),
                    maxLines: 6,
                    controller: valueBudgetDescription,
                    validator: (valueBudgetDescription) {
                      if (valueBudgetDescription == null ||
                          valueBudgetDescription.isEmpty) {
                        return 'Please enter some text';
                      } else
                        return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: kOffWhite,
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //"Back" Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context, AddBudgetPopUp());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kGrayButton,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 40.0),
                  child: Text(
                    'Back',
                    style: kButtonSaveBack,
                  ),
                ),
              ),
            ),

            //"Add Task" Button
            GestureDetector(
              onTap: () {
                print('save button pressed');
                if (_formBudgetKey.currentState!.validate()) {
                  addOrUpdateBudget();
                  print(valueBudgetTitle.text.toString());
                  print(valueBudgetQuantity.text.toString());
                  print(valueBudgetDescription.toString());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kMainDarkGreen,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 40.0),
                  child: Text(
                    'Add to Expenses',
                    style: kButtonSaveBack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateBudget() async {
    String budgetQuantity =
        valueBudgetQuantity.text.replaceAll(new RegExp(r'[^0-9]'), '');

    final budget = widget.budget!.copy(
      budgetName: valueBudgetTitle.text.toString(),
      budgetQuantity: int.parse(budgetQuantity),
      budgetDescription: valueBudgetDescription.toString(),
    );

    await BudgetDatabase.instance.update(budget);
  }

  Future addBudget() async {
    String budgetQuantity =
        valueBudgetQuantity.text.replaceAll(new RegExp(r'[^0-9]'), '');
    SharedPreferences budgPref = await SharedPreferences.getInstance();
    budgPref.setInt(
        'displayBudget', displayBudget! + int.parse(budgetQuantity));

    final budget = Budget(
      budgetName: valueBudgetTitle.text.toString(),
      budgetQuantity: int.parse(budgetQuantity),
      budgetDescription: valueBudgetDescription.text.toString(),
    );

    await BudgetDatabase.instance.create(budget);
  }

  void addOrUpdateBudget() async {
    final isValid = _formBudgetKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.budget != null;

      if (isUpdating) {
        await updateBudget();
      } else {
        await addBudget();
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BudgetPage()),
      );
    }
  }
}
