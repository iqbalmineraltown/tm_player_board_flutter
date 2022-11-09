import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmplayerboard/currency_widget.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
              CurrencyWidget(label: 'MegaCredits', color: Colors.yellow),
              CurrencyWidget(label: 'MegaCredits', color: Colors.brown),
              CurrencyWidget(label: 'MegaCredits', color: Colors.grey),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CurrencyWidget(label: 'MegaCredits', color: Colors.green),
              CurrencyWidget(label: 'MegaCredits', color: Colors.purple),
              CurrencyWidget(label: 'MegaCredits', color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}
