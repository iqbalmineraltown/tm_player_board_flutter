import 'package:flutter/material.dart';
import '../../core/theme/mars_colors.dart';
import '../dialogs/reset_confirmation_dialog.dart';

/// Reset button (icon only) with confirmation dialog
class ResetButton extends StatelessWidget {
  final VoidCallback onReset;

  const ResetButton({
    super.key,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: 'reset_button',
      button: true,
      label: 'Reset all resources',
      child: Material(
        color: MarsColors.error.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => _showConfirmationDialog(context),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.refresh,
              size: 20,
              color: MarsColors.error,
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ResetConfirmationDialog(
        onConfirm: onReset,
      ),
    );
  }
}
