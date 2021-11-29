import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Database/inventory_database.dart';
import 'package:hestia/Model/inventory.dart';
import 'package:flutter/services.dart';
import 'package:hestia/Screens/InventoryPage.dart';

class EditInventoryPopUp extends StatefulWidget {
  final Inventory inventory;

  const EditInventoryPopUp({Key? key, required this.inventory})
      : super(key: key);

  @override
  _EditInventoryPopUpState createState() =>
      _EditInventoryPopUpState(inventory: inventory);
}

class _EditInventoryPopUpState extends State<EditInventoryPopUp> {
  _EditInventoryPopUpState({required this.inventory});

  final Inventory inventory;

  String valueInventoryMeasure = '';
  String valueInventoryCategory = '';

  final _formInventoryKey = GlobalKey<FormState>();

  final valueInventoryTitle = TextEditingController();
  final valueInventoryQuantity = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: kOffWhite,
          ),
          child: Form(
            key: _formInventoryKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Center(
                      child: Text(
                    'Edit Item',
                    style: kTitlePopUp,
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Item Name',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                      maxLength: 15,
                      scrollPadding: EdgeInsets.only(bottom: 40),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: kGrayTextField,
                        hintText: inventory.inventoryTitle,
                        hintStyle: kHintTextStyle,
                      ),
                      controller: valueInventoryTitle,
                      validator: (valueInventoryName) {
                        if (valueInventoryName == null ||
                            valueInventoryName.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Item Quantity',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                      maxLength: 2,
                      scrollPadding: EdgeInsets.only(bottom: 40),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: kGrayTextField,
                        hintText: inventory.inventoryQuantity.toString(),
                        hintStyle: kHintTextStyle,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: valueInventoryQuantity,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (valueInventoryQuantity) {
                        if (valueInventoryQuantity == null ||
                            valueInventoryQuantity.isEmpty) {
                          return 'Please enter some text';
                        } else
                          return null;
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Unit of Measure',
                    style: kLabelInputField,
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        hint: valueInventoryMeasure == ''
                            ? Text('Choose Unit of Measure')
                            : Text(
                                valueInventoryMeasure,
                                style: valueInventoryMeasure == ''
                                    ? kHintTextStyle
                                    : kInputTextStyle,
                              ),
                        isExpanded: true,
                        focusColor: Colors.white,
                        iconSize: 30.0,
                        style: valueInventoryMeasure == ''
                            ? kHintTextStyle
                            : kInputTextStyle,
                        items: [
                          'Pieces',
                          'Box',
                          'Pack',
                          'g',
                          'kg',
                        ].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        validator: (val) =>
                            val == null ? 'Select category <3' : null,
                        onChanged: (val) {
                          setState(
                            () {
                              valueInventoryMeasure = val.toString();
                            },
                          );
                        },
                      );
                    }),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Category',
                    style: kLabelInputField,
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          hint: valueInventoryCategory == ''
                              ? Text('Choose Item Category')
                              : Text(
                                  valueInventoryCategory,
                                  style: valueInventoryCategory == ''
                                      ? kHintTextStyle
                                      : kInputTextStyle,
                                ),
                          isExpanded: true,
                          focusColor: Colors.white,
                          iconSize: 30.0,
                          style: valueInventoryCategory == ''
                              ? kHintTextStyle
                              : kInputTextStyle,
                          items: [
                            'Beverages',
                            'Bread & Pastry',
                            'Breakfast & Cereal',
                            'Canned Goods & Soups',
                            'Condiments',
                            'Snacks & Candy',
                            'Dairy',
                            'Fruits & Vegetables',
                            'Pasta',
                            'Frozen Meat & Seafood',
                            'Miscellaneous',
                            'Paper Products',
                            'Cleaning Supplies',
                            'Health',
                            'Pet Care',
                            'Miscellaneous'
                          ].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          validator: (val) =>
                              val == null ? 'Select category <3' : null,
                          onChanged: (val) {
                            setState(
                              () {
                                valueInventoryCategory = val.toString();
                              },
                            );
                          },
                        );
                      },
                    ),
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
                Navigator.pop(
                  context,
                  EditInventoryPopUp(
                    inventory: inventory,
                  ),
                );
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
                if (_formInventoryKey.currentState!.validate()) {
                  addOrUpdateInventory();
                  print(valueInventoryTitle.text.toString());
                  print(valueInventoryQuantity.text.toString());
                  print(valueInventoryMeasure.toString());
                  print(valueInventoryCategory.toString());
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
                    'Save Item',
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

  Future updateInventory() async {
    final inventory = widget.inventory.copy(
      inventoryTitle: valueInventoryTitle.text.toString(),
      inventoryQuantity: int.parse(valueInventoryQuantity.text),
      inventoryCategory: valueInventoryCategory.toString(),
      inventoryMeasure: valueInventoryMeasure.toString(),
    );

    await InventoryDatabase.instance.update(inventory);
  }

  Future addInventory() async {
    final inventory = Inventory(
      inventoryTitle: valueInventoryTitle.text.toString(),
      inventoryQuantity: int.parse(valueInventoryQuantity.text),
      inventoryCategory: valueInventoryCategory.toString(),
      inventoryMeasure: valueInventoryMeasure.toString(),
    );

    await InventoryDatabase.instance.create(inventory);
  }

  void addOrUpdateInventory() async {
    final isValid = _formInventoryKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.inventory != null;

      if (isUpdating) {
        await updateInventory();
      } else {
        await addInventory();
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InventoryPage()),
      );
    }
  }
}
