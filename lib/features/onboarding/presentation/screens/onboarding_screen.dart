import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/providers/global_providers.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onFinish() {
    ref.read(hasSeenOnboardingProvider.notifier).markSeen();
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final pages = [
      _OnboardingPage(
        emoji: '\u{1F389}',
        title: l10n.onboardingTitle,
        description: l10n.onboardingDescription,
      ),
      _OnboardingPage(
        emoji: '\u{1F3AF}',
        title: l10n.onboardingRoundsTitle,
        description: l10n.onboardingRoundsDescription,
      ),
      _OnboardingPage(
        emoji: '\u{1F680}',
        title: l10n.onboardingReadyTitle,
        description: l10n.onboardingReadyDescription,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(context.r.r(16)),
                child: TextButton(
                  onPressed: _onFinish,
                  child: Text(
                    _currentPage == pages.length - 1
                        ? l10n.getStarted
                        : 'Skip',
                    style: context.textStyles.bodyMedium?.semiBold
                        .withColor(AppColors.textSecondary)
                        ?.copyWith(fontSize: context.r.sp(14)),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) =>
                    setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.r.w(40)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          page.emoji,
                          style: TextStyle(fontSize: context.r.sp(80)),
                        ),
                        SizedBox(height: context.r.h(32)),
                        Text(
                          page.title,
                          style: context.textStyles.headlineSmall?.bold
                              .withColor(AppColors.textPrimary)
                              ?.copyWith(fontSize: context.r.sp(24)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: context.r.h(16)),
                        Text(
                          page.description,
                          style: context.textStyles.bodyLarge
                              ?.withColor(AppColors.textSecondary)
                              ?.copyWith(
                                fontSize: context.r.sp(16),
                                height: 1.5,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                final isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: 300.ms,
                  margin: EdgeInsets.symmetric(
                      horizontal: context.r.w(4)),
                  width: isActive ? context.r.w(24) : context.r.w(8),
                  height: context.r.h(8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : AppColors.surfaceLight,
                    borderRadius:
                        BorderRadius.circular(context.r.r(4)),
                  ),
                );
              }),
            ),

            SizedBox(height: context.r.h(32)),

            // Bottom button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.r.w(32),
                vertical: context.r.h(16),
              ),
              child: SizedBox(
                width: double.infinity,
                height: context.r.h(56),
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < pages.length - 1) {
                      _pageController.nextPage(
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _onFinish();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          context.r.r(AppRadius.xl)),
                    ),
                    textStyle: context.textStyles.titleMedium?.bold
                        ?.copyWith(fontSize: context.r.sp(17)),
                  ),
                  child: Text(
                    _currentPage == pages.length - 1
                        ? l10n.getStarted.toUpperCase()
                        : l10n.next.toUpperCase(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String emoji;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.emoji,
    required this.title,
    required this.description,
  });
}
