import 'package:flutter/material.dart';
import '../../domain/entities/menu_item.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_button.dart';

/// Modal showing detailed information about a menu item
class MenuItemDetailModal extends StatelessWidget {
  final MenuItem item;

  const MenuItemDetailModal({
    super.key,
    required this.item,
  });

  static Future<void> show(BuildContext context, MenuItem item) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MenuItemDetailModal(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final backgroundColor = brightness == Brightness.light
        ? AppColors.lightBackground
        : AppColors.darkSurface;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              _buildDragHandle(),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImage(context),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(context, brightness),
                            const SizedBox(height: 16),
                            _buildInfoCards(context, brightness),
                            const SizedBox(height: 20),
                            _buildDescription(context, brightness),
                            const SizedBox(height: 20),
                            _buildIngredients(context, brightness),
                            const SizedBox(height: 20),
                            _buildTags(context, brightness),
                            const SizedBox(height: 24),
                            _buildOrderButton(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final hasImage = item.imageUrl != null && item.imageUrl!.isNotEmpty;
    
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: hasImage ? null : AppColors.lightSurfaceVariant,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: hasImage
          ? ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.network(
                item.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage();
                },
              ),
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Center(
      child: Icon(
        Icons.restaurant_menu,
        size: 64,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Brightness brightness) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: AppTextStyles.headlineMedium(context),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary(brightness),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.price.toCurrency(),
                style: AppTextStyles.titleLarge(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            _buildAvailabilityChip(brightness),
          ],
        ),
      ],
    );
  }

  Widget _buildAvailabilityChip(Brightness brightness) {
    final available = item.quantityAvailable;
    final isAvailable = item.isAvailable;
    final color = !isAvailable 
        ? AppColors.error 
        : available > 10 
            ? AppColors.success 
            : AppColors.warning;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            '$available left',
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards(BuildContext context, Brightness brightness) {
    return Row(
      children: [
        Expanded(
          child: _InfoCard(
            icon: Icons.local_fire_department,
            label: 'Calories',
            value: '${item.calories}',
            brightness: brightness,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _InfoCard(
            icon: Icons.inventory_2_outlined,
            label: 'Available',
            value: '${item.quantityAvailable}',
            brightness: brightness,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, Brightness brightness) {
    if (item.description == null || item.description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyles.titleMedium(context),
        ),
        const SizedBox(height: 8),
        Text(
          item.description!,
          style: AppTextStyles.bodyMedium(context),
        ),
      ],
    );
  }

  Widget _buildIngredients(BuildContext context, Brightness brightness) {
    if (item.ingredients.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: AppTextStyles.titleMedium(context),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: item.ingredients.map((ingredient) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: brightness == Brightness.light
                    ? AppColors.lightSurfaceVariant
                    : AppColors.darkSurfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: AppColors.primary(brightness),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    ingredient,
                    style: AppTextStyles.bodySmall(context),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTags(BuildContext context, Brightness brightness) {
    if (item.tags.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dietary Tags',
          style: AppTextStyles.titleMedium(context),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: item.tags.map((tag) {
            return Chip(
              label: Text(
                tag,
                style: AppTextStyles.labelMedium(context),
              ),
              backgroundColor: AppColors.primary(brightness).withOpacity(0.1),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOrderButton(BuildContext context) {
    return AppButton.primary(
      text: 'Add to Order',
      icon: Icons.shopping_cart_outlined,
      onPressed: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Brightness brightness;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: brightness == Brightness.light
            ? AppColors.lightSurfaceVariant
            : AppColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: AppColors.primary(brightness),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
