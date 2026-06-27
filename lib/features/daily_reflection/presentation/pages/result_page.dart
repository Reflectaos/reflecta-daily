import 'package:flutter/material.dart';
class ResultPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const ResultPage({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tu reflexión')),
      body: const Center(child: Text('✨ Aquí aparecerá la reflexión de la IA')),
    );
  }
}
