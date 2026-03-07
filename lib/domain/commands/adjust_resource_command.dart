import '../../core/constants/resource_type.dart';
import '../models/game_state.dart';
import '../models/action_log_entry.dart';
import 'game_command.dart';

/// Command to adjust a resource's amount or production
class AdjustResourceCommand extends GameCommand {
  final ResourceType resourceType;
  final int delta;
  final bool isProduction;
  int? _previousValue;
  int? _newValue;

  AdjustResourceCommand({
    required this.resourceType,
    required this.delta,
    this.isProduction = false,
  });

  @override
  GameState execute(GameState state) {
    final resource = state.getResource(resourceType);
    _previousValue = isProduction ? resource.production : resource.amount;
    _newValue = _previousValue! + delta;

    if (isProduction) {
      return state.withResourceProduction(resourceType, _newValue!);
    } else {
      return state.withResourceAmount(resourceType, _newValue!);
    }
  }

  @override
  GameState undo(GameState state) {
    if (_previousValue == null) return state;

    if (isProduction) {
      return state.withResourceProduction(resourceType, _previousValue!);
    } else {
      return state.withResourceAmount(resourceType, _previousValue!);
    }
  }

  @override
  String get description {
    final prefix = delta >= 0 ? '+' : '';
    final suffix = isProduction ? ' prod' : '';
    return '$prefix$delta ${resourceType.shortName}$suffix';
  }

  @override
  ActionLogEntry createLogEntry(String id) {
    return ActionLogEntry.resourceAdjustment(
      id: id,
      resourceType: resourceType,
      previousValue: _previousValue ?? 0,
      newValue: _newValue ?? delta,
      isProduction: isProduction,
    );
  }
}
