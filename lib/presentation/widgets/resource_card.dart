import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/resource_type.dart';
import '../../core/theme/mars_colors.dart';
import '../../domain/models/resource.dart';

/// A compact card widget displaying a single resource with amount, production, and controls
class ResourceCard extends StatelessWidget {
  final Resource resource;
  final void Function(int) onAdjustAmount;
  final void Function(int) onAdjustProduction;

  const ResourceCard({
    super.key,
    required this.resource,
    required this.onAdjustAmount,
    required this.onAdjustProduction,
  });

  @override
  Widget build(BuildContext context) {
    final type = resource.type;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      identifier: 'resource_card_${type.name.toLowerCase()}',
      container: true,
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: type.color.withValues(alpha: 0.3),
              width: 1,
            ),
            color: MarsColors.cardDark,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Amount row
              _buildValueRow(
                context: context,
                type: type,
                value: resource.amount,
                isProduction: false,
                textTheme: textTheme,
              ),

              // Amount controls
              _buildButtonRow(
                resourceType: type,
                isProduction: false,
                onIncrement: onAdjustAmount,
                onDecrement: onAdjustAmount,
              ),

              // Production row
              _buildValueRow(
                context: context,
                type: type,
                value: resource.production,
                isProduction: true,
                textTheme: textTheme,
              ),

              // Production controls
              _buildButtonRow(
                resourceType: type,
                isProduction: true,
                onIncrement: onAdjustProduction,
                onDecrement: onAdjustProduction,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueRow({
    required BuildContext context,
    required ResourceType type,
    required int value,
    required bool isProduction,
    required TextTheme textTheme,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: type.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            isProduction ? Icons.production_quantity_limits : type.icon,
            color: type.color,
            size: 14,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          isProduction ? 'P:' : type.shortName,
          style: textTheme.labelMedium?.copyWith(
            color: type.color,
            fontSize: 10,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: isProduction
                ? MarsColors.terraformGreen.withValues(alpha: 0.2)
                : MarsColors.elevatedDark,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '$value',
            semanticsLabel: '${type.name} ${isProduction ? "production" : "amount"} $value',
            style: textTheme.titleMedium?.copyWith(
              color: isProduction ? MarsColors.terraformGreen : type.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).animate().fadeIn().scale(),
      ],
    );
  }

  Widget _buildButtonRow({
    required ResourceType resourceType,
    required bool isProduction,
    required void Function(int) onIncrement,
    required void Function(int) onDecrement,
  }) {
    final suffix = isProduction ? '_prod' : '_amount';
    // Use enum name for identifier: megacredits -> mc, steel -> steel, etc.
    final idPrefix = _getIdentifierPrefix(resourceType);
    return Row(
      children: [
        // Decrements on the LEFT (red)
        _buildButton(
          label: '-10',
          identifier: '${idPrefix}${suffix}_dec_10',
          color: MarsColors.buttonDecrement,
          onTap: () => onDecrement(-10),
        ),
        _buildButton(
          label: '-5',
          identifier: '${idPrefix}${suffix}_dec_5',
          color: MarsColors.buttonDecrement,
          onTap: () => onDecrement(-5),
        ),
        _buildButton(
          label: '-1',
          identifier: '${idPrefix}${suffix}_dec_1',
          color: MarsColors.buttonDecrement,
          onTap: () => onDecrement(-1),
        ),
        // Increments on the RIGHT (green)
        _buildButton(
          label: '+1',
          identifier: '${idPrefix}${suffix}_inc_1',
          color: MarsColors.buttonIncrement,
          onTap: () => onIncrement(1),
        ),
        _buildButton(
          label: '+5',
          identifier: '${idPrefix}${suffix}_inc_5',
          color: MarsColors.buttonIncrement,
          onTap: () => onIncrement(5),
        ),
        _buildButton(
          label: '+10',
          identifier: '${idPrefix}${suffix}_inc_10',
          color: MarsColors.buttonIncrement,
          onTap: () => onIncrement(10),
        ),
      ],
    );
  }

  /// Returns a test-friendly identifier prefix for the resource type
  String _getIdentifierPrefix(ResourceType type) {
    switch (type) {
      case ResourceType.megacredits:
        return 'mc';
      case ResourceType.steel:
        return 'steel';
      case ResourceType.titanium:
        return 'titanium';
      case ResourceType.plants:
        return 'plants';
      case ResourceType.energy:
        return 'energy';
      case ResourceType.heat:
        return 'heat';
    }
  }

  Widget _buildButton({
    required String label,
    required String identifier,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Semantics(
          identifier: identifier,
          button: true,
          label: label,
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(3),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(3),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
