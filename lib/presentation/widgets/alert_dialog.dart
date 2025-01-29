import 'package:flutter/material.dart';
import 'package:weather_api_app/core/styles.dart';
import 'package:weather_api_app/presentation/bloc/weather_bloc/weather_bloc.dart';

Future<dynamic> buildAlertDialog(
    {required BuildContext context,
    required String errorTitle,
    required String errorText,
    required List<Widget> actions}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(errorTitle),
        backgroundColor: kGreyColor,
        titleTextStyle: kBigText,
        contentTextStyle: kMediumText,
        content: Text(errorText),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actions,
          ),
        ],
      );
    },
  );
}
