import 'dart:math';
import '../models/game_state.dart';
import '../models/action_log_entry.dart';
import '../commands/game_command.dart';

/// Manages the execution, undo, and redo of game commands
class CommandManager {
  final List<_CommandRecord> _undoStack = [];
  final List<_CommandRecord> _redoStack = [];
  final int maxHistorySize;

  CommandManager({this.maxHistorySize = 100});

  /// Executes a command, records it for undo, and returns the new state with optional log entry
  (GameState, ActionLogEntry?) execute(GameCommand command, GameState state) {
    final previousState = state;
    final newState = command.execute(state);

    // Clear redo stack when new command is executed
    _redoStack.clear();

    // Create command record
    final record = _CommandRecord(
      id: _generateId(),
      command: command,
      previousState: previousState,
    );

    // Add to undo stack
    _undoStack.add(record);

    // Trim history if needed
    if (_undoStack.length > maxHistorySize) {
      _undoStack.removeAt(0);
    }

    // Create log entry if command supports it
    ActionLogEntry? logEntry;
    if (command.shouldLog) {
      logEntry = command.createLogEntry(record.id);
    }

    return (newState, logEntry);
  }

  /// Undoes the last command and returns the previous state
  (GameState, ActionLogEntry?) undo(GameState state) {
    if (!canUndo) {
      return (state, null);
    }

    final record = _undoStack.removeLast();
    final previousState = record.previousState;
    final newState = record.command.undo(state);

    // Add to redo stack
    _redoStack.add(record);

    // Create undo log entry
    final logEntry = ActionLogEntry.undo(
      id: _generateId(),
      originalDescription: record.command.description,
    );

    return (previousState, logEntry);
  }

  /// Redoes the last undone command and returns the new state
  (GameState, ActionLogEntry?) redo(GameState state) {
    if (!canRedo) {
      return (state, null);
    }

    final record = _redoStack.removeLast();
    final newState = record.command.execute(state);

    // Add back to undo stack
    _undoStack.add(record);

    // Create log entry if command supports it
    ActionLogEntry? logEntry;
    if (record.command.shouldLog) {
      logEntry = record.command.createLogEntry(record.id);
    }

    return (newState, logEntry);
  }

  /// Whether there are commands that can be undone
  bool get canUndo => _undoStack.isNotEmpty;

  /// Whether there are commands that can be redone
  bool get canRedo => _redoStack.isNotEmpty;

  /// Clears all undo/redo history
  void clearHistory() {
    _undoStack.clear();
    _redoStack.clear();
  }

  String _generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';
  }
}

/// Internal record for tracking command history
class _CommandRecord {
  final String id;
  final GameCommand command;
  final GameState previousState;

  _CommandRecord({
    required this.id,
    required this.command,
    required this.previousState,
  });
}
