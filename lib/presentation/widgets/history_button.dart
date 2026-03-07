import 'package:flutter/material.dart';
import '../../core/theme/mars_colors.dart';
import '../screens/action_log_screen.dart';

/// History button to open the action log page
class HistoryButton extends StatelessWidget {
  final int entryCount;

  const HistoryButton({
    super.key,
    required this.entryCount,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: 'history_button',
      button: true,
      label: 'View action history',
      child: Material(
        color: MarsColors.marsOrange.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => _openHistoryPage(context),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                const Icon(
                  Icons.history,
                  size: 20,
                  color: MarsColors.marsOrange,
                ),
                if (entryCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: MarsColors.marsRed,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(minWidth: 12),
                      child: Text(
                        entryCount > 99 ? '99+' : '$entryCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openHistoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ActionLogScreen(),
      ),
    );
  }
}
