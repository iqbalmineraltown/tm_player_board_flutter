import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/mars_colors.dart';
import '../dialogs/production_phase_confirmation_dialog.dart';

/// Widget displaying the current generation with production phase button
/// Generation can only be incremented via production phase (with confirmation)
class GenerationDisplay extends StatelessWidget {
  final int generation;
  final VoidCallback onProductionPhase;

  const GenerationDisplay({
    super.key,
    required this.generation,
    required this.onProductionPhase,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      identifier: 'generation_display',
      container: true,
      explicitChildNodes: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: MarsColors.surfaceDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: MarsColors.marsRed.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_today,
              color: MarsColors.marsRed,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text('GEN', style: textTheme.bodySmall),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: MarsColors.marsRed.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$generation',
                semanticsLabel: 'Generation $generation',
                style: textTheme.headlineMedium?.copyWith(
                  color: MarsColors.marsRed,
                  fontSize: 18,
                ),
              ),
            ).animate().fadeIn().scale(),
            const SizedBox(width: 4),
            // Production phase button (increment generation)
            _buildProductionPhaseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductionPhaseButton(BuildContext context) {
    return Semantics(
      identifier: 'generation_increment',
      button: true,
      label: 'Production phase - next generation',
      child: Material(
        color: MarsColors.terraformGreen.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () => _showProductionPhaseConfirmation(context),
          borderRadius: BorderRadius.circular(6),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(
              Icons.add,
              color: MarsColors.terraformGreen,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }

  void _showProductionPhaseConfirmation(BuildContext context) {
    showProductionPhaseConfirmation(context, onConfirm: onProductionPhase);
  }
}
