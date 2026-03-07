import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'infrastructure/storage/storage_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  final storage = StorageService();
  await storage.initialize();

  // Set preferred orientations - Landscape only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const TerraformingMarsApp());
}
