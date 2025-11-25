import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Small widget for filter chips
class MenuFilterChips extends StatelessWidget {
  final List<String> availableTags;
  final List<String> selectedTags;
  final Function(String) onTagToggle;
  final VoidCallback onClearAll;

  const MenuFilterChips({
    super.key,
    required this.availableTags,
    required this.selectedTags,
    required this.onTagToggle,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter by tags',
                style: AppTextStyles.titleSmall(context),
              ),
              if (selectedTags.isNotEmpty)
                TextButton(
                  onPressed: onClearAll,
                  child: Text(
                    'Clear all',
                    style: AppTextStyles.labelMedium(context).copyWith(
                      color: AppColors.primary(brightness),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: availableTags.length,
            itemBuilder: (context, index) {
              final tag = availableTags[index];
              final isSelected = selectedTags.contains(tag);

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (_) => onTagToggle(tag),
                  backgroundColor: brightness == Brightness.light
                      ? AppColors.lightSurfaceVariant
                      : AppColors.darkSurfaceVariant,
                  selectedColor: AppColors.primary(brightness).withOpacity(0.2),
                  checkmarkColor: AppColors.primary(brightness),
                  labelStyle: AppTextStyles.labelMedium(context).copyWith(
                    color: isSelected
                        ? AppColors.primary(brightness)
                        : AppColors.textSecondary(brightness),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
