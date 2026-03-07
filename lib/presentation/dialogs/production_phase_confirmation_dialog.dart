import 'package:flutter/material.dart';
import '../../core/theme/mars_colors.dart';

/// Confirmation dialog for production phase (generation increment)
class ProductionPhaseConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ProductionPhaseConfirmationDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: MarsColors.cardDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: MarsColors.marsRed, width: 2),
      ),
      titlePadding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, color: MarsColors.marsRed, size: 18),
          const SizedBox(width: 8),
          Text(
            'Production Phase',
            style: textTheme.titleMedium?.copyWith(color: MarsColors.textPrimary),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advance to next generation:',
              style: textTheme.bodySmall?.copyWith(color: MarsColors.textSecondary),
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Energy → Heat (then produce)'),
            _buildBulletPoint('MC = Production + TR'),
            _buildBulletPoint('Other resources = Production'),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.undo, color: MarsColors.info, size: 12),
                const SizedBox(width: 4),
                Text(
                  'Can be undone',
                  style: textTheme.bodySmall?.copyWith(color: MarsColors.info, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: textTheme.labelMedium?.copyWith(color: MarsColors.textMuted),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MarsColors.terraformGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('Confirm', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: MarsColors.terraformGreen, fontSize: 11)),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: MarsColors.textPrimary, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows the production phase confirmation dialog
Future<bool> showProductionPhaseConfirmation(
  BuildContext context, {
  required VoidCallback onConfirm,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => ProductionPhaseConfirmationDialog(onConfirm: onConfirm),
  );
  return result ?? false;
}
