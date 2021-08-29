import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:online_chat/ui/size_config.dart';

const kPrimaryColor = Color.fromRGBO(143, 148, 251, 1);
const kSecondaryColor = Color.fromRGBO(43, 46, 66, 1);
const kIconColor = Color(0xFF5F6368);

const kTitleTextColor = Color(0xFF303030);
const kTextColor = Color(0xFF757575);
const kTextLightColor = Color(0xFF959595);

var kTitleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold);

var kBodyTextStyle = TextStyle(
  color: Colors.white,
  fontSize: getProportionateScreenWidth(18),
);
var kContentTextStyle = TextStyle(
    color: kSecondaryColor,
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold);

var kContentBodyTextStyle = TextStyle(
    color: kTextLightColor,
    fontSize: getProportionateScreenWidth(18),
    fontWeight: FontWeight.bold);

var kTextStyle = TextStyle(
  color: kTextColor,
  fontSize: getProportionateScreenWidth(18),
);

var kSecondaryTextStyle = TextStyle(
  color: kTextLightColor,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);
var kPrimaryTextStyle = TextStyle(
  color: kSecondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

const kLinearGradient = LinearGradient(colors: [
  Color.fromRGBO(143, 148, 251, 1),
  Color.fromRGBO(143, 148, 251, 3)
]);

const kDefaultPadding = 20.0;
const kAnimationDuration = Duration(seconds: 1);

var emailValidate = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
var passwordValidate = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
var phoneNumberValidate = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

String kDefaultProfilePhoto =
    "https://image.flaticon.com/icons/png/512/149/149071.png";
