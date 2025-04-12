import 'package:flutter/material.dart';

class AppBackGround extends StatelessWidget {
  const AppBackGround({
    super.key,
    required this.child,
    this.gradientColors = const [Color(0xff1C1E26), Color(0xff2A2F45), Color(0xFFD9D9D9)],
    this.end = const Alignment(0, 2),
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
            colors: gradientColors ?? [const Color(0xff1C1E26), const Color(0xff2A2F45)],
          ),
        ),
        child: child,
      ),
    );
  }
}
