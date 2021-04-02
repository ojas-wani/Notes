import 'package:flutter/material.dart';
import 'package:flutter_app/views/notes.dart';

void main() => runApp(Notes());

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Booknotes(),
      theme: _noteTheme(),
    );
  }

  ThemeData _noteTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: Colors.grey[200],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarTextStyle: TextStyle(color: Colors.black),
        textTheme: TextTheme(
          headline6: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Color(0xffffb31a)),
    );
  }
}
