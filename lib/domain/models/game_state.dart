import '../../core/constants/resource_type.dart';
import 'resource.dart';

/// Represents the complete game state for a single player
class GameState {
  final Map<ResourceType, Resource> resources;
  int generation;
  int terraformRating;
  DateTime lastUpdated;

  GameState({
    required this.resources,
    this.generation = 1,
    this.terraformRating = 20,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  /// Creates a new game state with default values
  factory GameState.initial() {
    final resources = <ResourceType, Resource>{};
    for (final type in ResourceType.values) {
      resources[type] = Resource.defaultValue(type);
    }
    return GameState(
      resources: resources,
      generation: 1,
      terraformRating: 20,
    );
  }

  /// Gets a specific resource by type
  Resource getResource(ResourceType type) => resources[type]!;

  /// Updates a specific resource's amount
  GameState withResourceAmount(ResourceType type, int amount) {
    final newResources = Map<ResourceType, Resource>.from(resources);
    newResources[type] = resources[type]!.copyWith(amount: amount);
    return copyWith(resources: newResources);
  }

  /// Updates a specific resource's production
  GameState withResourceProduction(ResourceType type, int production) {
    final newResources = Map<ResourceType, Resource>.from(resources);
    newResources[type] = resources[type]!.copyWith(production: production);
    return copyWith(resources: newResources);
  }

  GameState copyWith({
    Map<ResourceType, Resource>? resources,
    int? generation,
    int? terraformRating,
    DateTime? lastUpdated,
  }) {
    return GameState(
      resources: resources ?? this.resources,
      generation: generation ?? this.generation,
      terraformRating: terraformRating ?? this.terraformRating,
      lastUpdated: lastUpdated ?? DateTime.now(),
    );
  }

  /// Creates a reset game state
  factory GameState.reset() => GameState.initial();

  Map<String, dynamic> toJson() {
    return {
      'resources': resources.map(
        (key, value) => MapEntry(key.name, {
          'amount': value.amount,
          'production': value.production,
        }),
      ),
      'generation': generation,
      'terraformRating': terraformRating,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory GameState.fromJson(Map<String, dynamic> json) {
    final resources = <ResourceType, Resource>{};
    for (final type in ResourceType.values) {
      final resourceData = json['resources'][type.name] as Map<String, dynamic>;
      resources[type] = Resource(
        type: type,
        amount: resourceData['amount'] as int,
        production: resourceData['production'] as int,
      );
    }
    return GameState(
      resources: resources,
      generation: json['generation'] as int,
      terraformRating: json['terraformRating'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  @override
  String toString() {
    return 'GameState(gen: $generation, TR: $terraformRating, resources: ${resources.length})';
  }
}
