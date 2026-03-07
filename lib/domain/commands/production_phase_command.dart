import 'game_command.dart';
import '../../domain/models/game_state.dart';
import '../../domain/models/resource.dart';
import '../../domain/models/action_log_entry.dart';
import '../../core/constants/resource_type.dart';

/// Command that executes the production phase when generation increments
/// Rules:
/// - Energy converts to heat before production (energy resets to 0)
/// - MC production = MC production rate + TR
/// - All other resources = production rate
class ProductionPhaseCommand implements GameCommand {
  final int _previousGeneration;
  final Map<ResourceType, Resource> _previousResources;
  final int _previousTR;

  ProductionPhaseCommand({
    required int previousGeneration,
    required Map<ResourceType, Resource> previousResources,
    required int previousTR,
  })  : _previousGeneration = previousGeneration,
        _previousResources = Map.from(previousResources),
        _previousTR = previousTR;

  @override
  String get description => 'Production phase: Gen $_previousGeneration → ${_previousGeneration + 1}';

  @override
  bool get shouldLog => true;

  @override
  GameState execute(GameState state) {
    final newResources = Map<ResourceType, Resource>.from(state.resources);

    // Get current TR for MC production calculation
    final tr = state.terraformRating;

    // First, handle energy -> heat conversion
    final energyResource = newResources[ResourceType.energy]!;
    final energyAmount = energyResource.amount;
    final energyProduction = energyResource.production;

    // Add existing energy to heat
    final heatResource = newResources[ResourceType.heat]!;
    newResources[ResourceType.heat] = heatResource.copyWith(
      amount: heatResource.amount + heatResource.production + energyAmount,
    );

    // Reset energy to production only (doesn't carry over)
    newResources[ResourceType.energy] = Resource(
      type: ResourceType.energy,
      amount: energyProduction,
      production: energyProduction,
    );

    // Process each resource for production
    for (final type in ResourceType.values) {
      if (type == ResourceType.energy || type == ResourceType.heat) {
        continue; // Already handled above
      }

      final resource = newResources[type]!;
      final production = resource.production;
      var newAmount = resource.amount;

      switch (type) {
        case ResourceType.megacredits:
          // MC = production + TR
          newAmount += production + tr;
          break;
        default:
          // Steel, Titanium, Plants = production rate
          newAmount += production;
      }

      newResources[type] = resource.copyWith(amount: newAmount);
    }

    return GameState(
      resources: newResources,
      generation: state.generation + 1,
      terraformRating: state.terraformRating,
    );
  }

  @override
  GameState undo(GameState state) {
    // Restore previous state
    return GameState(
      resources: _previousResources,
      generation: _previousGeneration,
      terraformRating: _previousTR,
    );
  }

  @override
  ActionLogEntry createLogEntry(String id) {
    return ActionLogEntry.generationChange(
      id: id,
      previousGen: _previousGeneration,
      newGen: _previousGeneration + 1,
    );
  }
}
