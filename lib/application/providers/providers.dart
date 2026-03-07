import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/game_state.dart';
import '../../domain/models/action_log_entry.dart';
import '../../domain/services/command_manager.dart';
import '../../infrastructure/storage/storage_service.dart';
import '../notifiers/game_state_notifier.dart';

/// Storage service provider
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

/// Command manager provider
final commandManagerProvider = Provider<CommandManager>((ref) {
  return CommandManager();
});

/// Game state provider
final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  final commandManager = ref.watch(commandManagerProvider);

  return GameStateNotifier(
    commandManager: commandManager,
    initialState: GameState.initial(),
    ref: ref,
  )..loadFromStorage();
});

/// Action log provider
final actionLogProvider = StateNotifierProvider<ActionLogNotifier, List<ActionLogEntry>>((ref) {
  return ActionLogNotifier(
    initialEntries: [],
    ref: ref,
  )..loadFromStorage();
});

/// Whether undo is available
final canUndoProvider = Provider<bool>((ref) {
  ref.watch(gameStateProvider);
  return ref.read(gameStateProvider.notifier).canUndo;
});

/// Whether redo is available
final canRedoProvider = Provider<bool>((ref) {
  ref.watch(gameStateProvider);
  return ref.read(gameStateProvider.notifier).canRedo;
});
