import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase client
final supabase = Supabase.instance.client;

const preloader = Center(child: CircularProgressIndicator(color: Colors.indigo));
const formSpacer = SizedBox(width: 16,height: 16);
const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

const unexpectedErrorMessage = "Unexpected error occurred";

final appTheme = ThemeData.light().copyWith(
  primaryColorDark: Colors.indigo,
  appBarTheme:  AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.indigo.shade300,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  primaryColor: Colors.indigo.shade400,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.indigo.shade200,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, //text color etc.
        backgroundColor: Colors.indigo.shade200,
      )
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: Colors.indigo,
    ),

    floatingLabelAlignment: FloatingLabelAlignment.start,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide:  const BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
    focusColor: Colors.indigo,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide:  const BorderSide(
        color: Colors.indigo,
        width: 2,
      ),
    ),
  ),
);

extension ShowSnackBar on BuildContext {
  /// Displays a basic snackbar
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  /// Displays a red snackbar indicating error
  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}
