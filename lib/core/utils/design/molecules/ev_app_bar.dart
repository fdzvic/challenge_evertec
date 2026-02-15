import 'package:flutter/material.dart';

class EvAppBar extends StatelessWidget {
  const EvAppBar({
    super.key,
    required this.title,
    required this.icon,
    this.onSearchPressed, this.viewIconSearch = true,
  });
  final String title;
  final IconData icon;
  final VoidCallback? onSearchPressed;
  final bool viewIconSearch;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if(viewIconSearch)
            IconButton(onPressed: onSearchPressed ?? (() {}), icon: const Icon(Icons.search),),
          ],
        ),
      ),
    );
  }
}
