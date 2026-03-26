import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../game_setup/presentation/providers/setup_providers.dart';
import '../../../gameplay/presentation/providers/game_providers.dart';
import '../../../gameplay/domain/entities/game.dart';

class RoundScoreScreen extends ConsumerWidget {
  const RoundScoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final game = ref.watch(gameProvider);
    final isGameFinished = game.status == GameStatus.finished;
    final currentRound = game.currentRound;

    final sortedTeams = List.of(game.teams)
      ..sort((a, b) => b.totalScore.compareTo(a.totalScore));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r.w(24)),
          child: Column(
            children: [
              SizedBox(height: context.r.h(40)),

              Text(
                l10n.roundComplete(currentRound + 1).toUpperCase(),
                style: context.textStyles.headlineSmall?.bold
                    .withColor(AppColors.textPrimary)
                    ?.copyWith(fontSize: context.r.sp(24)),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 500.ms),

              SizedBox(height: context.r.h(32)),

              Expanded(
                child: ListView.builder(
                  itemCount: sortedTeams.length,
                  itemBuilder: (context, index) {
                    final team = sortedTeams[index];
                    final teamColor = _teamColor(index);
                    final roundScore =
                        team.scoreByRound[currentRound] ?? 0;

                    return Padding(
                      padding: EdgeInsets.only(bottom: context.r.h(10)),
                      child: Container(
                        padding: EdgeInsets.all(context.r.r(16)),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                              context.r.r(AppRadius.lg)),
                          border: index == 0
                              ? Border.all(
                                  color: AppColors.secondary, width: 2)
                              : null,
                        ),
                        child: Row(
                          children: [
                            // Position
                            Container(
                              width: context.r.w(40),
                              height: context.r.w(40),
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? AppColors.secondary
                                    : teamColor
                                        .withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: index == 0
                                    ? Text('\u{1F451}',
                                        style: TextStyle(
                                            fontSize: context.r.sp(20)))
                                    : Text(
                                        '${index + 1}',
                                        style: context
                                            .textStyles.bodyLarge?.bold
                                            .withColor(teamColor)
                                            ?.copyWith(
                                                fontSize:
                                                    context.r.sp(16)),
                                      ),
                              ),
                            ),

                            SizedBox(width: context.r.w(14)),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    team.name,
                                    style: context
                                        .textStyles.titleMedium?.bold
                                        .withColor(AppColors.textPrimary)
                                        ?.copyWith(
                                            fontSize: context.r.sp(16)),
                                  ),
                                  SizedBox(height: context.r.h(2)),
                                  Text(
                                    l10n.thisRound(roundScore),
                                    style: context.textStyles.bodySmall
                                        ?.withColor(
                                            AppColors.textSecondary)
                                        ?.copyWith(
                                            fontSize: context.r.sp(13)),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.r.w(14),
                                vertical: context.r.h(8),
                              ),
                              decoration: BoxDecoration(
                                color: teamColor
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(
                                    context.r.r(AppRadius.md)),
                              ),
                              child: Text(
                                '${team.totalScore}',
                                style: context
                                    .textStyles.titleLarge?.bold
                                    .withColor(teamColor)
                                    ?.copyWith(
                                        fontSize: context.r.sp(22)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(
                            delay: (200 + 120 * index).ms,
                            duration: 400.ms)
                        .slideX(
                          begin: 0.08,
                          delay: (200 + 120 * index).ms,
                          duration: 400.ms,
                        );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: context.r.h(24)),
                child: SizedBox(
                  width: double.infinity,
                  height: context.r.h(58),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isGameFinished) {
                        context.go('/game/results');
                      } else {
                        final gameState = ref.read(gameProvider);
                        if (gameState.status == GameStatus.roundEnd) {
                          ref.read(gameProvider.notifier).endRound();
                          ref.read(gameProvider.notifier).nextRound();
                          final updated = ref.read(gameProvider);
                          if (updated.status == GameStatus.finished) {
                            context.go('/game/results');
                            return;
                          }
                        }
                        context.go('/game');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGameFinished
                          ? AppColors.secondary
                          : AppColors.primary,
                      foregroundColor: isGameFinished
                          ? AppColors.black
                          : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            context.r.r(AppRadius.xl)),
                      ),
                      textStyle: context.textStyles.titleMedium?.bold
                          ?.copyWith(fontSize: context.r.sp(17)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isGameFinished
                              ? l10n.seeResults.toUpperCase()
                              : l10n.nextRound.toUpperCase(),
                        ),
                        SizedBox(width: context.r.w(8)),
                        Icon(
                          isGameFinished
                              ? Icons.emoji_events_rounded
                              : Icons.arrow_forward_rounded,
                          size: context.r.sp(22),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 400.ms)
                  .slideY(begin: 0.2, delay: 800.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Color _teamColor(int index) {
    final hex = defaultTeamColors[index % defaultTeamColors.length];
    final colorInt = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return Color(0xFF000000 | colorInt);
  }
}
