import 'package:flicknest/core/utils/app_colors.dart';
import 'package:flicknest/core/utils/extension.dart';
import 'package:flicknest/core/utils/files_path.dart';
import 'package:flicknest/core/widgets/app_background.dart';
import 'package:flicknest/core/widgets/app_button.dart';
import 'package:flicknest/view/02_home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  static String name = 'onboardingscreen';
  static String path = '/onboardingscreen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<Offset> _exploreSlideAnimation;
  late Animation<double> _exploreFadeAnimation;
  late Animation<Offset> _logoNameSlideAnimation;
  late Animation<double> _logoNameFadeAnimation;
  late Animation<Offset> _experienceSlideAnimation;
  late Animation<double> _experienceFadeAnimation;
  late Animation<Offset> _exploreButtonSlideAnimation;
  late Animation<double> _exploreButtonFadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);

    // Logo: Slide from left + rotate
    _logoSlideAnimation = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
      ),
    );

    _logoRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0, // 2 full rotations
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.bounceOut),
      ),
    );

    // Explore Text: Slide from top + fade
    _exploreSlideAnimation = Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );

    _exploreFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.5, curve: Curves.easeIn)),
    );

    // Logo Name: Slide from left + fade
    _logoNameSlideAnimation = Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeInOut),
      ),
    );

    _logoNameFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.6, curve: Curves.easeIn)),
    );

    // Experience Text: Slide from right + fade
    _experienceSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeInOut),
      ),
    );

    _experienceFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.7, curve: Curves.easeIn)),
    );

    // explore Button: Slide from bottom + fade
    _exploreButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeInOut),
      ),
    );

    _exploreButtonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.8, curve: Curves.easeIn)),
    );

    // Start animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackGround(
      end: const Alignment(0, 2),
      gradientColors: const [Color(0xFF0F3D40), Color(0xFF0F3D40), Color(0xFFD9D9D9)],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SlideTransition(
                position: _exploreSlideAnimation,
                child: FadeTransition(
                  opacity: _exploreFadeAnimation,
                  child: Text(
                    'Explore the',
                    style: context.display.copyWith(color: AppColors.secondaryColor, fontSize: 28),
                  ),
                ),
              ),
              SlideTransition(
                position: _logoNameSlideAnimation,
                child: FadeTransition(
                  opacity: _logoNameFadeAnimation,
                  child: Hero(
                    tag: AppFiles.logoName,
                    child: Image.asset(AppFiles.logoName, width: 300),
                  ),
                ),
              ),
              SlideTransition(
                position: _experienceSlideAnimation,
                child: FadeTransition(
                  opacity: _experienceFadeAnimation,
                  child: Text(
                    'Experience',
                    style: context.display.copyWith(color: AppColors.secondaryColor, fontSize: 28),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              SlideTransition(
                position: _logoSlideAnimation,
                child: RotationTransition(
                  turns: _logoRotationAnimation,
                  child: Hero(tag: AppFiles.logo, child: Image.asset(AppFiles.logo, width: 250)),
                ),
              ),
              const Spacer(),
              SlideTransition(
                position: _exploreButtonSlideAnimation,
                child: FadeTransition(
                  opacity: _exploreButtonFadeAnimation,
                  child: AppButton(
                    onTap: () {
                      context.goNamed(HomeScreen.name);
                    },
                    text: 'Eplore the Movies',
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
