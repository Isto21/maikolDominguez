import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.elevation = 1,
    this.color,
    this.radius = 12,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double elevation;
  final Color? color;
  final double radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Widget realChild = child;
    if (padding != null) {
      realChild = Padding(padding: padding!, child: child);
    }
    if (width != null || height != null) {
      realChild = SizedBox(width: width, height: height, child: realChild);
    }
    return Card(
      color: color,
      // surfaceTintColor: Colors.white,
      shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      elevation: elevation,
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // splashColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: realChild,
        ),
      ),
    );
  }
}
