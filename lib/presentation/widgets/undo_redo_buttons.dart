import 'package:flutter/material.dart';
import '../../core/theme/mars_colors.dart';

/// Row of undo/redo buttons (icon only)
class UndoRedoButtons extends StatelessWidget {
  final bool canUndo;
  final bool canRedo;
  final VoidCallback onUndo;
  final VoidCallback onRedo;

  const UndoRedoButtons({
    super.key,
    required this.canUndo,
    required this.canRedo,
    required this.onUndo,
    required this.onRedo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(
          identifier: 'undo_button',
          icon: Icons.undo,
          label: 'Undo',
          enabled: canUndo,
          onTap: onUndo,
        ),
        const SizedBox(width: 4),
        _buildIconButton(
          identifier: 'redo_button',
          icon: Icons.redo,
          label: 'Redo',
          enabled: canRedo,
          onTap: onRedo,
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String identifier,
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Semantics(
      identifier: identifier,
      button: true,
      enabled: enabled,
      label: label,
      child: Material(
        color: enabled ? MarsColors.elevatedDark : MarsColors.elevatedDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              size: 20,
              color: enabled ? MarsColors.textPrimary : MarsColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
