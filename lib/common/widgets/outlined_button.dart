import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final EdgeInsets padding;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Container(
        // padding: padding,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(1000),
          border: const Border.fromBorderSide(
            BorderSide(color: Colors.black26),
          ),
        ),
        child: Text(
          label,
          style: textTheme.button?.copyWith(
            color: textTheme.bodyText2?.color,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    // TODO Shrink button
    // debugPrint('Tap Down: $details');
  }

  void _onTapUp(TapUpDetails details) {
    // TODO Restore button size
    // debugPrint('Tap Up: $details');
  }
}
