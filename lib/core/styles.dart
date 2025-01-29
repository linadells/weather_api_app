import 'package:flutter/material.dart';

const kBigText = TextStyle(
    fontFamily: 'FiraSans',
    fontWeight: FontWeight.bold,
    fontSize: 40,
    color: kWhiteColor);

const kMediumText = TextStyle(
    fontFamily: 'FiraSans',
    fontWeight: FontWeight.w300,
    fontSize: 25,
    color: kWhiteColor);

const kSmallText = TextStyle(
    fontFamily: 'FiraSans',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: kGreyColor);

const kGreyColor = Color.fromARGB(255, 48, 47, 47);
const kWhiteColor = Color.fromARGB(255, 239, 239, 239);

final kButtonStyle = ButtonStyle(
  textStyle: const WidgetStatePropertyAll(kSmallText),
  backgroundColor: const WidgetStatePropertyAll(kWhiteColor),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
  ),
);
