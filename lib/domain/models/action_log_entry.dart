import '../../core/constants/resource_type.dart';

/// Represents a single action in the action log
class ActionLogEntry {
  final String id;
  final ActionType actionType;
  final ResourceType? resourceType;
  final int? previousValue;
  final int? newValue;
  final int? delta;
  final bool isProduction;
  final DateTime timestamp;
  final String description;

  ActionLogEntry({
    required this.id,
    required this.actionType,
    this.resourceType,
    this.previousValue,
    this.newValue,
    this.delta,
    this.isProduction = false,
    required this.timestamp,
    required this.description,
  });

  factory ActionLogEntry.resourceAdjustment({
    required String id,
    required ResourceType resourceType,
    required int previousValue,
    required int newValue,
    required bool isProduction,
  }) {
    final delta = newValue - previousValue;
    final prefix = delta >= 0 ? '+' : '';
    final suffix = isProduction ? ' prod' : '';
    return ActionLogEntry(
      id: id,
      actionType: ActionType.resourceAdjustment,
      resourceType: resourceType,
      previousValue: previousValue,
      newValue: newValue,
      delta: delta,
      isProduction: isProduction,
      timestamp: DateTime.now(),
      description: '$prefix$delta ${resourceType.shortName}$suffix',
    );
  }

  factory ActionLogEntry.generationChange({
    required String id,
    required int previousGen,
    required int newGen,
  }) {
    return ActionLogEntry(
      id: id,
      actionType: ActionType.generationChange,
      previousValue: previousGen,
      newValue: newGen,
      delta: newGen - previousGen,
      timestamp: DateTime.now(),
      description: 'Generation $previousGen → $newGen',
    );
  }

  factory ActionLogEntry.trChange({
    required String id,
    required int previousTR,
    required int newTR,
  }) {
    final delta = newTR - previousTR;
    final prefix = delta >= 0 ? '+' : '';
    return ActionLogEntry(
      id: id,
      actionType: ActionType.trChange,
      previousValue: previousTR,
      newValue: newTR,
      delta: delta,
      timestamp: DateTime.now(),
      description: 'TR $prefix$delta ($previousTR → $newTR)',
    );
  }

  factory ActionLogEntry.reset({
    required String id,
  }) {
    return ActionLogEntry(
      id: id,
      actionType: ActionType.reset,
      timestamp: DateTime.now(),
      description: 'Game Reset',
    );
  }

  factory ActionLogEntry.undo({
    required String id,
    required String originalDescription,
  }) {
    return ActionLogEntry(
      id: id,
      actionType: ActionType.undo,
      timestamp: DateTime.now(),
      description: 'Undo: $originalDescription',
    );
  }

  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final second = timestamp.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'actionType': actionType.name,
      'resourceType': resourceType?.name,
      'previousValue': previousValue,
      'newValue': newValue,
      'delta': delta,
      'isProduction': isProduction,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
    };
  }

  factory ActionLogEntry.fromJson(Map<String, dynamic> json) {
    return ActionLogEntry(
      id: json['id'] as String,
      actionType: ActionType.values.firstWhere(
        (e) => e.name == json['actionType'],
      ),
      resourceType: json['resourceType'] != null
          ? ResourceType.values.firstWhere((e) => e.name == json['resourceType'])
          : null,
      previousValue: json['previousValue'] as int?,
      newValue: json['newValue'] as int?,
      delta: json['delta'] as int?,
      isProduction: json['isProduction'] as bool? ?? false,
      timestamp: DateTime.parse(json['timestamp'] as String),
      description: json['description'] as String,
    );
  }
}

/// Types of actions that can be logged
enum ActionType {
  resourceAdjustment,
  generationChange,
  trChange,
  reset,
  undo,
}
