import 'package:flutter/material.dart';

import 'calculator_logic.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final Calculator _calculator = Calculator();

  String _display = '0';
  double? _firstOperand;
  String? _pendingOperator;
  bool _shouldResetDisplay = false;

  void _onDigitPressed(String digit) {
    setState(() {
      if (_display == '0' || _shouldResetDisplay) {
        _display = digit;
        _shouldResetDisplay = false;
      } else {
        _display += digit;
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      _firstOperand = double.parse(_display);
      _pendingOperator = operator;
      _shouldResetDisplay = true;
    });
  }

  void _onEqualsPressed() {
    if (_firstOperand == null || _pendingOperator == null) return;
    setState(() {
      try {
        final secondOperand = double.parse(_display);
        final result =
            _calculator.calculate(_firstOperand!, secondOperand, _pendingOperator!);
        _display = _formatResult(result);
      } catch (e) {
        _display = 'Error';
      }
      _firstOperand = null;
      _pendingOperator = null;
      _shouldResetDisplay = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _firstOperand = null;
      _pendingOperator = null;
      _shouldResetDisplay = false;
    });
  }

  String _formatResult(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  Widget _buildButton(String label, {Color? color, VoidCallback? onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: onPressed ??
              () {
                if (RegExp(r'^[0-9]$').hasMatch(label)) {
                  _onDigitPressed(label);
                }
              },
          child: Text(label, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                key: const Key('display'),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('C', color: Colors.redAccent, onPressed: _onClearPressed),
                    _buildButton('÷', color: colorScheme.secondaryContainer,
                        onPressed: () => _onOperatorPressed('÷')),
                    _buildButton('×', color: colorScheme.secondaryContainer,
                        onPressed: () => _onOperatorPressed('×')),
                    _buildButton('-', color: colorScheme.secondaryContainer,
                        onPressed: () => _onOperatorPressed('-')),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('+', color: colorScheme.secondaryContainer,
                        onPressed: () => _onOperatorPressed('+')),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('=', color: colorScheme.primary,
                        onPressed: _onEqualsPressed),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('.', onPressed: _onDecimalPressed),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
