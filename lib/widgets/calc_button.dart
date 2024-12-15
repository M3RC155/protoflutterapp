import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/calculator_models.dart';
import '../utils/calculator_engine.dart';

class CalcButton extends ConsumerWidget {
  const CalcButton({
    super.key,
    required this.op,
    required this.label,
    required this.type,
    required this.calculatorStateProvider,
  });

  final CalculatorEngineCallback op;
  final String label;
  final CalcButtonType type;

  final StateNotifierProvider<CalculatorEngine, CalculatorState> calculatorStateProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonConstructor = switch (type) {
      CalcButtonType.elevated => ElevatedButton.new,
      _ => OutlinedButton.new,
    };

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: buttonConstructor(
          autofocus: false,
          clipBehavior: Clip.none,
          onPressed: () => op(ref.read(calculatorStateProvider.notifier)),
          child: AutoSizeText(
            label,
            style: const TextStyle(fontSize: 40, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}