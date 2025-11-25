import 'package:flutter/material.dart';
import '../../domain/entities/menu_item.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';

/// Small widget for displaying a menu item card
class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback? onTap;

  const MenuItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return AppCardElevated(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, brightness),
          if (item.description != null) ...[
            const SizedBox(height: 8),
            Text(
              item.description!,
              style: AppTextStyles.bodySmall(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 12),
          _buildFooter(context, brightness),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Brightness brightness) {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.name,
            style: AppTextStyles.titleMedium(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary(brightness).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            item.price.toCurrency(),
            style: AppTextStyles.titleSmall(context).copyWith(
              color: AppColors.primary(brightness),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, Brightness brightness) {
    return Row(
      children: [
        Icon(
          Icons.local_fire_department,
          size: 16,
          color: AppColors.textSecondary(brightness),
        ),
        const SizedBox(width: 4),
        Text(
          '${item.calories} cal',
          style: AppTextStyles.bodySmall(context),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: item.tags.take(3).map((tag) => _TagChip(tag: tag)).toList(),
          ),
        ),
      ],
    );
  }
}

/// Small chip for displaying tags
class _TagChip extends StatelessWidget {
  final String tag;

  const _TagChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: brightness == Brightness.light
            ? AppColors.lightSurfaceVariant
            : AppColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tag,
        style: AppTextStyles.labelSmall(context),
      ),
    );
  }
}
