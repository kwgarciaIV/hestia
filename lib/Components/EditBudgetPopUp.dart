import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Database/budget_database.dart';
import 'package:hestia/Model/budget.dart';
import 'package:flutter/services.dart';
import 'package:hestia/Screens/BudgetPage.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class EditBudgetPopUp extends StatefulWidget {
  final Budget budget;

  const EditBudgetPopUp({Key? key, required this.budget}) : super(key: key);

  @override
  _EditBudgetPopUpState createState() => _EditBudgetPopUpState(budget: budget);
}

class _EditBudgetPopUpState extends State<EditBudgetPopUp> {
  _EditBudgetPopUpState({required this.budget});

  final Budget budget;
  final _formBudgetKey = GlobalKey<FormState>();

  String error = 'This is required.';

  TextEditingController valueBudgetTitle = TextEditingController();
  TextEditingController valueBudgetQuantity = TextEditingController();
  TextEditingController valueBudgetDescription = TextEditingController();

  @override
  void initState() {
    valueBudgetTitle = TextEditingController()..text = budget.budgetName;
    valueBudgetDescription = TextEditingController()
      ..text = budget.budgetDescription;
    valueBudgetQuantity = TextEditingController()
      ..text = budget.budgetQuantity.toString();
    super.initState();
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
                    'Edit Category'.toUpperCase(),
                    style: kTitlePopUp,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Remaining balance: P 3,000.00',
                    style: TextStyle(
                      fontFamily: 'Poppins-SemiBold',
                      fontSize: 15,
                      color: kGrayButton,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                        hintText: budget.budgetName,
                        hintStyle: kHintTextStyle,
                      ),
                      controller: valueBudgetTitle,
                      validator: (valueBudgetTitle) {
                        if (valueBudgetTitle == null ||
                            valueBudgetTitle.isEmpty) {
                          return error;
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Category Budget',
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
                      hintText: budget.budgetQuantity.toString(),
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
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (valueBudgetQuantity) {
                      if (valueBudgetQuantity == null ||
                          valueBudgetQuantity.isEmpty) {
                        return 'Please enter some text';
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
                      hintText: budget.budgetDescription,
                      hintStyle: kHintTextStyle,
                    ),
                    maxLines: 6,
                    controller: valueBudgetDescription,
                    validator: (valueBudgetDescription) {
                      if (valueBudgetDescription == null ||
                          valueBudgetDescription.isEmpty) {
                        return error;
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //"Back" Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context, EditBudgetPopUp(budget: budget));
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
                    'Save Category',
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
    final budget = widget.budget.copy(
      budgetName: valueBudgetTitle.text.toString(),
      budgetQuantity: int.parse(valueBudgetQuantity.text),
      budgetDescription: valueBudgetDescription.toString(),
    );

    await BudgetDatabase.instance.update(budget);
  }

  Future addBudget() async {
    final budget = Budget(
      budgetName: valueBudgetTitle.text.toString(),
      budgetQuantity: int.parse(valueBudgetQuantity.text),
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
