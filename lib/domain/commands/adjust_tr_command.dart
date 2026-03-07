import '../models/game_state.dart';
import '../models/action_log_entry.dart';
import 'game_command.dart';

/// Command to adjust the Terraform Rating
class AdjustTRCommand extends GameCommand {
  final int delta;
  int? _previousTR;
  int? _newTR;

  AdjustTRCommand({required this.delta});

  @override
  GameState execute(GameState state) {
    _previousTR = state.terraformRating;
    _newTR = state.terraformRating + delta;
    return state.copyWith(terraformRating: _newTR);
  }

  @override
  GameState undo(GameState state) {
    if (_previousTR == null) return state;
    return state.copyWith(terraformRating: _previousTR);
  }

  @override
  String get description {
    final prefix = delta >= 0 ? '+' : '';
    return 'TR $prefix$delta';
  }

  @override
  ActionLogEntry createLogEntry(String id) {
    return ActionLogEntry.trChange(
      id: id,
      previousTR: _previousTR ?? 20,
      newTR: _newTR ?? 20 + delta,
    );
  }
}
