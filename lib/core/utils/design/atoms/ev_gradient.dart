import 'package:flutter/material.dart';

class EvGradient extends StatelessWidget {
  const EvGradient({
    super.key,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: const [0.0, 0.5],
            colors: const [Colors.black87, Colors.transparent],
          ),
        ),
      ),
    );
  }
}
