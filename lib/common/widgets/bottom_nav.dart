import 'package:flutter/material.dart';

import 'package:copic/config/constants.dart';

class BottomNav extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;

  const BottomNav({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: kAppPaddingValue + 10,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white.withOpacity(0.6),
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
