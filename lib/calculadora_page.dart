import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'acerca_de_page.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  String userInput = '';
  String result = '';

  void buttonPressed(String text) {
    setState(() {
      if (text == 'AC') {
        userInput = '';
        result = '';
      } else if (text == '⌫') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (text == '=') {
        _calcularResultado();
      } else {
        userInput += text;
      }

      _inputController.text = userInput;

      if (text != '=' && text != 'AC' && text != '⌫') {
        _calcularEnTiempoReal();
      }
    });
  }

  void _calcularEnTiempoReal() {
    try {
      String finalInput = userInput
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('sin', 'sin')
          .replaceAll('cos', 'cos')
          .replaceAll('tan', 'tan');

      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      result = eval.toString();
      _resultController.text = result;
    } catch (e) {
      // ignorar errores mientras se escribe
    }
  }

  void _calcularResultado() {
    try {
      _calcularEnTiempoReal();
      userInput = result;
      result = '';
      _inputController.text = userInput;
      _resultController.text = result;
    } catch (e) {
      _resultController.text = 'Error';
    }
  }

  Widget _buildButton(String text, {Color? backgroundColor, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.pink[50],
            foregroundColor: textColor ?? Colors.pink[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], 
      appBar: AppBar(
        title: const Text('Calculadora Científica'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AcercaDePage()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  controller: _inputController,
                  readOnly: true,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(fontSize: 32, color: Colors.black87),
                ),
                TextField(
                  controller: _resultController,
                  readOnly: true,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1, color: Colors.pinkAccent),
          
          const SizedBox(height: 10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton('sin(', backgroundColor: Colors.pink[200], textColor: Colors.white),
                      _buildButton('cos(', backgroundColor: Colors.pink[200], textColor: Colors.white),
                      _buildButton('tan(', backgroundColor: Colors.pink[200], textColor: Colors.white),
                      _buildButton('^', backgroundColor: Colors.pink[200], textColor: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('ln(', backgroundColor: Colors.pink[200], textColor: Colors.white),
                      _buildButton('(', backgroundColor: Colors.pink[200], textColor: Colors.white),
                      _buildButton(')', backgroundColor: Colors.pink[200], textColor: Colors.white),
                      // Operadores en rosa fuerte
                      _buildButton('÷', backgroundColor: Colors.pinkAccent, textColor: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('×', backgroundColor: Colors.pinkAccent, textColor: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('-', backgroundColor: Colors.pinkAccent, textColor: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('+', backgroundColor: Colors.pinkAccent, textColor: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('AC', backgroundColor: Colors.red[300], textColor: Colors.white),
                      _buildButton('0'),
                      _buildButton('.'),
                      _buildButton('=', backgroundColor: Colors.pink[800], textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}