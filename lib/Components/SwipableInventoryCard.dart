import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hestia/constants.dart';

class SwipableInventoryCard extends StatefulWidget {
  SwipableInventoryCard(
      {@required this.itemTitle,
      @required this.category,
      @required this.quantity});
  String? itemTitle;
  String? category;
  int? quantity;

  @override
  _SwipableInventoryCardState createState() => _SwipableInventoryCardState(
      itemTitle: itemTitle, category: category, quantity: quantity);
}

class _SwipableInventoryCardState extends State<SwipableInventoryCard> {
  @override
  _SwipableInventoryCardState({this.itemTitle, this.category, this.quantity});

  String? itemTitle;
  String? category;
  int? quantity;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.

          // A pane can dismiss the Slidable.
          motion: const BehindMotion(),
          children: const [
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFF9AB6B4),
              foregroundColor: Colors.white,
              icon: Icons.mood,
              label: 'Add',
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
              icon: Icons.mood_bad,
              label: 'Subtract',
            ),
          ],
        ),

        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              itemTitle ?? "Null",
                              style: TextStyle(
                                color: kVeryDarkGreen,
                                fontSize: 25.0,
                                fontFamily: 'Poppins-Bold',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            color: kGrayButton,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(height: 50, width: 2, color: kGrayHeading),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 5),
                            child: Column(
                              children: [
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    color: kVeryDarkGreen,
                                    fontSize: 40.0,
                                    fontFamily: 'Montserrat-Bold',
                                  ),
                                ),
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                    color: kGrayHeading,
                                    fontSize: 12.0,
                                    fontFamily: 'Montserrat-SemiBold',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.more_vert,
                            size: 30,
                            color: Color(0xFF959595),
                          ),
                        ],
                      )
                    ],
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
