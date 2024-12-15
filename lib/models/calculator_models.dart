
import 'package:flutter/material.dart';

import '../utils/calculator_engine.dart';

@immutable
class CalculatorState {
  const CalculatorState({
    required this.buffer,
    required this.calcHistory,
    required this.mode,
    required this.error,
  });

  final String buffer;
  final List<String> calcHistory;
  final CalculatorEngineMode mode;
  final String error;

  CalculatorState copyWith({
    String? buffer,
    List<String>? calcHistory,
    CalculatorEngineMode? mode,
    String? error,
  }) =>
      CalculatorState(
        buffer: buffer ?? this.buffer,
        calcHistory: calcHistory ?? this.calcHistory,
        mode: mode ?? this.mode,
        error: error ?? this.error,
      );
}

class ButtonDefinition {
  const ButtonDefinition({
    required this.areaName,
    required this.label,
    required this.op,
    this.type = CalcButtonType.outlined,
  });

  final String areaName;
  final String label;
  final CalculatorEngineCallback op;
  final CalcButtonType type;
}

typedef CalculatorEngineCallback = void Function(CalculatorEngine engine);

enum CalcButtonType { outlined, elevated }

enum CalculatorEngineMode { input, result }