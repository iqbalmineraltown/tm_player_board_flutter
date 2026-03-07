import '../models/game_state.dart';
import '../models/action_log_entry.dart';
import 'game_command.dart';

/// Command to adjust the generation counter
class AdjustGenerationCommand extends GameCommand {
  final int delta;
  int? _previousGen;
  int? _newGen;

  AdjustGenerationCommand({required this.delta});

  @override
  GameState execute(GameState state) {
    _previousGen = state.generation;
    _newGen = state.generation + delta;
    return state.copyWith(generation: _newGen);
  }

  @override
  GameState undo(GameState state) {
    if (_previousGen == null) return state;
    return state.copyWith(generation: _previousGen);
  }

  @override
  String get description {
    final prefix = delta >= 0 ? '+' : '';
    return 'Gen $prefix$delta';
  }

  @override
  ActionLogEntry createLogEntry(String id) {
    return ActionLogEntry.generationChange(
      id: id,
      previousGen: _previousGen ?? 1,
      newGen: _newGen ?? 1 + delta,
    );
  }
}
