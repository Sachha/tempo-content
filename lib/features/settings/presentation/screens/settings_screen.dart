import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/global_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _languages = [
    _LangOption('fr', '\u{1F1EB}\u{1F1F7}', 'FR'),
    _LangOption('en', '\u{1F1EC}\u{1F1E7}', 'EN'),
    _LangOption('it', '\u{1F1EE}\u{1F1F9}', 'IT'),
    _LangOption('es', '\u{1F1EA}\u{1F1F8}', 'ES'),
    _LangOption('de', '\u{1F1E9}\u{1F1EA}', 'DE'),
    _LangOption('pt', '\u{1F1F5}\u{1F1F9}', 'PT'),
    _LangOption('nl', '\u{1F1F3}\u{1F1F1}', 'NL'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final soundEnabled = ref.watch(soundEnabledProvider);
    final vibrationEnabled = ref.watch(vibrationEnabledProvider);

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
                      l10n.settings.toUpperCase(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Language section
                    Text(
                      l10n.language.toUpperCase(),
                      style: context.textStyles.titleMedium?.bold
                          .withColor(AppColors.primary)
                          ?.copyWith(fontSize: context.r.sp(16)),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms),

                    SizedBox(height: context.r.h(12)),

                    Wrap(
                      spacing: context.r.w(8),
                      runSpacing: context.r.h(8),
                      children:
                          List.generate(_languages.length, (index) {
                        final lang = _languages[index];
                        final isSelected =
                            currentLocale.languageCode == lang.code;
                        return GestureDetector(
                          onTap: () => ref
                              .read(localeProvider.notifier)
                              .setLocale(Locale(lang.code)),
                          child: AnimatedContainer(
                            duration: 200.ms,
                            padding: EdgeInsets.symmetric(
                              horizontal: context.r.w(16),
                              vertical: context.r.h(10),
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                      .withValues(alpha: 0.15)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                  context.r.r(AppRadius.md)),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(lang.flag,
                                    style: TextStyle(
                                        fontSize: context.r.sp(18))),
                                SizedBox(width: context.r.w(6)),
                                Text(
                                  lang.label,
                                  style: context
                                      .textStyles.bodyMedium?.bold
                                      .withColor(isSelected
                                          ? AppColors.primary
                                          : AppColors.textSecondary)
                                      ?.copyWith(
                                          fontSize: context.r.sp(14)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                        .animate()
                        .fadeIn(delay: 100.ms, duration: 400.ms),

                    SizedBox(height: context.r.h(32)),

                    // Sound toggle
                    _SettingToggle(
                      icon: Icons.volume_up_rounded,
                      label: l10n.sound,
                      value: soundEnabled,
                      onChanged: (_) =>
                          ref.read(soundEnabledProvider.notifier).toggle(),
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 400.ms),

                    SizedBox(height: context.r.h(12)),

                    // Vibration toggle
                    _SettingToggle(
                      icon: Icons.vibration_rounded,
                      label: l10n.vibration,
                      value: vibrationEnabled,
                      onChanged: (_) => ref
                          .read(vibrationEnabledProvider.notifier)
                          .toggle(),
                    )
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 400.ms),
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

class _LangOption {
  final String code;
  final String flag;
  final String label;

  const _LangOption(this.code, this.flag, this.label);
}

class _SettingToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.r.w(16),
        vertical: context.r.h(12),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(context.r.r(AppRadius.lg)),
      ),
      child: Row(
        children: [
          Icon(icon,
              color: AppColors.textSecondary, size: context.r.sp(24)),
          SizedBox(width: context.r.w(14)),
          Expanded(
            child: Text(
              label,
              style: context.textStyles.titleMedium?.semiBold
                  .withColor(AppColors.textPrimary)
                  ?.copyWith(fontSize: context.r.sp(16)),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.textLight,
            inactiveTrackColor: AppColors.surfaceLight,
          ),
        ],
      ),
    );
  }
}
