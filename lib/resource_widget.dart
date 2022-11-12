import 'package:flutter/material.dart';

class ResourceWidget extends StatefulWidget {
  final String label;
  final Color color;
  const ResourceWidget({super.key, required this.label, required this.color});

  @override
  State<ResourceWidget> createState() => _ResourceWidgetState();
}

class _ResourceWidgetState extends State<ResourceWidget> {
  void _openAdjustmentDialog() {
    showDialog(
        context: context,
        builder: ((context) => EditResourceDialog(color: widget.color)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: InkWell(
        onTap: _openAdjustmentDialog,
        child: CurrencyStatusWidget(
            color: widget.color, amount: 9999, productionRate: 999),
      ),
    );
  }
}

class EditResourceDialog extends StatelessWidget {
  final Color color;

  const EditResourceDialog({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade200,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        AdjustCurrencyButton(-10),
                        AdjustCurrencyButton(-5),
                        AdjustCurrencyButton(-1),
                      ],
                    ),
                    Row(
                      children: [
                        AdjustCurrencyButton(-10),
                        AdjustCurrencyButton(-5),
                        AdjustCurrencyButton(-1),
                      ],
                    ),
                  ],
                ),
                CurrencyStatusWidget(
                    color: color, amount: 9999, productionRate: 999),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        AdjustCurrencyButton(1),
                        AdjustCurrencyButton(5),
                        AdjustCurrencyButton(10),
                      ],
                    ),
                    Row(
                      children: [
                        AdjustCurrencyButton(1),
                        AdjustCurrencyButton(5),
                        AdjustCurrencyButton(10),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text('Apply', style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}

class AdjustCurrencyButton extends StatelessWidget {
  final int value;

  const AdjustCurrencyButton(
    this.value, {
    super.key,
  });
  String get _label => value < 0 ? value.toString() : '+$value';

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        _label,
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () {},
    );
  }
}

class CurrencyStatusWidget extends StatelessWidget {
  final int amount;
  final int productionRate;
  final Color color;
  const CurrencyStatusWidget(
      {super.key,
      required this.amount,
      required this.productionRate,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 130.0,
      alignment: Alignment.center,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(amount.toString(),
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20.0),
          Container(
            color: const Color(0x33000000),
            child: Text(productionRate.toString(),
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      ),
    );
  }
}
