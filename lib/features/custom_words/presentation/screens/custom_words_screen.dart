import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../game_setup/presentation/providers/setup_providers.dart';

class CustomWordsScreen extends ConsumerStatefulWidget {
  const CustomWordsScreen({super.key});

  @override
  ConsumerState<CustomWordsScreen> createState() =>
      _CustomWordsScreenState();
}

class _CustomWordsScreenState extends ConsumerState<CustomWordsScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addWord() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    ref.read(setupProvider.notifier).addCustomWord(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final setup = ref.watch(setupProvider);

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
                      l10n.customWords.toUpperCase(),
                      style: context.textStyles.titleLarge?.bold
                          ?.copyWith(fontSize: context.r.sp(22)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: context.r.w(48)),
                ],
              ),
            ),

            // Input row
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.r.w(20),
                vertical: context.r.h(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _addWord(),
                      decoration: InputDecoration(
                        hintText: l10n.words,
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              context.r.r(AppRadius.lg)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: context.r.w(16),
                          vertical: context.r.h(14),
                        ),
                      ),
                      style: context.textStyles.bodyLarge
                          ?.withColor(AppColors.textPrimary)
                          ?.copyWith(fontSize: context.r.sp(16)),
                    ),
                  ),
                  SizedBox(width: context.r.w(10)),
                  GestureDetector(
                    onTap: _addWord,
                    child: Container(
                      width: context.r.w(48),
                      height: context.r.w(48),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(
                            context.r.r(AppRadius.md)),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: context.r.sp(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Word count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.r.w(20)),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  l10n.wordCount(setup.customWords.length),
                  style: context.textStyles.bodySmall
                      ?.withColor(AppColors.textSecondary)
                      ?.copyWith(fontSize: context.r.sp(13)),
                ),
              ),
            ),

            SizedBox(height: context.r.h(8)),

            // Word list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: context.r.w(20)),
                itemCount: setup.customWords.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.r.h(6)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.r.w(16),
                        vertical: context.r.h(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                            context.r.r(AppRadius.md)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              setup.customWords[index],
                              style: context.textStyles.bodyLarge
                                  ?.withColor(AppColors.textPrimary)
                                  ?.copyWith(fontSize: context.r.sp(15)),
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref
                                .read(setupProvider.notifier)
                                .removeCustomWord(index),
                            icon: Icon(
                              Icons.close_rounded,
                              color: AppColors.error,
                              size: context.r.sp(20),
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Confirm button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.r.w(20),
                vertical: context.r.h(12),
              ),
              child: SizedBox(
                width: double.infinity,
                height: context.r.h(56),
                child: ElevatedButton(
                  onPressed: () => context.pop(),
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
                  child: Text(l10n.correct.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
