import '../models/game_state.dart';
import '../models/action_log_entry.dart';

/// Abstract base class for all game commands (Command Pattern)
/// Enables undo/redo functionality
abstract class GameCommand {
  /// Executes the command and returns the new game state
  GameState execute(GameState state);

  /// Undoes the command and returns the previous game state
  GameState undo(GameState state);

  /// Human-readable description of the command
  String get description;

  /// Whether this command should create an action log entry
  bool get shouldLog => true;

  /// Creates an action log entry for this command
  ActionLogEntry createLogEntry(String id);
}
