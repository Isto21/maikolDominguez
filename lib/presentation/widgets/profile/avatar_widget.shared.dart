import 'dart:io';

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final double? scaleFactor;
  final Color borderColor;
  final double? size;
  final File? image;
  const AvatarWidget(
      {super.key,
      this.image,
      this.size,
      this.scaleFactor,
      required this.borderColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding:EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade400,
              blurStyle: BlurStyle.normal,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 5)),
          /*  BoxShadow(color: Colors.black,blurStyle: BlurStyle.inner,spreadRadius: 50),
          BoxShadow(color: Colors.black,blurStyle: BlurStyle.inner,spreadRadius: 50),
          BoxShadow(color: Colors.black,blurStyle: BlurStyle.inner,spreadRadius: 50), */
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: size ?? 50,
          backgroundColor: Colors.white,
          //constraints: BoxConstraints(maxHeight: size.height/8),
          // padding: const EdgeInsets.all(3),
          // decoration: BoxDecoration(color: borderColor),
          child: (image == null)
              ? Icon(
                  Icons.person_sharp,
                  size: size ?? 60,
                  color: const Color.fromRGBO(38, 0, 0, 1),
                )
              : Image.file(
                  image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  scale: scaleFactor ?? 0.8,
                ), //SvgPicture.asset('assets/icons/woman_icon.svg')
        ),
      ),
    );
  }
}
