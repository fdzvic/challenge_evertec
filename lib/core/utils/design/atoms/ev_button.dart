import 'package:flutter/material.dart';

class EvButton extends StatelessWidget {
  const EvButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final canPress = enabled && !isLoading;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: canPress
              ? backgroundColor
              : (backgroundColor ?? Theme.of(context).primaryColor).withValues(
                  alpha: 0.4,
                ),
          foregroundColor: foregroundColor,
        ),
        onPressed: canPress ? onPressed : null,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
