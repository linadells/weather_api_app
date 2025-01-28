import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/presentation/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);
    controller.forward();
    controller.addStatusListener((status) {
      if (status.isCompleted)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/location_background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Icon(
                      color: animation.value,
                      Icons.sunny,
                      size: 50,
                    );
                  },
                ),
                Text(
                  'Weather App',
                  style: kBigText,
                ),
              ],
            ),
            Text(
              'Kevych Solutions',
              style: kMediumText,
            )
          ],
        ),
      ),
    );
  }
}
