import 'package:flutter/material.dart';

void showFeatureNotAvailable(BuildContext context, [String? message]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: const Text('🔍 Búsqueda disponible próximamente'),
    ),
  );
}