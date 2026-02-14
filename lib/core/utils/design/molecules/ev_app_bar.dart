import 'package:flutter/material.dart';

class EvAppBar extends StatelessWidget {
  const EvAppBar({
    super.key,
    required this.title,
    required this.icon,
    this.onSearchPressed,
  });
  final String title;
  final IconData icon;
  final VoidCallback? onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(onPressed: onSearchPressed ?? (() {}), icon: Icon(Icons.search),),
          ],
        ),
      ),
    );
  }
}
