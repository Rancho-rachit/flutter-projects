import 'package:flutter/material.dart';
import 'currency_convertor_material_page.dart';

void main() {
  runApp(const MyApp());
}

//Types of widgets
// 1. Stateless widget
// 2. Stateful widget

// State - data that widget will care about

// Stateless widget -
// less no. of state. state is immutable (cannot be changed)*

// Stateful widget -
// more no. of state. state is mutable (can be changed)*

// Design - rules followed by major compnies for better code.

// 1. Material Design - created by google
// 2. Cupertino Design - created by apple

// material design
// navigation
// localisation
// internalisation
// theming

// IMPS -
// BuildContext - tells the location of the Widget in the Widget Tree
// Main -> Scaffold -> Center -> Text

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CurrencyConvertorMaterialPage(),
    );
  }
}
