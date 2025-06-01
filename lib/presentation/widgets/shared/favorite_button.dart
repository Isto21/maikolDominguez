import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: 5,
      child: Container(
          width: 24,
          height: 24,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.3499999940395355),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.75),
            ),
          ),
          child: const Center(
              child: Icon(
            Icons.favorite,
            size: 12,
            color: Colors.red,
          ))),
    );
  }
}
