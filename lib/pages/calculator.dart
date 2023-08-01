import 'package:advanced_calculator_app/pages/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;
  onButtenClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
      //input = input.substring(0, input.length - 1);
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
        // output = output.substring(0, output.length - 2);
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hideInput ? "" : input,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        output,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              //butten area
              Row(
                children: [
                  butten(
                      text: 'AC',
                      buttenBgColor: operatorColor,
                      textColor: orangeColor),
                  butten(
                      text: '<',
                      buttenBgColor: operatorColor,
                      textColor: orangeColor),
                  butten(
                      text: '',
                      buttenBgColor: operatorColor,
                      textColor: orangeColor),
                  butten(
                      text: '/',
                      buttenBgColor: operatorColor,
                      textColor: orangeColor)
                ],
              ),
              Row(
                children: [
                  butten(text: '7'),
                  butten(text: '8'),
                  butten(text: '9'),
                  butten(
                      text: 'x',
                      buttenBgColor: operatorColor,
                      textColor: orangeColor),
                ],
              ),
              Row(
                children: [
                  butten(text: '4'),
                  butten(text: '5'),
                  butten(text: '6'),
                  butten(
                      text: '-',
                      buttenBgColor: operatorColor,
                      textColor: orangeColor)
                ],
              ),
              Row(
                children: [
                  butten(text: '1'),
                  butten(text: '2'),
                  butten(text: '3'),
                  butten(
                      text: '+',
                      buttenBgColor: operatorColor,
                      textColor: orangeColor)
                ],
              ),
              Row(
                children: [
                  butten(text: '%'),
                  butten(text: '0'),
                  butten(text: '.'),
                  butten(text: '=', buttenBgColor: orangeColor),
                ],
              ),
            ],
          ),
        ));
  }

  Widget butten({text, textColor, buttenBgColor = Colors.grey}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(22),
            backgroundColor: buttenBgColor,
          ),
          onPressed: () => onButtenClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
