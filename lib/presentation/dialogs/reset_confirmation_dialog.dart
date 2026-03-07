import 'package:flutter/material.dart';
import '../../core/theme/mars_colors.dart';

/// Confirmation dialog for resetting the game
class ResetConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ResetConfirmationDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: MarsColors.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: MarsColors.error, width: 2),
      ),
      title: Row(
        children: [
          const Icon(Icons.warning, color: MarsColors.warning),
          const SizedBox(width: 8),
          Text('Reset Game?', style: textTheme.headlineMedium),
        ],
      ),
      content: Text(
        'This will reset all resources to 0, production to 0, generation to 1, and TR to 20.\n\nThis action cannot be undone.',
        style: textTheme.bodyLarge,
      ),
      actions: [
        Semantics(
          identifier: 'reset_cancel_button',
          button: true,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: MarsColors.textSecondary),
            ),
          ),
        ),
        Semantics(
          identifier: 'reset_confirm_button',
          button: true,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MarsColors.error,
            ),
            child: const Text('Reset'),
          ),
        ),
      ],
    );
  }
}
