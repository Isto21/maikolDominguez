import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  final Widget leadingIcon;
  final String text;
  final Color colorText;
  final void Function()? function;
  const CustomListTitle(
      {super.key,
      required this.leadingIcon,
      required this.text,
      this.function,
      required this.colorText});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      title: Text(
        text,
        style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
      ),
      onTap: function,
    );
  }
}
