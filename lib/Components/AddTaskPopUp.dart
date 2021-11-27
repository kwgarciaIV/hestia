import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Model/task.dart';
import 'package:hestia/Database/task_database.dart';

class AddTaskPopUp extends StatefulWidget {
  final Task? task;

  const AddTaskPopUp({Key? key, this.task}) : super(key: key);

  @override
  _AddTaskPopUpState createState() => _AddTaskPopUpState();
}

class _AddTaskPopUpState extends State<AddTaskPopUp> {
  String? dropDownValue;

  final _formTaskKey = GlobalKey<FormState>();
  late int taskID;
  late String taskTitle;
  late String taskDescription;
  late String taskCategory;

  final valueTaskTitle = TextEditingController();
  final valueTaskDescription = TextEditingController();

  @override
  void initState() {
    super.initState();

    taskID = widget.task?.taskID ?? 0;
    taskTitle = widget.task?.taskTitle ?? '';
    taskDescription = widget.task?.taskDescription ?? '';
    taskCategory = widget.task?.taskCategory ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kOffWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Form(
        key: _formTaskKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Center(
                child: Text(
              'Save Task',
              style: TextStyle(
                fontFamily: 'Montserrat-Bold',
                fontSize: 20.0,
                color: kVeryDarkGreen,
              ),
            )),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: kGrayTextField,
                  hintText: 'Enter Task Title',
                  hintStyle: kHintTextStyle,
                ),
                controller: valueTaskTitle,
                validator: (valueTaskTitle) {
                  if (valueTaskTitle == null || valueTaskTitle.isEmpty) {
                    return 'Please enter some text';
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: kGrayTextField,
                  hintText: 'Enter Task Description',
                  hintStyle: kHintTextStyle,
                ),
                controller: valueTaskDescription,
                validator: (valueTaskDescription) {
                  if (valueTaskDescription == null ||
                      valueTaskDescription.isEmpty) {
                    return 'Please enter some text';
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
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return DropdownButtonFormField<String>(
                  hint: dropDownValue == null
                      ? Text('Choose Task Category')
                      : Text(
                          dropDownValue!,
                          style: dropDownValue == ''
                              ? kHintTextStyle
                              : kInputTextStyle,
                        ),
                  isExpanded: true,
                  focusColor: Colors.white,
                  iconSize: 30.0,
                  style: dropDownValue == '' ? kHintTextStyle : kInputTextStyle,
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
                  validator: (val) => val == null ? "Select category <3" : null,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //"Back" Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, AddTaskPopUp());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kGrayButton,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 40.0),
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
                            vertical: 5.0, horizontal: 40.0),
                        child: Text(
                          'Save Task',
                          style: TextStyle(
                              fontFamily: 'Montserrat-SemiBold',
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future updateTask() async {
    final task = widget.task!.copy(
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
      Navigator.of(context).pop();
    }
  }
}
