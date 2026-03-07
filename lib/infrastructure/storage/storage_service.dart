import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/models/game_state.dart';
import '../../domain/models/action_log_entry.dart';

/// Hive-based implementation of storage service
class StorageService {
  static const String _gameStateBox = 'game_state_box';
  static const String _actionLogBox = 'action_log_box';
  static const String _gameStateKey = 'current_game';
  static const String _actionLogKey = 'action_log';

  bool _isInitialized = false;

  /// Initializes Hive for storage
  Future<void> initialize() async {
    if (_isInitialized) return;

    await Hive.initFlutter();

    // Open boxes with string values for JSON storage
    await Hive.openBox<String>(_gameStateBox);
    await Hive.openBox<String>(_actionLogBox);

    _isInitialized = true;
  }

  /// Saves the current game state
  Future<void> saveGameState(GameState state) async {
    final box = Hive.box<String>(_gameStateBox);
    final jsonString = jsonEncode(state.toJson());
    await box.put(_gameStateKey, jsonString);
  }

  /// Loads the saved game state, returns null if none exists
  Future<GameState?> loadGameState() async {
    final box = Hive.box<String>(_gameStateBox);
    final jsonString = box.get(_gameStateKey);
    if (jsonString == null) return null;

    try {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return GameState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  /// Saves the action log
  Future<void> saveActionLog(List<ActionLogEntry> entries) async {
    final box = Hive.box<String>(_actionLogBox);
    final jsonList = entries.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await box.put(_actionLogKey, jsonString);
  }

  /// Loads the action log
  Future<List<ActionLogEntry>> loadActionLog() async {
    final box = Hive.box<String>(_actionLogBox);
    final jsonString = box.get(_actionLogKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => ActionLogEntry.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Clears all saved data
  Future<void> clearAll() async {
    final gameStateBox = Hive.box<String>(_gameStateBox);
    final actionLogBox = Hive.box<String>(_actionLogBox);
    await gameStateBox.clear();
    await actionLogBox.clear();
  }
}
