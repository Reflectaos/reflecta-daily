import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF0D1B3E),
        body: Center(
          child: Text(
            'Reflecta Daily\nFuncionando',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF5C842),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
