import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontSize {
  const FontSize();
  static const double textoLabel = 16.0;
}

class FontStyle {
  const FontStyle();

  static const textStyle = TextStyle(
      fontWeight: FontWeight.w500, color: Colors.corBranco, fontSize: 16.0);
}

class ImagesApp {
  const ImagesApp();

  static const logo = 'assets/images/logo.png';
}

class Colors {
  const Colors();

  static const Color corPrincipal = const Color(0xFF303F9F);
  static const Color corBranco = const Color(0xFFFFFFFF);
  static const Color grey = const Color(0xFFBDBDBD);
}

class Theme {
  const Theme();

  static ThemeData theme = ThemeData(

    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.grey), // <-- that's the one
    ),

    hintColor: Colors.grey,
    highlightColor: Colors.grey,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.corPrincipal,
        fontSize: FontSize.textoLabel,
      ),
      hintStyle: TextStyle(color: Colors.grey, fontSize: FontSize.textoLabel),

      enabledBorder:OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.corPrincipal, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
      focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.corPrincipal, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
      errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.corPrincipal, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
      focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.corPrincipal, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
      
    ),

    primaryColor: Colors.corPrincipal, // AppBar
    accentColor: Colors.corPrincipal, // Botoes
  );
}
