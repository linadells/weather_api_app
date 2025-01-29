import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/presentation/bloc/geo_bloc/geo_bloc.dart';
import 'package:weather_api_app/presentation/bloc/weather_bloc/weather_bloc.dart';

class InputCityWidget extends StatelessWidget {
  const InputCityWidget({
    super.key,
    required TextEditingController cityController,
  }) : _cityController = cityController;

  final TextEditingController _cityController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<GeoBloc, GeoState>(builder: (context, geoState) {
          return Expanded(
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue val) {
                if (val.text.isEmpty) {
                  return [];
                }
                BlocProvider.of<GeoBloc>(context).add(GetCitiesEvent(val.text));
                if (geoState is GeoSuggestionsState) {
                  return geoState.cities;
                }
                return [];
              },
              onSelected: (String selectedVal) {
                _cityController.text = selectedVal;
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                _cityController.text = controller.text;
                return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    decoration: kTextFieldDecoration);
              },
            ),
          );
        }),
        IconButton(
          icon: Icon(Icons.search, color: kWhiteColor),
          onPressed: () {
            BlocProvider.of<WeatherBloc>(context).add(
              GetWeatherOfCityEvent(_cityController.text),
            );
            _cityController.text = '';
          },
        ),
      ],
    );
  }
}
