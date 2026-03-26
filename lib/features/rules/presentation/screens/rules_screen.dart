import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';

class RulesScreen extends ConsumerWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final rounds = [
      _RoundInfo(
        emoji: '\u{1F5E3}\u{FE0F}',
        title: l10n.round1Title,
        description: l10n.round1Description,
        color: AppColors.primary,
      ),
      _RoundInfo(
        emoji: '\u{261D}\u{FE0F}',
        title: l10n.round2Title,
        description: l10n.round2Description,
        color: AppColors.secondary,
      ),
      _RoundInfo(
        emoji: '\u{1F3AD}',
        title: l10n.round3Title,
        description: l10n.round3Description,
        color: AppColors.secondary,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.r.w(8),
                vertical: context.r.h(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                      size: context.r.sp(24),
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      shape: const CircleBorder(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      l10n.rules.toUpperCase(),
                      style: context.textStyles.titleLarge?.bold
                          ?.copyWith(fontSize: context.r.sp(22)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: context.r.w(48)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.r.w(20),
                  vertical: context.r.h(16),
                ),
                child: Column(
                  children: [
                    ...List.generate(rounds.length, (index) {
                      final round = rounds[index];
                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: context.r.h(16)),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(context.r.r(20)),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(
                                context.r.r(AppRadius.lg)),
                            border: Border.all(
                              color: round.color.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    round.emoji,
                                    style: TextStyle(
                                        fontSize: context.r.sp(28)),
                                  ),
                                  SizedBox(width: context.r.w(12)),
                                  Expanded(
                                    child: Text(
                                      round.title,
                                      style: context
                                          .textStyles.titleMedium?.bold
                                          .withColor(round.color)
                                          ?.copyWith(
                                              fontSize:
                                                  context.r.sp(17)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: context.r.h(12)),
                              Text(
                                round.description,
                                style: context.textStyles.bodyMedium
                                    ?.withColor(AppColors.textSecondary)
                                    ?.copyWith(
                                      fontSize: context.r.sp(14),
                                      height: 1.5,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(
                              delay: (200 + 150 * index).ms,
                              duration: 400.ms)
                          .slideY(
                            begin: 0.1,
                            delay: (200 + 150 * index).ms,
                            duration: 400.ms,
                          );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundInfo {
  final String emoji;
  final String title;
  final String description;
  final Color color;

  const _RoundInfo({
    required this.emoji,
    required this.title,
    required this.description,
    required this.color,
  });
}
