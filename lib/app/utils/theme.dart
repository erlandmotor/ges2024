import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
  useMaterial3: false,
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: AppColor.primaryDark),
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColor.primaryDark,
    elevation: 0,
    centerTitle: true,
    titleTextStyle:
        AppFont.size18width600.copyWith(color: AppColor.primaryDark),
  ),
  fontFamily: GoogleFonts.poppins().fontFamily,
  primarySwatch: AppColor.primaryMaterialColor,
  brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.shade,
      minimumSize: const Size(400, 48),
      textStyle: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontSize: 16,
        color: AppColor.shade,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      // backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.primaryColor,
      textStyle: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        // fontSize: 16,
        color: AppColor.shade,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        minimumSize: const Size(400, 48),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 16,
          color: AppColor.shade,
        ),
        side: const BorderSide(
          width: 1,
          color: AppColor.primaryColor,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColor.shade,
    filled: true,
    labelStyle: AppFont.size14width400,
    hintStyle: AppFont.size14width400.copyWith(color: AppColor.bodyTextColor),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.bodyTextColor, width: 1)),
    enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.bodyTextColor, width: 1)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.bodyTextColor, width: 1)),
    focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.primaryColor, width: 1)),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  ),
  dialogTheme: DialogTheme(
      contentTextStyle: AppFont.size16width400
          .copyWith(fontFamily: GoogleFonts.poppins().fontFamily)),
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColor.shade,
    filled: true,
    labelStyle: AppFont.size14width400,
    hintStyle: AppFont.size14width400.copyWith(color: AppColor.bodyTextColor),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.bodyTextColor, width: 1)),
    enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.bodyTextColor, width: 1)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.bodyTextColor, width: 1)),
    focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColor.primaryColor, width: 1)),
    activeIndicatorBorder:
        const BorderSide(color: AppColor.primaryColor, width: 1),
    contentPadding: const EdgeInsets.all(20),
  )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: AppColor.shade,
    backgroundColor: AppColor.primaryColor,
    extendedTextStyle: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 16,
      color: AppColor.shade,
    ),
  ),
);
