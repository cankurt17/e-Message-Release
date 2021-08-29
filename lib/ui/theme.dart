import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_chat/ui/constants.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme),
    appBarTheme: appBarTheme(),
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}

InputDecorationTheme inputDecorationTheme() {
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kPrimaryColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    //floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusColor: kPrimaryColor,
    border: outlineInputBorder,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: kTitleTextColor),
    textTheme: TextTheme(
      headline6: GoogleFonts.montserrat(color: kTitleTextColor, fontSize: 18),
    ),
  );
}
