import 'package:flutter/material.dart';
import '../../core/theme/mars_colors.dart';
import '../../domain/models/action_log_entry.dart';

/// Collapsible panel showing the action log history
class ActionLogPanel extends StatefulWidget {
  final List<ActionLogEntry> entries;
  final bool initiallyExpanded;

  const ActionLogPanel({
    super.key,
    required this.entries,
    this.initiallyExpanded = false,
  });

  @override
  State<ActionLogPanel> createState() => _ActionLogPanelState();
}

class _ActionLogPanelState extends State<ActionLogPanel> {
  late bool _isExpanded;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final recentEntries = widget.entries.reversed.take(50).toList();

    return Semantics(
      identifier: 'action_log_panel',
      container: true,
      child: Container(
        decoration: BoxDecoration(
          color: MarsColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Semantics(
              identifier: 'action_log_header',
              button: true,
              label: 'Action log, ${widget.entries.length} entries. Tap to ${_isExpanded ? "collapse" : "expand"}',
              child: InkWell(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.history,
                        color: MarsColors.marsOrange,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Action Log',
                        style: textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: MarsColors.elevatedDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${widget.entries.length}',
                          style: textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: MarsColors.textSecondary,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Log entries - only show when expanded
            if (_isExpanded)
              Flexible(
                child: recentEntries.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'No actions yet',
                          style: textTheme.bodySmall,
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: recentEntries.length,
                        itemBuilder: (context, index) {
                          final entry = recentEntries[index];
                          return _buildLogEntry(entry, textTheme);
                        },
                      ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogEntry(ActionLogEntry entry, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Row(
        children: [
          Text(
            entry.formattedTime,
            style: textTheme.bodySmall?.copyWith(
              color: MarsColors.textMuted,
              fontSize: 9,
            ),
          ),
          const SizedBox(width: 8),
          _buildActionTypeIcon(entry.actionType),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              entry.description,
              style: textTheme.bodySmall?.copyWith(
                color: _getDescriptionColor(entry),
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTypeIcon(ActionType type) {
    IconData icon;
    Color color;

    switch (type) {
      case ActionType.resourceAdjustment:
        icon = Icons.swap_vert;
        color = MarsColors.info;
        break;
      case ActionType.generationChange:
        icon = Icons.calendar_today;
        color = MarsColors.marsRed;
        break;
      case ActionType.trChange:
        icon = Icons.star;
        color = MarsColors.terraformGreen;
        break;
      case ActionType.reset:
        icon = Icons.refresh;
        color = MarsColors.warning;
        break;
      case ActionType.undo:
        icon = Icons.undo;
        color = MarsColors.textSecondary;
        break;
    }

    return Icon(icon, size: 14, color: color);
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
