import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/mars_colors.dart';

/// Widget displaying the Terraform Rating with increment/decrement controls
class TRDisplay extends StatelessWidget {
  final int terraformRating;
  final void Function(int) onAdjust;

  const TRDisplay({
    super.key,
    required this.terraformRating,
    required this.onAdjust,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      identifier: 'tr_display',
      container: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: MarsColors.surfaceDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: MarsColors.terraformGreen.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              color: MarsColors.terraformGreen,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text('TR', style: textTheme.bodySmall),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: MarsColors.terraformGreen.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$terraformRating',
                semanticsLabel: 'Terraform Rating $terraformRating',
                style: textTheme.headlineMedium?.copyWith(
                  color: MarsColors.terraformGreen,
                  fontSize: 18,
                ),
              ),
            ).animate().fadeIn().scale(),
            const SizedBox(width: 4),
            _buildControlButton(
              identifier: 'tr_decrement',
              icon: Icons.remove,
              onTap: () => onAdjust(-1),
            ),
            _buildControlButton(
              identifier: 'tr_increment',
              icon: Icons.add,
              onTap: () => onAdjust(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required String identifier,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Semantics(
      identifier: identifier,
      button: true,
      label: identifier.contains('increment') ? 'Increase TR' : 'Decrease TR',
      child: Material(
        color: MarsColors.elevatedDark,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              icon,
              color: MarsColors.textPrimary,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}
