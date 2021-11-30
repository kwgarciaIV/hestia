import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Model/task.dart';
import 'package:hestia/Database/task_database.dart';
import 'package:hestia/Screens/HomePage.dart';
import 'package:page_transition/page_transition.dart';

class EditTaskPopUp extends StatefulWidget {
  final Task task;

  const EditTaskPopUp({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskPopUpState createState() => _EditTaskPopUpState(task: task);
}

class _EditTaskPopUpState extends State<EditTaskPopUp> {
  _EditTaskPopUpState({required this.task});
  final Task task;
  String? dropDownValue;
  String error = 'This is required.';
  final _formTaskKey = GlobalKey<FormState>();
  late int taskID;

  TextEditingController valueTaskTitle = TextEditingController();
  TextEditingController valueTaskDescription = TextEditingController();

  @override
  void initState() {
    valueTaskTitle = TextEditingController()..text = task.taskTitle;
    valueTaskDescription = TextEditingController()..text = task.taskDescription;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          decoration: BoxDecoration(
            color: kOffWhite,
          ),
          child: Form(
            key: _formTaskKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Center(
                      child: Text(
                    'Edit Task'.toUpperCase(),
                    style: kTitlePopUp,
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Task Title',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                    maxLength: 15,
                    style: kInputTextStyle,
                    scrollPadding: EdgeInsets.only(bottom: 40),
                    decoration: InputDecoration(
                      errorStyle: kErrorStyle,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: kGrayTextField,
                      hintText: task.taskTitle,
                      hintStyle: kHintTextStyle,
                    ),
                    controller: valueTaskTitle,
                    validator: (valueTaskTitle) {
                      if (valueTaskTitle == null || valueTaskTitle.isEmpty) {
                        return error;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Task Description',
                    style: kLabelInputField,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: TextFormField(
                    style: kInputTextStyle,
                    scrollPadding: EdgeInsets.only(bottom: 40),
                    decoration: InputDecoration(
                      errorStyle: kErrorStyle,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: kGrayTextField,
                      hintText: task.taskDescription,
                      hintStyle: kHintTextStyle,
                    ),
                    maxLines: 6,
                    controller: valueTaskDescription,
                    validator: (valueTaskDescription) {
                      if (valueTaskDescription == null ||
                          valueTaskDescription.isEmpty) {
                        return error;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Task Category',
                    style: kLabelInputField,
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return DropdownButtonFormField<String>(
                          value: task.taskCategory,
                          decoration: InputDecoration(
                            errorStyle: kErrorStyle,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          hint: dropDownValue == null
                              ? Text(task.taskCategory)
                              : Text(
                                  dropDownValue!,
                                  style: dropDownValue == ''
                                      ? kHintTextStyle
                                      : kInputTextStyle,
                                ),
                          isExpanded: true,
                          focusColor: Colors.white,
                          iconSize: 30.0,
                          style: dropDownValue == ''
                              ? kHintTextStyle
                              : kInputTextStyle,
                          items: [
                            'Chores',
                            'Cleaning',
                            'Cooking',
                            'Meeting',
                            'Event',
                            'Appointment',
                            'Miscellaneous',
                            'Others'
                          ].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          validator: (val) =>
                              val == null || val.isEmpty ? error : null,
                          onChanged: (val) {
                            setState(
                              () {
                                dropDownValue = val.toString();
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
                Navigator.pop(context, EditTaskPopUp(task: task));
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
                    style: TextStyle(
                        fontFamily: 'Montserrat-SemiBold',
                        fontSize: 15.0,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            //"Add Task" Button
            GestureDetector(
              onTap: () {
                print('save button pressed');
                if (_formTaskKey.currentState!.validate()) {
                  addOrUpdateTask();
                  print(valueTaskTitle.text.toString());
                  print(valueTaskDescription.text.toString());
                  print(dropDownValue.toString());
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
                  child: Text('Save Task', style: kButtonSaveBack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateTask() async {
    final task = widget.task.copy(
      taskTitle: valueTaskTitle.text.toString(),
      taskDescription: valueTaskDescription.text.toString(),
      taskCategory: dropDownValue.toString(),
    );

    await TaskDatabase.instance.update(task);
  }

  Future addTask() async {
    final task = Task(
      taskTitle: valueTaskTitle.text.toString(),
      taskDescription: valueTaskDescription.text.toString(),
      taskCategory: dropDownValue.toString(),
    );

    await TaskDatabase.instance.create(task);
  }

  void addOrUpdateTask() async {
    final isValid = _formTaskKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.task != null;

      if (isUpdating) {
        await updateTask();
      } else {
        await addTask();
      }
      Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
          type: PageTransitionType.fade,
          child: HomePage(),
        ),
        (route) => false,
      );
    }
  }
}
