import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../game_setup/presentation/providers/setup_providers.dart';
import '../../../gameplay/presentation/providers/game_providers.dart';

class FinalResultsScreen extends ConsumerWidget {
  const FinalResultsScreen({super.key});

  static const _podiumColors = [
    Color(0xFFFFD740), // Gold
    Color(0xFFB0BEC5), // Silver
    Color(0xFFFF8A65), // Bronze
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    ref.watch(gameProvider);
    final results = ref.read(gameProvider.notifier).getResults();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r.w(24)),
          child: Column(
            children: [
              SizedBox(height: context.r.h(24)),

              // Trophy
              Text(
                '\u{1F3C6}',
                style: TextStyle(fontSize: context.r.sp(72)),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.15, 1.15),
                    duration: 1200.ms,
                    curve: Curves.easeInOut,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.3, duration: 600.ms),

              SizedBox(height: context.r.h(8)),

              // Winner name
              if (results.isNotEmpty)
                Text(
                  results[0].name.toUpperCase(),
                  style: context.textStyles.headlineMedium?.bold
                      .withColor(AppColors.secondary)
                      ?.copyWith(fontSize: context.r.sp(30)),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 400.ms),

              if (results.isNotEmpty)
                Text(
                  '${results[0].totalScore} pts',
                  style: context.textStyles.titleLarge?.semiBold
                      .withColor(AppColors.primary)
                      ?.copyWith(fontSize: context.r.sp(22)),
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms),

              SizedBox(height: context.r.h(24)),

              // Podium
              if (results.length >= 2)
                SizedBox(
                  height: context.r.h(180),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (results.length >= 2)
                        _PodiumSlot(
                          team: results[1],
                          position: 2,
                          height: context.r.h(110),
                          color: _podiumColors[1],
                        )
                            .animate()
                            .fadeIn(delay: 600.ms, duration: 500.ms)
                            .slideY(
                                begin: 0.3,
                                delay: 600.ms,
                                duration: 500.ms),
                      SizedBox(width: context.r.w(8)),
                      _PodiumSlot(
                        team: results[0],
                        position: 1,
                        height: context.r.h(150),
                        color: _podiumColors[0],
                      )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 500.ms)
                          .slideY(
                              begin: 0.3,
                              delay: 400.ms,
                              duration: 500.ms),
                      SizedBox(width: context.r.w(8)),
                      if (results.length >= 3)
                        _PodiumSlot(
                          team: results[2],
                          position: 3,
                          height: context.r.h(80),
                          color: _podiumColors[2],
                        )
                            .animate()
                            .fadeIn(delay: 800.ms, duration: 500.ms)
                            .slideY(
                                begin: 0.3,
                                delay: 800.ms,
                                duration: 500.ms),
                    ],
                  ),
                ),

              SizedBox(height: context.r.h(20)),

              // Full ranking
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final team = results[index];
                    final color = _teamColorAt(index);

                    return Padding(
                      padding: EdgeInsets.only(bottom: context.r.h(8)),
                      child: Container(
                        padding: EdgeInsets.all(context.r.r(14)),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                              context.r.r(AppRadius.lg)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: context.r.w(32),
                              height: context.r.w(32),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: context.textStyles.bodyMedium
                                      ?.bold
                                      .withColor(color)
                                      ?.copyWith(
                                          fontSize: context.r.sp(14)),
                                ),
                              ),
                            ),
                            SizedBox(width: context.r.w(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    team.name,
                                    style: context
                                        .textStyles.titleSmall?.bold
                                        .withColor(AppColors.textPrimary)
                                        ?.copyWith(
                                            fontSize: context.r.sp(15)),
                                  ),
                                  SizedBox(height: context.r.h(4)),
                                  Row(
                                    children: List.generate(
                                      team.scoreByRound.length.clamp(0, 5),
                                      (r) {
                                        final rScore =
                                            team.scoreByRound[r] ?? 0;
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: context.r.w(8)),
                                          child: Text(
                                            'R${r + 1}: $rScore',
                                            style: context
                                                .textStyles.bodySmall
                                                ?.withColor(AppColors
                                                    .textSecondary)
                                                ?.copyWith(
                                                    fontSize:
                                                        context.r.sp(11)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.r.w(12),
                                vertical: context.r.h(6),
                              ),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(
                                    context.r.r(AppRadius.md)),
                              ),
                              child: Text(
                                '${team.totalScore}',
                                style: context.textStyles.titleMedium?.bold
                                    .withColor(color)
                                    ?.copyWith(
                                        fontSize: context.r.sp(20)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(
                            delay: (900 + 100 * index).ms,
                            duration: 400.ms)
                        .slideX(
                          begin: 0.05,
                          delay: (900 + 100 * index).ms,
                          duration: 400.ms,
                        );
                  },
                ),
              ),

              // Bottom buttons
              Padding(
                padding: EdgeInsets.only(bottom: context.r.h(16)),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: context.r.h(56),
                      child: ElevatedButton(
                        onPressed: () => context.go('/setup'),
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
                        child: Text(l10n.playAgain.toUpperCase()),
                      ),
                    ),
                    SizedBox(height: context.r.h(10)),
                    SizedBox(
                      width: double.infinity,
                      height: context.r.h(50),
                      child: ElevatedButton(
                        onPressed: () => context.go('/'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.textSecondary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                context.r.r(AppRadius.xl)),
                          ),
                          textStyle: context.textStyles.titleMedium
                              ?.semiBold
                              ?.copyWith(fontSize: context.r.sp(15)),
                        ),
                        child: Text(l10n.home.toUpperCase()),
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 1200.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Color _teamColorAt(int index) {
    final hex = defaultTeamColors[index % defaultTeamColors.length];
    final colorInt = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return Color(0xFF000000 | colorInt);
  }
}

class _PodiumSlot extends StatelessWidget {
  final dynamic team;
  final int position;
  final double height;
  final Color color;

  const _PodiumSlot({
    required this.team,
    required this.position,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final positionEmojis = ['', '\u{1F947}', '\u{1F948}', '\u{1F949}'];

    return SizedBox(
      width: context.r.w(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            positionEmojis[position],
            style: TextStyle(fontSize: context.r.sp(28)),
          ),
          SizedBox(height: context.r.h(4)),
          Text(
            team.name,
            style: context.textStyles.bodySmall?.bold
                .withColor(AppColors.textPrimary)
                ?.copyWith(fontSize: context.r.sp(12)),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.r.h(6)),
          Container(
            width: context.r.w(80),
            height: height,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.r.r(AppRadius.md)),
                topRight: Radius.circular(context.r.r(AppRadius.md)),
              ),
              border: Border.all(
                color: color.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '${team.totalScore}',
                style: context.textStyles.titleLarge?.bold
                    .withColor(AppColors.textPrimary)
                    ?.copyWith(fontSize: context.r.sp(22)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
