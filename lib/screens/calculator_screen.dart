import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proto_app/widgets/calc_button.dart';

import '../models/calculator_models.dart';
import '../utils/calculator_engine.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({
    super.key,
    required this.calculatorStateProvider
  });

  final StateNotifierProvider<CalculatorEngine, CalculatorState> calculatorStateProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorStateProvider);

    final buttonDefinitions = <ButtonDefinition>[
      ButtonDefinition(
        areaName: 'clear',
        op: (engine) => engine.clear(),
        label: 'AC',
      ),
      ButtonDefinition(
        areaName: 'bkspc',
        op: (engine) => engine.backspace(),
        label: '⌫',
      ),
      ButtonDefinition(
        areaName: 'lparen',
        op: (engine) => engine.addToBuffer('('),
        label: '(',
      ),
      ButtonDefinition(
        areaName: 'rparen',
        op: (engine) => engine.addToBuffer(')'),
        label: ')',
      ),
      ButtonDefinition(
        areaName: 'sqrt',
        op: (engine) => engine.addToBuffer('sqrt('),
        label: '√',
      ),
      ButtonDefinition(
        areaName: 'pow',
        op: (engine) => engine.addToBuffer('^'),
        label: '^',
      ),
      ButtonDefinition(
        areaName: 'abs',
        op: (engine) => engine.addToBuffer('abs('),
        label: 'Abs',
      ),
      ButtonDefinition(
        areaName: 'sgn',
        op: (engine) => engine.addToBuffer('sgn('),
        label: 'Sgn',
      ),
      ButtonDefinition(
        areaName: 'ceil',
        op: (engine) => engine.addToBuffer('ceil('),
        label: 'Ceil',
      ),
      ButtonDefinition(
        areaName: 'floor',
        op: (engine) => engine.addToBuffer('floor('),
        label: 'Floor',
      ),
      ButtonDefinition(
        areaName: 'e',
        op: (engine) => engine.addToBuffer('e('),
        label: 'e',
      ),
      ButtonDefinition(
        areaName: 'ln',
        op: (engine) => engine.addToBuffer('ln('),
        label: 'ln',
      ),
      ButtonDefinition(
        areaName: 'sin',
        op: (engine) => engine.addToBuffer('sin('),
        label: 'Sin',
      ),
      ButtonDefinition(
        areaName: 'cos',
        op: (engine) => engine.addToBuffer('cos('),
        label: 'Cos',
      ),
      ButtonDefinition(
        areaName: 'tan',
        op: (engine) => engine.addToBuffer('tan('),
        label: 'Tan',
      ),
      ButtonDefinition(
        areaName: 'fact',
        op: (engine) => engine.addToBuffer('!'),
        label: '!',
      ),
      ButtonDefinition(
        areaName: 'arcsin',
        op: (engine) => engine.addToBuffer('arcsin('),
        label: 'Arc Sin',
      ),
      ButtonDefinition(
        areaName: 'arccos',
        op: (engine) => engine.addToBuffer('arccos('),
        label: 'Arc Cos',
      ),
      ButtonDefinition(
        areaName: 'arctan',
        op: (engine) => engine.addToBuffer('arctan('),
        label: 'Arc Tan',
      ),
      ButtonDefinition(
        areaName: 'mod',
        op: (engine) => engine.addToBuffer('%'),
        label: 'Mod',
      ),
      ButtonDefinition(
        areaName: 'seven',
        op: (engine) => engine.addToBuffer('7'),
        label: '7',
      ),
      ButtonDefinition(
        areaName: 'eight',
        op: (engine) => engine.addToBuffer('8'),
        label: '8',
      ),
      ButtonDefinition(
        areaName: 'nine',
        op: (engine) => engine.addToBuffer('9'),
        label: '9',
      ),
      ButtonDefinition(
        areaName: 'four',
        op: (engine) => engine.addToBuffer('4'),
        label: '4',
      ),
      ButtonDefinition(
        areaName: 'five',
        op: (engine) => engine.addToBuffer('5'),
        label: '5',
      ),
      ButtonDefinition(
        areaName: 'six',
        op: (engine) => engine.addToBuffer('6'),
        label: '6',
      ),
      ButtonDefinition(
        areaName: 'one',
        op: (engine) => engine.addToBuffer('1'),
        label: '1',
      ),
      ButtonDefinition(
        areaName: 'two',
        op: (engine) => engine.addToBuffer('2'),
        label: '2',
      ),
      ButtonDefinition(
        areaName: 'three',
        op: (engine) => engine.addToBuffer('3'),
        label: '3',
      ),
      ButtonDefinition(
        areaName: 'zero',
        op: (engine) => engine.addToBuffer('0'),
        label: '0',
      ),
      ButtonDefinition(
        areaName: 'point',
        op: (engine) => engine.addToBuffer('.'),
        label: '.',
      ),
      ButtonDefinition(
        areaName: 'equals',
        op: (engine) => engine.evaluate(),
        label: '=',
        type: CalcButtonType.elevated,
      ),
      ButtonDefinition(
        areaName: 'plus',
        op: (engine) => engine.addToBuffer('+', continueWithResult: true),
        label: '+',
      ),
      ButtonDefinition(
        areaName: 'minus',
        op: (engine) => engine.addToBuffer('-', continueWithResult: true),
        label: '-',
      ),
      ButtonDefinition(
        areaName: 'multiply',
        op: (engine) => engine.addToBuffer('*', continueWithResult: true),
        label: '*',
      ),
      ButtonDefinition(
        areaName: 'divide',
        op: (engine) => engine.addToBuffer('/', continueWithResult: true),
        label: '/',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Container(
        color: Colors.deepPurple,
        child: SafeArea(
          child: LayoutGrid(
            areas: '''
            display display display display  history
            clear   bkspc   lparen  rparen   history
            sqrt    pow     abs     sgn      history
            ceil    floor   e       ln       history
            sin     cos     tan     fact     history
            arcsin  arccos  arctan  mod      history
            seven   eight   nine    divide   history
            four    five    six     multiply history
            one     two     three   minus    history
            zero    point   equals  plus     history
            ''',
            columnSizes: [
              1.fr, 1.fr, 1.fr, 1.fr, 2.fr
            ],
            rowSizes: [
              2.fr, 1.fr, 1.fr, 1.fr, 1.fr, 
              1.fr, 2.fr, 2.fr, 2.fr, 2.fr
            ],
            children: [
              NamedAreaGridPlacement(
                areaName: 'display',
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                    child: state.error.isEmpty
                      ? AutoSizeText(
                          state.buffer,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 80,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                        )
                      : AutoSizeText(
                          state.error,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 80,
                            color: Colors.red,
                          ),
                          maxLines: 2,
                        ),
                  ),
                ),
              ),
              ...buttonDefinitions.map(
                (definition) => NamedAreaGridPlacement(
                  areaName: definition.areaName,
                  child: CalcButton(
                    label: definition.label,
                    op: definition.op,
                    type: definition.type,
                    calculatorStateProvider: calculatorStateProvider,
                  ),
                ),
              ),
              NamedAreaGridPlacement(
                areaName: 'history',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView(
                    children: [
                      const ListTile(
                        title: Text(
                          'History',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...state.calcHistory.map(
                        (result) => ListTile(
                          title: Text(result),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
