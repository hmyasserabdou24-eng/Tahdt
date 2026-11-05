import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_localizations.dart';
import 'tadahhath_logo.dart';
import 'auth_controller.dart';
import 'onboarding_controller.dart';

/// Animated Splash Screen displaying the TADAHHATH AI brand mark and routing
/// the learner based on onboarding and authentication session state.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _scaleAnimation = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    _navigationTimer = Timer(const Duration(milliseconds: 1600), _routeNext);
  }

  void _routeNext() {
    if (!mounted) {
      return;
    }
    final bool onboardingDone =
        ref.read(onboardingControllerProvider).preferences.isCompleted;
    final bool isAuthenticated =
        ref.read(authControllerProvider).user != null;

    if (!onboardingDone) {
      context.go('/onboarding');
    } else if (isAuthenticated) {
      context.go('/home');
    } else {
      context.go('/auth/login');
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.primaryNavy,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const TadahhathLogo(size: 104, showWordmark: false),
                    const SizedBox(height: AppSpacing.lg),
                    RichText(
                      textDirection: TextDirection.ltr,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.6,
                          color: Colors.white,
                        ),
                        children: <InlineSpan>[
                          TextSpan(text: 'TADAHHATH '),
                          TextSpan(
                            text: 'AI',
                            style: TextStyle(color: AppColors.accentGold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.tr('tagline'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.accentGold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
