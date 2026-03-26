import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/game_providers.dart';
import '../../../gameplay/domain/entities/game.dart';

class GameplayScreen extends ConsumerStatefulWidget {
  const GameplayScreen({super.key});

  @override
  ConsumerState<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends ConsumerState<GameplayScreen> {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isTurnActive = false;
  bool _isPaused = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    final game = ref.read(gameProvider);
    setState(() {
      _remainingSeconds = game.timerDuration;
      _isTurnActive = true;
      _isPaused = false;
    });

    ref.read(gameProvider.notifier).startTurn();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        _onTimerEnd();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _onPause() {
    _timer?.cancel();
    ref.read(gameProvider.notifier).pause();
    setState(() => _isPaused = true);
  }

  void _onResume() {
    ref.read(gameProvider.notifier).resume();
    setState(() => _isPaused = false);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        _onTimerEnd();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _onTimerEnd() {
    final game = ref.read(gameProvider);
    final wordsGuessed = game.wordsGuessedThisTurn.length;

    ref.read(gameProvider.notifier).endTurn(wordsGuessed);

    setState(() {
      _isTurnActive = false;
      _isPaused = false;
    });
    context.go('/game/round-score');
  }

  void _onCorrect() {
    ref.read(gameProvider.notifier).correctWord();

    final updatedGame = ref.read(gameProvider);
    if (updatedGame.status == GameStatus.roundEnd) {
      _timer?.cancel();
      setState(() {
        _isTurnActive = false;
        _isPaused = false;
      });
      context.go('/game/round-score');
    }
  }

  void _onPass() {
    final game = ref.read(gameProvider);

    // Apply pass penalty
    if (game.passPenalty > 0) {
      final newRemaining = _remainingSeconds - game.passPenalty;
      if (newRemaining <= 0) {
        // Penalty causes timer to expire
        _timer?.cancel();
        setState(() => _remainingSeconds = 0);
        _onTimerEnd();
        return;
      }
      setState(() => _remainingSeconds = newRemaining);
    }

    ref.read(gameProvider.notifier).passWord();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final gameState = ref.watch(gameProvider);
    final roundIndex = gameState.currentRound.clamp(0, 2);

    if (gameState.teams.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\u{26A0}\u{FE0F}',
                    style: TextStyle(fontSize: context.r.sp(48))),
                SizedBox(height: context.r.h(16)),
                Text('No game in progress',
                    style: context.textStyles.titleMedium),
                SizedBox(height: context.r.h(24)),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: Text(l10n.backToHome),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (!_isTurnActive) {
      return _buildPreTurnScreen(context, l10n, gameState, roundIndex);
    }

    return Stack(
      children: [
        _buildGameplayScreen(context, l10n, gameState, roundIndex),
        if (_isPaused) _buildPauseOverlay(context, l10n),
      ],
    );
  }

  Widget _buildPreTurnScreen(
    BuildContext context,
    AppLocalizations l10n,
    GameState game,
    int roundIndex,
  ) {
    final teamIndex = game.currentTeamIndex.clamp(0, game.teams.length - 1);
    final team = game.teams.isNotEmpty ? game.teams[teamIndex] : null;

    final roundTitles = [
      l10n.round1Title,
      l10n.round2Title,
      l10n.round3Title,
    ];
    final roundDescriptions = [
      l10n.round1Description,
      l10n.round2Description,
      l10n.round3Description,
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.r.w(32)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Round info
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.r.w(20),
                    vertical: context.r.h(10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius:
                        BorderRadius.circular(context.r.r(AppRadius.xl)),
                  ),
                  child: Text(
                    roundTitles[roundIndex],
                    style: context.textStyles.titleMedium?.bold
                        .withColor(AppColors.primary)
                        ?.copyWith(fontSize: context.r.sp(16)),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: -0.2, duration: 500.ms),

                SizedBox(height: context.r.h(12)),

                Text(
                  roundDescriptions[roundIndex],
                  style: context.textStyles.bodyMedium
                      ?.withColor(AppColors.textSecondary)
                      ?.copyWith(fontSize: context.r.sp(14)),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms),

                SizedBox(height: context.r.h(40)),

                if (team != null) ...[
                  Container(
                    width: context.r.w(100),
                    height: context.r.w(100),
                    decoration: BoxDecoration(
                      color: _teamColorFromHex(team.color)
                          .withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _teamColorFromHex(team.color),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\u{1F465}',
                        style: TextStyle(fontSize: context.r.sp(44)),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 500.ms)
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        delay: 300.ms,
                        duration: 600.ms,
                        curve: Curves.elasticOut,
                      ),

                  SizedBox(height: context.r.h(20)),

                  Text(
                    team.name,
                    style: context.textStyles.headlineMedium?.bold
                        .withColor(_teamColorFromHex(team.color))
                        ?.copyWith(fontSize: context.r.sp(28)),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 400.ms),

                  SizedBox(height: context.r.h(8)),

                  Text(
                    l10n.getReady,
                    style: context.textStyles.bodyLarge
                        ?.withColor(AppColors.textSecondary)
                        ?.copyWith(fontSize: context.r.sp(16)),
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 400.ms),
                ],

                SizedBox(height: context.r.h(48)),

                SizedBox(
                  width: double.infinity,
                  height: context.r.h(60),
                  child: ElevatedButton(
                    onPressed: _startCountdown,
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
                    child: Text(l10n.start.toUpperCase()),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 700.ms, duration: 400.ms)
                    .slideY(begin: 0.2, delay: 700.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameplayScreen(
    BuildContext context,
    AppLocalizations l10n,
    GameState game,
    int roundIndex,
  ) {
    final teamIndex = game.currentTeamIndex.clamp(0, game.teams.length - 1);
    final team = game.teams[teamIndex];
    final progress = game.timerDuration > 0
        ? _remainingSeconds / game.timerDuration
        : 0.0;
    final isLowTime = _remainingSeconds <= 5;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r.w(24)),
          child: Column(
            children: [
              SizedBox(height: context.r.h(16)),

              // Header: Round + Team + Pause
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.roundOf(
                          game.currentRound + 1,
                          game.totalRounds,
                        ).toUpperCase(),
                        style: context.textStyles.bodySmall?.bold
                            .withColor(AppColors.primary)
                            ?.copyWith(fontSize: context.r.sp(13)),
                      ),
                      SizedBox(height: context.r.h(2)),
                      Text(
                        team.name.toUpperCase(),
                        style: context.textStyles.titleLarge?.bold
                            .withColor(AppColors.textPrimary)
                            ?.copyWith(fontSize: context.r.sp(20)),
                      ),
                    ],
                  ),

                  // Pause button
                  GestureDetector(
                    onTap: _onPause,
                    child: Container(
                      width: context.r.w(48),
                      height: context.r.w(48),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surfaceLight,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.pause_rounded,
                        color: AppColors.textPrimary,
                        size: context.r.sp(24),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.r.h(32)),

              // Timer circle
              SizedBox(
                width: context.r.w(200),
                height: context.r.w(200),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background arc
                    SizedBox(
                      width: context.r.w(200),
                      height: context.r.w(200),
                      child: CustomPaint(
                        painter: _TimerArcPainter(
                          progress: progress,
                          color: isLowTime
                              ? AppColors.error
                              : AppColors.secondary,
                          backgroundColor: AppColors.surfaceLight,
                          strokeWidth: context.r.w(10),
                        ),
                      ),
                    ),
                    // Seconds text
                    Text(
                      '$_remainingSeconds',
                      style: context.textStyles.displayLarge?.bold
                          .withColor(AppColors.textSecondary)
                          ?.copyWith(fontSize: context.r.sp(56)),
                    ),
                  ],
                ),
              )
                  .animate(target: isLowTime ? 1 : 0)
                  .shake(
                      duration: 400.ms, hz: 4, offset: const Offset(2, 0)),

              SizedBox(height: context.r.h(32)),

              // Word card
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: context.r.w(8)),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.r.w(24),
                      vertical: context.r.h(32),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                          context.r.r(AppRadius.xxl)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Small handle indicator
                        Container(
                          width: context.r.w(40),
                          height: context.r.h(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(
                                context.r.r(2)),
                          ),
                        ),
                        SizedBox(height: context.r.h(24)),
                        // Word
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            (game.currentWord?.text ?? '...')
                                .toUpperCase(),
                            style: context.textStyles.displaySmall?.bold
                                .withColor(AppColors.black)
                                ?.copyWith(fontSize: context.r.sp(36)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: context.r.h(16)),
                        // Category badge
                        if (game.currentWord != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.r.w(14),
                              vertical: context.r.h(6),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(
                                  context.r.r(AppRadius.md)),
                            ),
                            child: Text(
                              game.currentWord!.categoryId.toUpperCase(),
                              style: context.textStyles.bodySmall?.semiBold
                                  .withColor(const Color(0xFF888888))
                                  ?.copyWith(fontSize: context.r.sp(12)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: context.r.h(16)),

              // Action buttons
              Row(
                children: [
                  // Skip
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: context.r.h(62),
                      child: ElevatedButton(
                        onPressed: _onPass,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.textSecondary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                context.r.r(AppRadius.xl)),
                          ),
                          textStyle: context.textStyles.titleMedium?.bold
                              ?.copyWith(fontSize: context.r.sp(16)),
                        ),
                        child: Text(l10n.skip.toUpperCase()),
                      ),
                    ),
                  ),

                  SizedBox(width: context.r.w(12)),

                  // Correct
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: context.r.h(62),
                      child: ElevatedButton(
                        onPressed: _onCorrect,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_rounded,
                                size: context.r.sp(22)),
                            SizedBox(width: context.r.w(8)),
                            Text(l10n.correct.toUpperCase()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.r.h(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPauseOverlay(BuildContext context, AppLocalizations l10n) {
    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pause_circle_filled_rounded,
                color: AppColors.textSecondary,
                size: context.r.sp(64),
              ),
              SizedBox(height: context.r.h(20)),
              Text(
                l10n.paused.toUpperCase(),
                style: context.textStyles.displaySmall?.bold
                    .withColor(AppColors.textPrimary)
                    ?.copyWith(
                      fontSize: context.r.sp(36),
                      letterSpacing: 4,
                    ),
              ),
              SizedBox(height: context.r.h(40)),
              SizedBox(
                width: context.r.w(200),
                height: context.r.h(56),
                child: ElevatedButton(
                  onPressed: _onResume,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          context.r.r(AppRadius.xl)),
                    ),
                    textStyle: context.textStyles.titleMedium?.bold
                        ?.copyWith(fontSize: context.r.sp(18)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow_rounded,
                          size: context.r.sp(24)),
                      SizedBox(width: context.r.w(8)),
                      Text(l10n.resume.toUpperCase()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _teamColorFromHex(String hex) {
    try {
      final colorInt = int.parse(hex.replaceFirst('#', ''), radix: 16);
      return Color(0xFF000000 | colorInt);
    } catch (_) {
      return AppColors.primary;
    }
  }
}

/// Custom painter for the circular timer arc.
class _TimerArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _TimerArcPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_TimerArcPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
