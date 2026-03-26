import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/setup_providers.dart';

class GameSetupScreen extends ConsumerWidget {
  const GameSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final setup = ref.watch(setupProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom app bar
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
                      l10n.setup.toUpperCase(),
                      style: context.textStyles.titleLarge?.bold
                          ?.copyWith(fontSize: context.r.sp(22)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: context.r.w(48)),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.r.w(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.r.h(8)),

                    // ── TEAMS SECTION ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.teams.toUpperCase(),
                          style: context.textStyles.titleMedium?.bold
                              .withColor(AppColors.primary)
                              ?.copyWith(fontSize: context.r.sp(16)),
                        ),
                        Text(
                          l10n.teamsAdded(setup.numberOfTeams),
                          style: context.textStyles.bodySmall
                              ?.withColor(AppColors.textSecondary)
                              ?.copyWith(fontSize: context.r.sp(13)),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(duration: 400.ms),

                    SizedBox(height: context.r.h(12)),

                    // Team cards
                    ...List.generate(setup.numberOfTeams, (i) {
                      final teamColor = _getTeamColor(i);
                      return Padding(
                        padding: EdgeInsets.only(bottom: context.r.h(8)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.r.w(12),
                            vertical: context.r.h(6),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(
                                context.r.r(AppRadius.lg)),
                          ),
                          child: Row(
                            children: [
                              // Number badge
                              Container(
                                width: context.r.w(36),
                                height: context.r.w(36),
                                decoration: BoxDecoration(
                                  color: teamColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: context.textStyles.bodyLarge?.bold
                                        .withColor(AppColors.white)
                                        ?.copyWith(
                                            fontSize: context.r.sp(16)),
                                  ),
                                ),
                              ),

                              SizedBox(width: context.r.w(12)),

                              // Name input
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                      text: setup.teamNames[i])
                                    ..selection = TextSelection.collapsed(
                                      offset: setup.teamNames[i].length,
                                    ),
                                  onChanged: (val) => ref
                                      .read(setupProvider.notifier)
                                      .updateTeamName(i, val),
                                  decoration: InputDecoration(
                                    hintText: l10n.teamName(i + 1),
                                    filled: false,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: context.r.h(12),
                                    ),
                                  ),
                                  style: context.textStyles.bodyLarge?.semiBold
                                      .withColor(AppColors.textPrimary)
                                      ?.copyWith(fontSize: context.r.sp(16)),
                                ),
                              ),

                              // Delete button
                              if (setup.numberOfTeams > AppConstants.minTeams)
                                IconButton(
                                  onPressed: () => ref
                                      .read(setupProvider.notifier)
                                      .removeTeamAt(i),
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    color: AppColors.error,
                                    size: context.r.sp(22),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: (50 * i).ms, duration: 300.ms)
                          .slideX(
                            begin: -0.03,
                            delay: (50 * i).ms,
                            duration: 300.ms,
                          );
                    }),

                    // Add team button
                    if (setup.numberOfTeams < AppConstants.maxTeams)
                      GestureDetector(
                        onTap: () =>
                            ref.read(setupProvider.notifier).addTeam(),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: context.r.h(14)),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(
                                context.r.r(AppRadius.lg)),
                            border: Border.all(
                              color: AppColors.surfaceLight,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_rounded,
                                  color: AppColors.textSecondary,
                                  size: context.r.sp(20)),
                              SizedBox(width: context.r.w(8)),
                              Text(
                                l10n.addTeam,
                                style: context.textStyles.bodyLarge
                                    ?.withColor(AppColors.textSecondary)
                                    ?.copyWith(fontSize: context.r.sp(15)),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: context.r.h(28)),

                    // ── TIME + WORDS PICKERS ──
                    Row(
                      children: [
                        // Time picker
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.time.toUpperCase(),
                                style: context.textStyles.titleMedium?.bold
                                    .withColor(AppColors.primary)
                                    ?.copyWith(fontSize: context.r.sp(16)),
                              ),
                              SizedBox(height: context.r.h(12)),
                              _ScrollPicker(
                                options: AppConstants.timerOptions,
                                selectedValue: setup.timerDuration,
                                labelBuilder: (v) => '${v}s',
                                onChanged: (v) => ref
                                    .read(setupProvider.notifier)
                                    .setTimerDuration(v),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: context.r.w(16)),

                        // Words picker
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.words.toUpperCase(),
                                style: context.textStyles.titleMedium?.bold
                                    .withColor(AppColors.primary)
                                    ?.copyWith(fontSize: context.r.sp(16)),
                              ),
                              SizedBox(height: context.r.h(12)),
                              _ScrollPicker(
                                options: AppConstants.wordCountOptions,
                                selectedValue: setup.wordCount,
                                labelBuilder: (v) => '$v',
                                onChanged: (v) => ref
                                    .read(setupProvider.notifier)
                                    .setWordCount(v),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 400.ms),

                    SizedBox(height: context.r.h(28)),

                    // ── PASS PENALTY PICKER ──
                    Text(
                      l10n.passPenalty.toUpperCase(),
                      style: context.textStyles.titleMedium?.bold
                          .withColor(AppColors.primary)
                          ?.copyWith(fontSize: context.r.sp(16)),
                    )
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 400.ms),

                    SizedBox(height: context.r.h(12)),

                    _ScrollPicker(
                      options: AppConstants.passPenaltyOptions,
                      selectedValue: setup.passPenalty,
                      labelBuilder: (v) =>
                          v == 0 ? l10n.noPenalty : '-${v}s',
                      onChanged: (v) => ref
                          .read(setupProvider.notifier)
                          .setPassPenalty(v),
                    )
                        .animate()
                        .fadeIn(delay: 350.ms, duration: 400.ms),

                    SizedBox(height: context.r.h(24)),
                  ],
                ),
              ),
            ),

            // ── START GAME BUTTON ──
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.r.w(20),
                vertical: context.r.h(12),
              ),
              child: SizedBox(
                width: double.infinity,
                height: context.r.h(58),
                child: ElevatedButton(
                  onPressed: setup.numberOfTeams >= 2
                      ? () => context.push('/setup/categories')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.surfaceLight,
                    disabledForegroundColor: AppColors.textLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          context.r.r(AppRadius.xl)),
                    ),
                    textStyle: context.textStyles.titleLarge?.bold
                        ?.copyWith(fontSize: context.r.sp(18)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.startGame.toUpperCase()),
                      SizedBox(width: context.r.w(8)),
                      Icon(Icons.arrow_forward_rounded,
                          size: context.r.sp(22)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTeamColor(int index) {
    final hex = defaultTeamColors[index % defaultTeamColors.length];
    final colorInt = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return Color(0xFF000000 | colorInt);
  }
}

