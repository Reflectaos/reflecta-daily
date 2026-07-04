import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF0D1B3E),
        body: const Center(
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
