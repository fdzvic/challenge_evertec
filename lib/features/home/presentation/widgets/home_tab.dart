import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: const Center(
        child: Text(
          'Listado de películas próximamente...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
