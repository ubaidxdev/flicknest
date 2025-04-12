import 'package:flicknest/core/utils/app_colors.dart';
import 'package:flicknest/core/utils/extension.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    this.text,
    this.width,
    this.height,
    this.textColor,
    this.backgroundColor,
    this.icon,
    this.fontsize,
    this.onTap,
    this.onLongPressed,
    this.child,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.splashColor,
    this.showborder = false,
  }) : assert(icon == null || icon.isNotEmpty, 'Icon property can be null or non-empty.'),
       assert(
         (text != null && child == null) || (text == null && child != null),
         "Either text or child be provided both can't be provided at same time.",
       ),
       assert(text != null || child != null, 'At Least One text or child be provided');

  final String? text;
  final String? icon;
  final double? width, height, fontsize, borderWidth;
  final Color? textColor, backgroundColor, splashColor, borderColor;
  final VoidCallback? onTap, onLongPressed;
  final Widget? child;
  final EdgeInsets? padding;
  final bool showborder;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: MaterialButton(
        onPressed: onTap,
        color: backgroundColor ?? AppColors.primaryColor,
        elevation: 5,
        height: height ?? 50,
        minWidth: width ?? double.maxFinite,
        splashColor: splashColor,
        onLongPress: onLongPressed,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side:
              showborder
                  ? BorderSide(
                    color: borderColor ?? AppColors.secondaryColor,
                    width: borderWidth ?? 1,
                  )
                  : BorderSide.none,
        ),

        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child:
              child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null ? Image.asset(icon!, width: 24) : Container(),
                  if (icon != null) SizedBox(width: 5),
                  Text(
                    '$text',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.title,
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
