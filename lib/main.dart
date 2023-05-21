import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color(0xffb9f3fc),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 5, 99, 12),
);

void main(List<String> args) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.onPrimaryContainer,
            foregroundColor: kDarkColorScheme.primaryContainer),
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer),
        ),
        cardTheme: CardTheme().copyWith(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: kDarkColorScheme.secondaryContainer),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 16)),
      ),
      theme: ThemeData().copyWith(
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer),
          ),
          useMaterial3: true,
          cardTheme: CardTheme().copyWith(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: kColorScheme.secondaryContainer),
          appBarTheme: AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer),
          colorScheme: kColorScheme),
      home: Expenses(),
    ),
  );
}
