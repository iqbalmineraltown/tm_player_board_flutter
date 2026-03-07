import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/resource_type.dart';
import '../../application/providers/providers.dart';
import '../widgets/widgets.dart';

/// Main game board screen displaying all resources and controls
class GameBoardScreen extends ConsumerWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final actionLog = ref.watch(actionLogProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Control bar: GEN, TR, History, Undo, Redo, Reset
              _buildControlBar(context, ref, gameState.generation, gameState.terraformRating, actionLog.length),

              const SizedBox(height: 8),

              // Resource cards - 2 rows of 3 cards each
              Expanded(
                child: _buildResourceRows(context, ref, gameState),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlBar(
    BuildContext context,
    WidgetRef ref,
    int generation,
    int terraformRating,
    int actionLogCount,
  ) {
    return Row(
      children: [
        // Generation display with production phase
        GenerationDisplay(
          generation: generation,
          onProductionPhase: () {
            ref.read(gameStateProvider.notifier).productionPhase();
          },
        ),
        const SizedBox(width: 6),
        // TR display
        TRDisplay(
          terraformRating: terraformRating,
          onAdjust: (delta) {
            ref.read(gameStateProvider.notifier).adjustTR(delta);
          },
        ),
        const Spacer(),
        // History button
        HistoryButton(entryCount: actionLogCount),
        const SizedBox(width: 4),
        // Undo/Redo buttons
        UndoRedoButtons(
          canUndo: ref.read(gameStateProvider.notifier).canUndo,
          canRedo: ref.read(gameStateProvider.notifier).canRedo,
          onUndo: () => ref.read(gameStateProvider.notifier).undo(),
          onRedo: () => ref.read(gameStateProvider.notifier).redo(),
        ),
        const SizedBox(width: 4),
        // Reset button
        ResetButton(
          onReset: () => ref.read(gameStateProvider.notifier).resetGame(),
        ),
      ],
    );
  }

  Widget _buildResourceRows(
    BuildContext context,
    WidgetRef ref,
    gameState,
  ) {
    final resources = ResourceType.values;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate card height based on available space
        final cardHeight = (constraints.maxHeight - 8) / 2; // 2 rows with spacing
        final cardWidth = (constraints.maxWidth - 16) / 3; // 3 columns with spacing

        return Column(
          children: [
            // Row 1: MC, Steel, Titanium
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildResourceCard(context, ref, gameState, resources[0], cardHeight),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildResourceCard(context, ref, gameState, resources[1], cardHeight),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildResourceCard(context, ref, gameState, resources[2], cardHeight),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Row 2: Plants, Energy, Heat
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildResourceCard(context, ref, gameState, resources[3], cardHeight),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildResourceCard(context, ref, gameState, resources[4], cardHeight),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildResourceCard(context, ref, gameState, resources[5], cardHeight),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    WidgetRef ref,
    gameState,
    resourceType,
    double maxHeight,
  ) {
    final resource = gameState.getResource(resourceType);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: ResourceCard(
        resource: resource,
        onAdjustAmount: (delta) {
          ref.read(gameStateProvider.notifier).adjustResourceAmount(
                resourceType,
                delta,
              );
        },
        onAdjustProduction: (delta) {
          ref.read(gameStateProvider.notifier).adjustResourceProduction(
                resourceType,
                delta,
              );
        },
      ),
    );
  }
}
