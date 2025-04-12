import 'package:flicknest/core/utils/files_path.dart';
import 'package:flicknest/core/widgets/app_background.dart';
import 'package:flicknest/view/01_onboarding_screen/onboardin_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';
  static const String routePath = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  /// Animation Controllers and Animations
  late final AnimationController _textController;
  late final Animation<Offset> _textOffsetAnimation;
  late final Animation<double> _textFadeAnimation;
  late final AnimationController _exitController;
  late final Animation<Offset> _exitSlideAnimation;
  late final Animation<double> _exitRotationAnimation;

  int _dotCount = 0;
  bool _isDisposed = false;
  bool _showDots = false;

  @override
  void initState() {
    super.initState();

    _initializeAnimations();

    // Start exit animation after 3.5 seconds, navigate after 4 seconds
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (!_isDisposed) {
        _exitController.forward();
      }
    });
    Future.delayed(const Duration(seconds: 4), () {
      if (!_isDisposed) {
        // ignore: use_build_context_synchronously
        context.goNamed(OnboardingScreen.name);
      }
    });
  }

  /// Initializes animations for splash screen text/logo.
  void _initializeAnimations() {
    _textController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _textOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeInOut));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showDots = true;
        });
        _startDotAnimation();
      }
    });

    // Exit animation: Slide right + rotate
    _exitController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _exitSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeInOut));
    _exitRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.5, // 1.5 rotations
    ).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeOut));

    _textController.forward();
  }

  void _startDotAnimation() {
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!_isDisposed && _showDots) {
        setState(() {
          _dotCount = (_dotCount + 1) % 4;
        });
        _startDotAnimation();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _exitController.dispose();
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackGround(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildCenteredLogo(),
            Visibility(visible: _showDots, child: _buildDotsAnimation()),
          ],
        ),
      ),
    );
  }

  Widget _buildDotsAnimation() {
    return Align(
      alignment: const Alignment(0.0, 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedOpacity(
            opacity: _dotCount > index ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(Icons.circle, color: Colors.white, size: 5),
            ),
          );
        }),
      ),
    );
  }

  /// Builds the centered logo with animations.
  Widget _buildCenteredLogo() {
    return Align(
      alignment: Alignment.center,
      child: SlideTransition(
        position: _textOffsetAnimation,
        child: FadeTransition(
          opacity: _textFadeAnimation,
          child: SlideTransition(
            position: _exitSlideAnimation,
            child: RotationTransition(
              turns: _exitRotationAnimation,
              child: Hero(
                tag: AppFiles.logo,
                createRectTween: (begin, end) => MaterialRectArcTween(begin: begin, end: end),
                flightShuttleBuilder: (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      final rotation = Tween<double>(
                        begin: flightDirection == HeroFlightDirection.push ? 1.5 : 0.0,
                        end: flightDirection == HeroFlightDirection.push ? 2.0 : 1.5,
                      ).evaluate(animation);
                      return RotationTransition(
                        turns: AlwaysStoppedAnimation(rotation),
                        child: Image.asset(AppFiles.logo, width: 250, color: Colors.white),
                      );
                    },
                  );
                },
                child: Image.asset(AppFiles.logo, width: 250),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
