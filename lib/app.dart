import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/game_board_screen.dart';

class TerraformingMarsApp extends StatelessWidget {
  const TerraformingMarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Terraforming Mars Player Board',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const GameBoardScreen(),
      ),
    );
  }
}
