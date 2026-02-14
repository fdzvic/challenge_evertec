import 'package:flutter/material.dart';

class EvAppBar extends StatelessWidget {
  const EvAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie),
              SizedBox(width: 5),
              Text(
                'Movies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            ],
          ),
        ),
      ),
    );
  }
}
