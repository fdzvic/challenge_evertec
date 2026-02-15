import 'package:challenge_evertec/core/utils/design/atoms/atoms.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmLogoutSheet(
  BuildContext context, {
  required String title,
  String? subtitle,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.logout, size: 40),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(subtitle ?? '', textAlign: TextAlign.center),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: EvButton(
                    backgroundColor: Colors.red,
                    onPressed: () => Navigator.pop(context, true),
                    textColor: Colors.white,
                    text: 'Salir',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
