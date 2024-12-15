import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:state_notifier/state_notifier.dart';

import '../models/calculator_models.dart';

class CalculatorEngine extends StateNotifier<CalculatorState> {
  CalculatorEngine()
      : super(
          const CalculatorState(
            buffer: '0',
            calcHistory: [],
            mode: CalculatorEngineMode.result,
            error: '',
          ),
        );

  void addToBuffer(String str, {bool continueWithResult = false}) {
    if (state.mode == CalculatorEngineMode.result) {
      state = state.copyWith(
        buffer: (continueWithResult ? state.buffer : '') + str,
        mode: CalculatorEngineMode.input,
        error: '',
      );
    } else {
      state = state.copyWith(
        buffer: state.buffer + str,
        error: '',
      );
    }
  }

  void backspace() {
    final charList = Characters(state.buffer).toList();
    if (charList.isNotEmpty) {
      charList.length = charList.length - 1;
    }
    state = state.copyWith(buffer: charList.join());
  }

  void clear() {
    state = state.copyWith(buffer: '');
  }

  void evaluate() {
    try {
      final parser = Parser();
      final cm = ContextModel();
      final exp = parser.parse(state.buffer);
      final result = exp.evaluate(EvaluationType.REAL, cm) as double;

      switch (result) {
        case double(isInfinite: true):
          state = state.copyWith(
            error: 'Result is Infinite',
            buffer: '',
            mode: CalculatorEngineMode.result,
          );
        case double(isNaN: true):
          state = state.copyWith(
            error: 'Result is Not a Number',
            buffer: '',
            mode: CalculatorEngineMode.result,
          );
        default:
          final resultStr = result.ceil() == result
              ? result.toInt().toString()
              : result.toString();
          state = state.copyWith(
              buffer: resultStr,
              mode: CalculatorEngineMode.result,
              calcHistory: [
                '${state.buffer} = $resultStr',
                ...state.calcHistory,
              ]);
      }
    } catch (err) {
      state = state.copyWith(
        error: err.toString(),
        buffer: '',
        mode: CalculatorEngineMode.result,
      );
    }
  }
}
