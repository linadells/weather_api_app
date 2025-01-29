import 'package:flutter/material.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/presentation/widgets/background.dart';
import 'package:weather_api_app/presentation/widgets/inputcity.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required TextEditingController cityController,
  }) : _cityController = cityController;

  final TextEditingController _cityController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreyColor,
        title: Text(
          'Weather App',
          style: kMediumText,
        ),
      ),
      body: BackgroundWidget(
        imageUrl: 'assets/images/background.jpg',
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [InputCityWidget(cityController: _cityController)],
            ),
          ),
        ),
      ),
    );
  }
}
