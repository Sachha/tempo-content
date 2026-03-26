import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF24243E),
              AppColors.background,
              Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.r.w(32)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // Logo placeholder (bomb emoji as placeholder)
                  Container(
                    width: context.r.w(140),
                    height: context.r.w(140),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.3),
                          AppColors.primary.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\u{1F4A3}',
                        style: TextStyle(fontSize: context.r.sp(80)),
                      ),
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.08, 1.08),
                        duration: 1500.ms,
                        curve: Curves.easeInOut,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.2, duration: 600.ms),

                  SizedBox(height: context.r.h(20)),

                  // Title
                  Text(
                    'TEMPO',
                    style: context.textStyles.displayLarge?.bold
                        .withColor(AppColors.textPrimary)
                        ?.copyWith(
                          fontSize: context.r.sp(52),
                          letterSpacing: 4,
                        ),
                  )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 600.ms)
                      .slideY(begin: 0.2, delay: 200.ms, duration: 600.ms),

                  SizedBox(height: context.r.h(4)),

                  // Subtitle
                  Text(
                    l10n.partyEdition.toUpperCase(),
                    style: context.textStyles.titleMedium?.semiBold
                        .withColor(AppColors.primary)
                        ?.copyWith(
                          fontSize: context.r.sp(16),
                          letterSpacing: 3,
                        ),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms),

                  const Spacer(flex: 2),

                  // Play Now button
                  SizedBox(
                    width: double.infinity,
                    height: context.r.h(62),
                    child: ElevatedButton(
                      onPressed: () => context.push(AppRoutes.setup),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              context.r.r(AppRadius.xl)),
                        ),
                        textStyle: context.textStyles.titleLarge?.bold
                            ?.copyWith(fontSize: context.r.sp(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_filled_rounded,
                              size: context.r.sp(26)),
                          SizedBox(width: context.r.w(10)),
                          Text(l10n.playNow.toUpperCase()),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 500.ms)
                      .slideY(begin: 0.3, delay: 600.ms, duration: 500.ms),

                  SizedBox(height: context.r.h(16)),

                  // Rules + Settings buttons
                  Row(
                    children: [
                      // Rules
                      Expanded(
                        child: SizedBox(
                          height: context.r.h(62),
                          child: ElevatedButton(
                            onPressed: () => context.push(AppRoutes.rules),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              foregroundColor: AppColors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    context.r.r(AppRadius.xl)),
                              ),
                              textStyle: context.textStyles.titleMedium?.bold
                                  ?.copyWith(fontSize: context.r.sp(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.menu_book_rounded,
                                    size: context.r.sp(24),
                                    color: AppColors.black),
                                SizedBox(height: context.r.h(2)),
                                Text(l10n.rules.toUpperCase()),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: context.r.w(12)),

                      // Settings
                      Expanded(
                        child: SizedBox(
                          height: context.r.h(62),
                          child: ElevatedButton(
                            onPressed: () =>
                                context.push(AppRoutes.settings),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.surface,
                              foregroundColor: AppColors.textSecondary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    context.r.r(AppRadius.xl)),
                              ),
                              textStyle: context.textStyles.titleMedium?.bold
                                  ?.copyWith(fontSize: context.r.sp(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.settings_rounded,
                                    size: context.r.sp(24),
                                    color: AppColors.textSecondary),
                                SizedBox(height: context.r.h(2)),
                                Text(l10n.settings.toUpperCase()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 500.ms)
                      .slideY(begin: 0.3, delay: 700.ms, duration: 500.ms),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
