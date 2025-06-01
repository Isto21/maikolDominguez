import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final String text;
  final Color colorText;
  final void Function()? onPress;
  final Widget? icon;
  const LogoutButton(
      {super.key,
      required this.text,
      required this.colorText,
      this.onPress,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: const Color.fromRGBO(251, 243, 243, 1)),
        onPressed: onPress,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 40, left: 40, bottom: 5, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null ? icon! : Container(),
              icon != null
                  ? const SizedBox(
                      width: 16,
                    )
                  : Container(),
              Text(
                text,
                style: TextStyle(
                    color: colorText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ));
  }
}
