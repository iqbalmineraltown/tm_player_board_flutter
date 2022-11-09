import 'package:flutter/material.dart';

class CurrencyWidget extends StatefulWidget {
  final String label;
  final Color color;
  const CurrencyWidget({super.key, required this.label, required this.color});

  @override
  State<CurrencyWidget> createState() => _CurrencyWidgetState();
}

class _CurrencyWidgetState extends State<CurrencyWidget> {
  void _openAdjustmentDialog() {
    showDialog(
        context: context,
        builder: ((context) => EditCurrencyWidget(color: widget.color)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: InkWell(
        onTap: _openAdjustmentDialog,
        child: CurrencyStatusWidget(amount: 9999, productionRate: 999),
      ),
    );
  }
}

class EditCurrencyWidget extends StatelessWidget {
  final Color color;

  const EditCurrencyWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        alignment: Alignment.center,
        color: Colors.green,
        child: Row(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton()
                ],
              ),
              Row(
                children: [
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton()
                ],
              ),
            ],
          ),
          CurrencyStatusWidget(amount: 9999, productionRate: 999),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton()
                ],
              ),
              Row(
                children: [
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton(),
                  AdjustCurrencyButton()
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class AdjustCurrencyButton extends StatelessWidget {
  const AdjustCurrencyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(4.0),
        child: const Text('+1'),
      ),
      onPressed: () {},
    );
  }
}

class CurrencyStatusWidget extends StatelessWidget {
  final int amount;
  final int productionRate;
  const CurrencyStatusWidget(
      {super.key, required this.amount, required this.productionRate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(amount.toString()),
          const SizedBox(height: 20.0),
          Container(
            color: Color(0x33000000),
            child: Text(productionRate.toString()),
          ),
        ],
      ),
    );
  }
}
