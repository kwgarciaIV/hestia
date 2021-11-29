import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Database/budget_database.dart';
import 'package:hestia/Model/budget.dart';
import 'package:flutter/services.dart';
import 'package:hestia/Screens/BudgetPage.dart';

class AddBudgetPopUp extends StatefulWidget {
  final Budget? budget;

  const AddBudgetPopUp({Key? key, this.budget}) : super(key: key);

  @override
  _AddBudgetPopUpState createState() => _AddBudgetPopUpState();
}

class _AddBudgetPopUpState extends State<AddBudgetPopUp> {
  final _formBudgetKey = GlobalKey<FormState>();

  final valueBudgetTitle = TextEditingController();
  final valueBudgetQuantity = TextEditingController();
  final valueBudgetDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      decoration: InputDecoration(
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
                    'Category Budget',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: kGrayTextField,
                      hintText: 'Enter Budget Quantity',
                      hintStyle: kHintTextStyle,
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
                    decoration: InputDecoration(
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                    'Add to Budget',
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
    final budget = widget.budget!.copy(
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
