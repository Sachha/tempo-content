import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/l10n/app_localizations.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/category_providers.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final categories = ref.watch(categoriesProvider);
    final selectedIds = ref.watch(selectedCategoryIdsProvider);

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
                      l10n.categories.toUpperCase(),
                      style: context.textStyles.titleLarge?.bold
                          ?.copyWith(fontSize: context.r.sp(22)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: context.r.w(48)),
                ],
              ),
            ),

            // Selected count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.r.w(20)),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${selectedIds.length} selected',
                  style: context.textStyles.bodySmall
                      ?.withColor(AppColors.textSecondary)
                      ?.copyWith(fontSize: context.r.sp(13)),
                ),
              ),
            ),

            SizedBox(height: context.r.h(8)),

            // Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: context.r.w(20),
                  vertical: context.r.h(8),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: context.r.w(12),
                  mainAxisSpacing: context.r.h(12),
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedIds.contains(cat.id);
                  return GestureDetector(
                    onTap: () => ref
                        .read(selectedCategoryIdsProvider.notifier)
                        .toggle(cat.id),
                    child: AnimatedContainer(
                      duration: 200.ms,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(
                            context.r.r(AppRadius.lg)),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cat.emoji,
                            style:
                                TextStyle(fontSize: context.r.sp(40)),
                          ),
                          SizedBox(height: context.r.h(8)),
                          Text(
                            cat.nameKey,
                            style: context.textStyles.bodyMedium?.bold
                                .withColor(isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary)
                                ?.copyWith(fontSize: context.r.sp(14)),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: context.r.h(4)),
                          Text(
                            l10n.wordCount(cat.wordCount),
                            style: context.textStyles.bodySmall
                                ?.withColor(AppColors.textLight)
                                ?.copyWith(fontSize: context.r.sp(11)),
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(
                          delay: (100 + 50 * index).ms, duration: 300.ms)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        delay: (100 + 50 * index).ms,
                        duration: 300.ms,
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
                  onPressed:
                      selectedIds.isNotEmpty ? () => context.pop() : null,
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