/// Vertical scroll picker widget using ListWheelScrollView.
class _ScrollPicker extends StatefulWidget {
  final List<int> options;
  final int selectedValue;
  final String Function(int) labelBuilder;
  final void Function(int) onChanged;

  const _ScrollPicker({
    required this.options,
    required this.selectedValue,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  State<_ScrollPicker> createState() => _ScrollPickerState();
}

class _ScrollPickerState extends State<_ScrollPicker> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    final initialIndex = widget.options.indexOf(widget.selectedValue);
    _controller = FixedExtentScrollController(
      initialItem: initialIndex >= 0 ? initialIndex : 0,
    );
  }

  @override
  void didUpdateWidget(_ScrollPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      final newIndex = widget.options.indexOf(widget.selectedValue);
      if (newIndex >= 0 && _controller.selectedItem != newIndex) {
        _controller.animateToItem(
          newIndex,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.r.h(140),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(context.r.r(AppRadius.lg)),
      ),
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        itemExtent: context.r.h(44),
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          widget.onChanged(widget.options[index]);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: widget.options.length,
          builder: (context, index) {
            final isSelected = widget.options[index] == widget.selectedValue;
            return Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: context.r.sp(isSelected ? 20 : 16),
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textLight,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.r.w(20),
                    vertical: context.r.h(6),
                  ),
                  decoration: isSelected
                      ? BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                              context.r.r(AppRadius.md)),
                        )
                      : null,
                  child: Text(widget.labelBuilder(widget.options[index])),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
