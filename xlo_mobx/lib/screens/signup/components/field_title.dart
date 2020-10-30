import 'package:flutter/material.dart';
import 'package:xlo_mobx/main.dart';

class FieldTitle extends StatelessWidget {

  FieldTitle({this.title, this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3, bottom: 4),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Text(
            '$title   ',
            style: TextStyle(
              color: heavyColor,
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),
          ),
          Text(
            '$subtitle',
            style: TextStyle(
              color: letterColor.withAlpha(120),
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
