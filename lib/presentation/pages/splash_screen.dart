import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.add_box),
                Text('Weather App'),
              ],
            ),
            Text('Kevych Solutions')
          ],
        ),
      ),
    );
  }
}
