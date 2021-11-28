import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hestia/constants.dart';
import 'package:hestia/Model/inventory.dart';
import 'package:hestia/Database/inventory_database.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hestia/Components/EditInventoryPopUp.dart';
import 'package:hestia/Screens/InventoryPage.dart';

class SwipableInventoryCard extends StatefulWidget {
  final Inventory inventory;
  final int index;

  const SwipableInventoryCard(
      {Key? key, required this.inventory, required this.index})
      : super(key: key);

  @override
  _SwipableInventoryCardState createState() =>
      _SwipableInventoryCardState(inventory: inventory, index: index);
}

class _SwipableInventoryCardState extends State<SwipableInventoryCard> {
  @override
  _SwipableInventoryCardState({required this.inventory, required this.index});

  final Inventory inventory;
  final int index;

  Widget build(BuildContext context) {
    return Slidable(
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
            icon: Icons.add_circle_outline_rounded,
            label: 'Add',
          ),
        ],
      ),
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.

        // A pane can dismiss the Slidable.
        motion: ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async {
            await InventoryDatabase.instance.delete(inventory.inventoryID!);
            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                type: PageTransitionType.fade,
                child: InventoryPage(),
              ),
              (route) => false,
            );
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
                            inventory.inventoryTitle,
                            style: kInventoryCardTitle,
                          ),
                        ),
                        Text(inventory.inventoryCategory,
                            style: kLabelInputField)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // Container(height: 50, width: 2, color: kGrayHeading),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 5),
                          child: Column(
                            children: [
                              Text(
                                inventory.inventoryQuantity.toString(),
                                style: kInventoryCardQuantity,
                              ),
                              Text(
                                inventory.inventoryMeasure,
                                style: kInventoryCardMeasure,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: EditInventoryPopUp(inventory: inventory),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: Color(0xFF959595),
                          ),
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
    );
  }
}

void doNothing(BuildContext context) {}
