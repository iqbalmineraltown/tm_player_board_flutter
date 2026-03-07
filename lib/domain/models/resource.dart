import '../../core/constants/resource_type.dart';

/// Represents a single resource with amount and production values
class Resource {
  final ResourceType type;
  int amount;
  int production;

  Resource({
    required this.type,
    this.amount = 0,
    this.production = 0,
  });

  Resource copyWith({
    ResourceType? type,
    int? amount,
    int? production,
  }) {
    return Resource(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      production: production ?? this.production,
    );
  }

  /// Creates a resource with default starting values
  factory Resource.defaultValue(ResourceType type) {
    return Resource(type: type, amount: 0, production: 0);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Resource &&
        other.type == type &&
        other.amount == amount &&
        other.production == production;
  }

  @override
  int get hashCode => Object.hash(type, amount, production);

  @override
  String toString() => 'Resource(${type.name}: $amount, prod: $production)';
}
