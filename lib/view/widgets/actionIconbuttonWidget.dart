//custom widget to reuse fractionization
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionIconButton extends StatelessWidget {
  final String iconPath;
  final void Function() onPressed;
  ActionIconButton({required this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          iconPath,
          height: 21,
          width: 21,
        ),
        style: IconButton.styleFrom(padding: EdgeInsets.zero),
      ),
    );
  }
}
