import 'package:flutter/material.dart';
class ReflectionPage extends StatelessWidget {
  const ReflectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi reflexión')),
      body: const Center(child: Text('✍️ Aquí irá el input del diario')),
    );
  }
}
