import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmplayerboard/resource_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TM Player Board',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Enter Sansman',
      ),
      home: const ScorePage(title: 'TM Player Board'),
    );
  }
}

class ScorePage extends StatefulWidget {
  const ScorePage({super.key, required this.title});

  final String title;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: ScoreContentWidget(),
      ),
    );
  }
}

class ScoreContentWidget extends StatelessWidget {
  const ScoreContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ResourceWidget(label: 'MegaCredits', color: Colors.yellow),
              ResourceWidget(label: 'MegaCredits', color: Colors.brown),
              ResourceWidget(label: 'MegaCredits', color: Colors.grey),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ResourceWidget(label: 'MegaCredits', color: Colors.green),
              ResourceWidget(label: 'MegaCredits', color: Colors.purple),
              ResourceWidget(label: 'MegaCredits', color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}
