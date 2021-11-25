import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hestia/constants.dart';

class SwipableTaskCard extends StatefulWidget {
  SwipableTaskCard({this.taskTitle, this.taskType, this.taskDesc});

  String? taskTitle;
  String? taskType;
  String? taskDesc;
  @override
  _SwipableTaskCardState createState() => _SwipableTaskCardState(
      taskTitle: taskTitle, taskType: taskType, taskDesc: taskDesc);
}

class _SwipableTaskCardState extends State<SwipableTaskCard> {
  _SwipableTaskCardState({this.taskTitle, this.taskType, this.taskDesc});
  String? taskTitle;
  String? taskType;
  String? taskDesc;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.

        // A pane can dismiss the Slidable.
        motion: ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
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

      endActionPane: ActionPane(
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
      ),

      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
                          new TextSpan(text: taskTitle, style: kCardTitle),
                          new TextSpan(
                            text: taskType,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins-Bold',
                              color: kGrayButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(taskDesc ?? "null", style: kCardDesc),
                  ],
                ),
                Icon(
                  Icons.more_vert,
                  size: 30,
                  color: Color(0xFF959595),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
