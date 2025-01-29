import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final String imageUrl;
  final Widget child;
  const BackgroundWidget({required this.child, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
        ),
        child: child);
  }
}
