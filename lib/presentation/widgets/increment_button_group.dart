import 'package:flutter/material.dart';
import '../../core/theme/mars_colors.dart';

/// A group of increment/decrement buttons with values 1, 5, 10
class IncrementButtonGroup extends StatelessWidget {
  final void Function(int) onIncrement;
  final void Function(int) onDecrement;
  final String resourceType;
  final bool isProduction;
  final bool enabled;

  const IncrementButtonGroup({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.resourceType,
    this.isProduction = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final suffix = isProduction ? '_prod' : '_amount';
    return Column(
      children: [
        // Increment buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              label: '+1',
              identifier: '${resourceType.toLowerCase()}${suffix}_inc_1',
              color: MarsColors.buttonIncrement,
              onTap: enabled ? () => onIncrement(1) : null,
            ),
            _buildButton(
              label: '+5',
              identifier: '${resourceType.toLowerCase()}${suffix}_inc_5',
              color: MarsColors.buttonIncrement,
              onTap: enabled ? () => onIncrement(5) : null,
            ),
            _buildButton(
              label: '+10',
              identifier: '${resourceType.toLowerCase()}${suffix}_inc_10',
              color: MarsColors.buttonIncrement,
              onTap: enabled ? () => onIncrement(10) : null,
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Decrement buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              label: '-1',
              identifier: '${resourceType.toLowerCase()}${suffix}_dec_1',
              color: MarsColors.buttonDecrement,
              onTap: enabled ? () => onDecrement(1) : null,
            ),
            _buildButton(
              label: '-5',
              identifier: '${resourceType.toLowerCase()}${suffix}_dec_5',
              color: MarsColors.buttonDecrement,
              onTap: enabled ? () => onDecrement(5) : null,
            ),
            _buildButton(
              label: '-10',
              identifier: '${resourceType.toLowerCase()}${suffix}_dec_10',
              color: MarsColors.buttonDecrement,
              onTap: enabled ? () => onDecrement(10) : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required String identifier,
    required Color color,
    required VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Semantics(
          identifier: identifier,
          button: true,
          enabled: isEnabled,
          label: '$label for $resourceType${isProduction ? ' production' : ''}',
          child: Material(
            color: isEnabled ? color : color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    color: isEnabled ? Colors.white : Colors.white54,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
