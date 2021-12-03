import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Model/task.dart';
import 'package:hestia/Database/task_database.dart';
import 'package:hestia/Screens/HomePage.dart';
import 'package:audioplayers/audioplayers.dart';

class AddTaskPopUp extends StatefulWidget {
  final Task? task;

  const AddTaskPopUp({Key? key, this.task}) : super(key: key);

  @override
  _AddTaskPopUpState createState() => _AddTaskPopUpState();
}

class _AddTaskPopUpState extends State<AddTaskPopUp> {
  String? valueCategory;
  String error = 'This is required.';
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

  void playSound(String audio) {
    final player = AudioCache(prefix: 'audio/');
    player.play(audio);
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
                    'Save Task'.toUpperCase(),
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
                    style: kInputTextStyle,
                    maxLength: 15,
                    decoration: InputDecoration(
                      errorStyle: kErrorStyle,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: kGrayTextField,
                      hintText: 'Enter Task Title',
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
                    decoration: InputDecoration(
                      errorStyle: kErrorStyle,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: kGrayTextField,
                      hintText: 'Enter Task Description',
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            errorStyle: kErrorStyle,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          hint: valueCategory == null
                              ? Text('Choose Task Category')
                              : Text(
                                  valueCategory!,
                                  style: valueCategory == ''
                                      ? kHintTextStyle
                                      : kInputTextStyle,
                                ),
                          isExpanded: true,
                          focusColor: Colors.white,
                          iconSize: 30.0,
                          style: valueCategory == ''
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
                          validator: (val) => val == null ? error : null,
                          onChanged: (val) {
                            setState(
                              () {
                                valueCategory = val.toString();
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
                Navigator.pop(context, AddTaskPopUp());
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
                  playSound('AddTaskInventory.mp3');
                  addOrUpdateTask();
                  print(valueTaskTitle.text.toString());
                  print(valueTaskDescription.text.toString());
                  print(valueCategory.toString());
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
    final task = widget.task!.copy(
      taskTitle: valueTaskTitle.text.toString(),
      taskDescription: valueTaskDescription.text.toString(),
      taskCategory: valueCategory.toString(),
    );

    await TaskDatabase.instance.update(task);
  }

  Future addTask() async {
    final task = Task(
      taskTitle: valueTaskTitle.text.toString(),
      taskDescription: valueTaskDescription.text.toString(),
      taskCategory: valueCategory.toString(),
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}
