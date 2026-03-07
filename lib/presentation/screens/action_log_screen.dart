import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/mars_colors.dart';
import '../../domain/models/action_log_entry.dart';
import '../../application/providers/providers.dart';

/// Full-screen action log history
class ActionLogScreen extends ConsumerWidget {
  const ActionLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionLog = ref.watch(actionLogProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.history, color: MarsColors.marsOrange),
            const SizedBox(width: 8),
            Text('Action History', style: textTheme.titleLarge),
          ],
        ),
        backgroundColor: MarsColors.surfaceDark,
        foregroundColor: MarsColors.textPrimary,
      ),
      body: Container(
        color: MarsColors.spaceBlack,
        child: actionLog.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 64,
                      color: MarsColors.textMuted.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No actions yet',
                      style: textTheme.titleMedium?.copyWith(
                        color: MarsColors.textMuted,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: actionLog.length,
                itemBuilder: (context, index) {
                  final entry = actionLog.reversed.toList()[index];
                  return _buildLogEntry(entry, textTheme);
                },
              ),
      ),
    );
  }

  Widget _buildLogEntry(ActionLogEntry entry, TextTheme textTheme) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: MarsColors.cardDark,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getActionColor(entry).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getActionIcon(entry.actionType),
                size: 20,
                color: _getActionColor(entry),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: _getDescriptionColor(entry),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.formattedTime,
                    style: textTheme.bodySmall?.copyWith(
                      color: MarsColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (entry.delta != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: entry.delta! >= 0
                      ? MarsColors.success.withValues(alpha: 0.2)
                      : MarsColors.error.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  entry.delta! >= 0 ? '+${entry.delta}' : '${entry.delta}',
                  style: textTheme.labelLarge?.copyWith(
                    color: entry.delta! >= 0 ? MarsColors.success : MarsColors.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getActionIcon(ActionType type) {
    switch (type) {
      case ActionType.resourceAdjustment:
        return Icons.swap_vert;
      case ActionType.generationChange:
        return Icons.calendar_today;
      case ActionType.trChange:
        return Icons.star;
      case ActionType.reset:
        return Icons.refresh;
      case ActionType.undo:
        return Icons.undo;
    }
  }

  Color _getActionColor(ActionLogEntry entry) {
    switch (entry.actionType) {
      case ActionType.resourceAdjustment:
        return MarsColors.info;
      case ActionType.generationChange:
        return MarsColors.marsRed;
      case ActionType.trChange:
        return MarsColors.terraformGreen;
      case ActionType.reset:
        return MarsColors.warning;
      case ActionType.undo:
        return MarsColors.textSecondary;
    }
  }

  Color _getDescriptionColor(ActionLogEntry entry) {
    if (entry.actionType == ActionType.undo) {
      return MarsColors.textMuted;
    }
    if (entry.delta != null && entry.delta! < 0) {
      return MarsColors.error;
    }
    if (entry.delta != null && entry.delta! > 0) {
      return MarsColors.success;
    }
    return MarsColors.textPrimary;
  }
}
