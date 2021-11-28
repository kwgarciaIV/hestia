import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hestia/Components/AddTaskPopUp.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Model/task.dart';
import 'package:hestia/Database/task_database.dart';

class SwipableTaskCard extends StatefulWidget {
  final Task task;
  final int index;

  const SwipableTaskCard({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  @override
  _SwipableTaskCardState createState() =>
      _SwipableTaskCardState(task: task, index: index);
}

class _SwipableTaskCardState extends State<SwipableTaskCard> {
  _SwipableTaskCardState({required this.task, required this.index});
  final Task task;
  final int index;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: Key(task.toString()),

        // The start action pane is the one at the left or the top side.
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.

          // A pane can dismiss the Slidable.
          motion: ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () async {
              await TaskDatabase.instance.delete(task.taskID!);
              //await TaskDatabase.instance.deleteAll();
              //Navigator.of(context).pop();
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

        /*       startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFFDFC3A2),
              foregroundColor: Colors.white,
              icon: Icons.edit_rounded,
              label: 'Edit',
            ),
          ],
        ),*/

        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: new TextSpan(
                          style: new TextStyle(),
                          children: <TextSpan>[
                            new TextSpan(
                                text: task.taskTitle + '\t', style: kCardTitle),
                            new TextSpan(
                              text: task.taskCategory,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins-Bold',
                                color: kGrayButton,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(task.taskDescription, style: kCardDesc),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        // isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return AddTaskPopUp();
                        },
                      );
                    },
                    child: Icon(
                      Icons.more_vert,
                      size: 30,
                      color: Color(0xFF959595),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
