import 'package:flutter/material.dart';

const _primaryColor = Colors.blue;
const _scaffoldLightBackground = Color(0xFFf2f6f8);
const _scaffoldDarkBackground = Color(0xff151515);
const _fontFamily = 'Montserrat';

ThemeData theme() => ThemeData(
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: _scaffoldLightBackground,
      colorScheme: const ColorScheme.light(
        primary: _primaryColor,
        secondary: _primaryColor,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _scaffoldLightBackground,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      listTileTheme: const ListTileThemeData(iconColor: Colors.black),
      cardColor: const Color(0xFFfdfffd),
      cardTheme: cardTheme,
      chipTheme: chipTheme(Brightness.light),
      inputDecorationTheme: inputDecorationTheme,
      bottomSheetTheme: bottomSheetTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
    );
ThemeData darkTheme() => ThemeData(
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: _scaffoldDarkBackground,
      colorScheme: const ColorScheme.dark(
        primary: _primaryColor,
        secondary: _primaryColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: _scaffoldDarkBackground,
      ),
      chipTheme: chipTheme(Brightness.dark),
      toggleableActiveColor: _primaryColor,
      cardColor: const Color(0xFF1C1C1C),
      canvasColor: const Color(0xFF202020),
      cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
      bottomSheetTheme: bottomSheetTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xff212121),
      ),
    );

const borderRadius = BorderRadius.all(Radius.circular(8));

const shape = RoundedRectangleBorder(borderRadius: borderRadius);

const cardTheme = CardTheme(shape: shape);

const bottomSheetTheme = BottomSheetThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  ),
);

ChipThemeData chipTheme(Brightness brightness) => ChipThemeData.fromDefaults(
      secondaryColor: _primaryColor,
      brightness: brightness,
      labelStyle: const TextStyle(fontFamily: _fontFamily),
    );

const floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: _primaryColor,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

const inputDecorationTheme = InputDecorationTheme(
  filled: true,
  counterStyle: TextStyle(fontSize: 13),
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  border: UnderlineInputBorder(
    borderRadius: borderRadius,
    borderSide: BorderSide.none,
  ),
);
