import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/game_state.dart';
import '../../domain/models/action_log_entry.dart';
import '../../domain/services/command_manager.dart';
import '../../domain/commands/commands.dart';
import '../../domain/commands/production_phase_command.dart';
import '../../core/constants/resource_type.dart';
import '../providers/providers.dart';

/// Notifier that manages the game state with undo/redo support
class GameStateNotifier extends StateNotifier<GameState> {
  final CommandManager _commandManager;
  final Ref _ref;

  GameStateNotifier({
    required CommandManager commandManager,
    required GameState initialState,
    required Ref ref,
  })  : _commandManager = commandManager,
        _ref = ref,
        super(initialState);

  /// Adjusts a resource's amount by the given delta
  void adjustResourceAmount(ResourceType type, int delta) {
    final command = AdjustResourceCommand(
      resourceType: type,
      delta: delta,
      isProduction: false,
    );
    _executeCommand(command);
  }

  /// Adjusts a resource's production by the given delta
  void adjustResourceProduction(ResourceType type, int delta) {
    final command = AdjustResourceCommand(
      resourceType: type,
      delta: delta,
      isProduction: true,
    );
    _executeCommand(command);
  }

  /// Adjusts the generation counter
  void adjustGeneration(int delta) {
    final command = AdjustGenerationCommand(delta: delta);
    _executeCommand(command);
  }

  /// Adjusts the Terraform Rating
  void adjustTR(int delta) {
    final command = AdjustTRCommand(delta: delta);
    _executeCommand(command);
  }

  /// Resets the game to initial state
  void resetGame() {
    final command = ResetGameCommand(state);
    _executeCommand(command);
    _commandManager.clearHistory();
    // Clear action log on reset
    _ref.read(actionLogProvider.notifier).clear();
  }

  /// Executes production phase (increment generation with resource production)
  void productionPhase() {
    final command = ProductionPhaseCommand(
      previousGeneration: state.generation,
      previousResources: state.resources,
      previousTR: state.terraformRating,
    );
    _executeCommand(command);
  }

  /// Undoes the last action
  void undo() {
    if (!_commandManager.canUndo) return;

    final (newState, logEntry) = _commandManager.undo(state);
    state = newState;

    if (logEntry != null) {
      _ref.read(actionLogProvider.notifier).addEntry(logEntry);
    }

    _saveState();
  }

  /// Redoes the last undone action
  void redo() {
    if (!_commandManager.canRedo) return;

    final (newState, logEntry) = _commandManager.redo(state);
    state = newState;

    if (logEntry != null) {
      _ref.read(actionLogProvider.notifier).addEntry(logEntry);
    }

    _saveState();
  }

  /// Whether undo is available
  bool get canUndo => _commandManager.canUndo;

  /// Whether redo is available
  bool get canRedo => _commandManager.canRedo;

  /// Loads state from storage
  Future<void> loadFromStorage() async {
    final storage = _ref.read(storageServiceProvider);
    final savedState = await storage.loadGameState();
    if (savedState != null) {
      state = savedState;
    }
  }

  void _executeCommand(GameCommand command) {
    final (newState, logEntry) = _commandManager.execute(command, state);
    state = newState;

    if (logEntry != null) {
      _ref.read(actionLogProvider.notifier).addEntry(logEntry);
    }

    _saveState();
  }

  void _saveState() {
    final storage = _ref.read(storageServiceProvider);
    storage.saveGameState(state);
  }
}

/// Notifier for managing the action log
class ActionLogNotifier extends StateNotifier<List<ActionLogEntry>> {
  final Ref _ref;

  ActionLogNotifier({
    required List<ActionLogEntry> initialEntries,
    required Ref ref,
  })  : _ref = ref,
        super(initialEntries);

  void addEntry(ActionLogEntry entry) {
    state = [...state, entry];
    _saveLog();
  }

  void clear() {
    state = [];
    _saveLog();
  }

  Future<void> loadFromStorage() async {
    final storage = _ref.read(storageServiceProvider);
    final entries = await storage.loadActionLog();
    state = entries;
  }

  void _saveLog() {
    final storage = _ref.read(storageServiceProvider);
    storage.saveActionLog(state);
  }
}
