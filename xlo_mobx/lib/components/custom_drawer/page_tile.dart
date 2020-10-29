import 'package:flutter/material.dart';
import 'package:xlo_mobx/main.dart';

class PageTile extends StatelessWidget {

  PageTile({this.label, this.iconData, this.onTap, this.highlighted});

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: highlighted
                ? heavyColor
                : Colors.black38,
          ),
      ),
      leading: Icon(
        iconData,
        color: highlighted
            ? heavyColor
            : Colors.black38,
      ),
      onTap: onTap,
    );
  }

}
