import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';

class CustomMaterialButton extends MaterialButton {
  @override
  final VoidCallback onPressed;
  final String buttonText;

  CustomMaterialButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    Color highlightColor = TColors.primary,
    Color splashColor =TColors.primary,
    Duration animationDuration = const Duration(milliseconds: 100),
    double height = 120,
    double minWidth = 120,
  }) : super(
    key: key,
    onPressed: onPressed,
    child: Text(
      buttonText,
      style: const TextStyle(color: TColors.primary, fontWeight: FontWeight.bold),
    ),
    height: height,
    minWidth: minWidth,
    color: Colors.white,
    shape: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(300))),
    highlightColor: highlightColor,
    splashColor: splashColor,
    animationDuration: animationDuration,
  );
}
