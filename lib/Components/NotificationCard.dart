import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.title,
    required this.categ,
    required this.desc,
  }) : super(key: key);

  final String title;
  final String categ;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: kCardTitle,
                ),
                Text(
                  categ,
                  style: kCardCateg,
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                desc,
                style: kCardDesc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
