import 'package:flutter/material.dart';
import 'package:floww/config/constants/app_sizes.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/core/home/providers/home_provider.dart';
import 'package:floww/core/home/widgets/home_card.dart';
import 'package:floww/core/home/widgets/home_card_header.dart';

class NutritionSummaryCard extends StatelessWidget {
  const NutritionSummaryCard({super.key, required this.nutrition, this.onTap});

  final NutritionSummary nutrition;
  final VoidCallback? onTap;

  static const Color _proteinColor = Color(0xFFE94FA1);
  static const Color _carbsColor = Color(0xFF3BA6FF);
  static const Color _fatsColor = Color(0xFFF6A93B);

  bool get _hasData => nutrition.totalCalories > 0;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeCardHeader(
            title: 'Nutrition Summary',
            showChevron: true,
            onTap: onTap,
          ),
          SizedBox(height: AppSpacing.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total Calories',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                '${nutrition.totalCalories}',
                style: context.textTheme.titleLarge?.copyWith(
                  color: _hasData ? context.colors.primary : null,
                ),
              ),
              Text(
                ' / ${nutrition.calorieGoal} kcal',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          _MacroBar(hasData: _hasData),
          SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              _MacroLabel(
                label: 'Protein',
                value: '${nutrition.proteinG}g',
              ),
              _MacroLabel(label: 'Carbs', value: '${nutrition.carbsG}g'),
              _MacroLabel(label: 'Fats', value: '${nutrition.fatsG}g'),
            ],
          ),
          if (!_hasData) ...[
            SizedBox(height: AppSpacing.lg),
            Text(
              'Log meals in Nutrition tab to see your data here →',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MacroBar extends StatelessWidget {
  const _MacroBar({required this.hasData});

  final bool hasData;

  @override
  Widget build(BuildContext context) {
    if (!hasData) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: Container(
          height: AppSizes.s8,
          color: context.colors.backgroundSurface,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        height: AppSizes.s8,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              NutritionSummaryCard._proteinColor,
              NutritionSummaryCard._carbsColor,
              NutritionSummaryCard._fatsColor,
            ],
          ),
        ),
      ),
    );
  }
}

class _MacroLabel extends StatelessWidget {
  const _MacroLabel({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
