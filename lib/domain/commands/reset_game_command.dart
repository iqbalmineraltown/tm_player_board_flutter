import '../models/game_state.dart';
import '../models/action_log_entry.dart';
import 'game_command.dart';

/// Command to reset the entire game state
class ResetGameCommand extends GameCommand {
  final GameState _previousState;

  ResetGameCommand(this._previousState);

  @override
  GameState execute(GameState state) {
    return GameState.reset();
  }

  @override
  GameState undo(GameState state) {
    return _previousState;
  }

  @override
  String get description => 'Reset Game';

  @override
  ActionLogEntry createLogEntry(String id) {
    return ActionLogEntry.reset(id: id);
  }
}
