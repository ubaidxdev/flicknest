import 'package:flutter/material.dart';

class AppBackGround extends StatelessWidget {
  const AppBackGround({
    super.key,
    required this.child,
    this.gradientColors = const [Color(0xFF0F3D40), Color(0xFF071B1D)],
    this.end,
    this.begin,
  });

  final Widget child;
  final List<Color>? gradientColors;
  final Alignment? begin;
  final Alignment? end;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin ?? Alignment.topCenter,
            end: end ?? Alignment.bottomCenter,
            colors: gradientColors ?? [Color(0xFF0F3D40), Color(0xFF071B1D)],
          ),
        ),
        child: child,
      ),
    );
  }
}
