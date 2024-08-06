import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcUi extends StatefulWidget {
  const CalcUi({super.key});

  @override
  State<CalcUi> createState() => _CalcUiState();
}

class _CalcUiState extends State<CalcUi> {
  String input = '0';
  String output = '';
  var iSize = 50.0;
  var oSize = 34.0;
  Color iColor = Colors.black;
  Color oColor = Colors.black45;
  bool sciFi = false;
  var pSize = 24.0;
  double textSize = 24;
  String sciText = 'Sci';

  Widget equalButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 17.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange.shade900,
          ),
          child: TextButton(
            onPressed: () {
              iSize = 32;
              oSize = 50;
              iColor = Colors.black45;
              oColor = Colors.black;
              calculate();
            },
            child: const Text('=',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 29)),
          ),
        ),
      ),
    );
  }

  void calculate() {
    try {
      var userInput = input;
      userInput = userInput.replaceAll('x', '*');
      userInput = userInput.replaceAll('÷', '/');
      var parser = Parser();
      var exp = parser.parse(userInput);
      var context = ContextModel();
      var eResult =
      exp.evaluate(EvaluationType.REAL, context);
      if(eResult.toString().endsWith(".0")) {
        eResult = eResult.toString().substring(0,eResult.toString().length-2);
      } else{
        eResult = eResult.toStringAsFixed(2);
      }
      if (eResult.length >= 11) oSize = 40;
      setState(() {
        output = '=$eResult';
      });
    } catch (e) {
      setState(() {
        output = 'Error';
      });
    }
  }

  void onNumberPress(String text) {
    if (text == 'AC') {
      iSize = 54;
      oSize = 34;
      input = '0';
      output = '';
      iColor = Colors.black;
      oColor = Colors.black45;
    } else if (text == '⌫') {
      if (input.isNotEmpty && input != '0') {
        input = input.substring(0, input.length - 1);
        if (input.isEmpty) {
          input = '0';
        }
      }
    } else if (text == sciText) {
      setState(() {
        pSize = 15;
        sciFi = !sciFi;
        if (sciFi == false) pSize = 24; // Toggle scientific mode
      });
    } else {
      if (text == '.') {
        if (input[input.length - 1]=='.') {
          return;
        }
      } else if (isOperator(text)) {
        if (isOperator(input[input.length - 1])) {
          return;
        }if(input[input.length - 1]=='.') return;
      }
      if (input == '0') {
        input = text;
      } else {
        input += text;
      }
      if (input.length >= 11) iSize = 45;
      if (input.length >= 14) iSize = 40;
    }
    setState(() {});
  }

  bool isOperator(String text) {
    return text == '+' || text == '-' || text == 'x' || text == '÷' || text == '%';
  }

  Widget button({required String numText, Color textColor = Colors.black, Color backColor = Colors.white, double textSize = 22,}) {
    return Expanded(
      child: TextButton(
        onPressed: () => onNumberPress(numText),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: backColor,
          padding: EdgeInsets.all(pSize),
          textStyle: const TextStyle(
            fontSize: 8.0,
          ),
        ),
        child: Text(numText, style: TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: textSize),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(shadowColor: Colors.white,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20, right: 15),
                child: Padding( padding: const EdgeInsets.only(right: 20),
                  child: Text(input, style: TextStyle(fontSize: iSize, color: iColor,), textAlign: TextAlign.end,),),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: Padding( padding: const EdgeInsets.only(right: 20),
                child: Text(output, style: TextStyle(fontSize: oSize, color: oColor,), textAlign: TextAlign.end,),),
            ),
            const Divider(thickness: 1,),
            if (sciFi) ...[
              Row(
                children: [
                  button(numText: '2nd', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: "deg", textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: 'sin', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: 'cos', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: 'tan', textColor: Colors.black.withOpacity(0.7), textSize: 20),],),
              Row(
                children: [
                  button(numText: 'xʸ', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: "log", textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: 'ln', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: '(', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                  button(numText: ')', textColor: Colors.black.withOpacity(0.7), textSize: 20),],),],
            Row(
              children: [
                if (sciFi) button(numText: '√', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                button(numText: 'AC', textColor: Colors.orange.shade900,),
                button(numText: "⌫", textColor: Colors.orange.shade900,),
                button(numText: '%', textColor: Colors.orange.shade900, textSize: 26,),
                button(numText: '÷', textColor: Colors.orange.shade900, textSize: 32,),],),
            Row(
              children: [
                if (sciFi) button(numText: 'x!', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                button(numText: '7',),
                button(numText: "8"),
                button(numText: '9'),
                button(numText: 'x', textColor: Colors.orange.shade900.withOpacity(0.9), textSize: 30,),],),
            Row(
              children: [
                if (sciFi) button(numText: '1/x', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                button(numText: '4',),
                button(numText: "5", ),
                button(numText: '6',),
                button(numText: '-', textColor: Colors.orange.shade900,),],),
            Row(
              children: [
                if (sciFi) button(numText: 'π', textColor: Colors.black.withOpacity(0.7), textSize: 20),
                button(numText: '1',),
                button(numText: "2", ),
                button(numText: '3',),
                button(numText: '+', textColor: Colors.orange.shade900,),],),
            Row(
              children: [
                button(numText: 'Sci', textColor: Colors.orange.shade900),
                if (sciFi) button(numText: 'e', textColor: Colors.black.withOpacity(0.9), textSize: 20),
                button(numText: "0"),
                button(numText: '.'),
                equalButton(),],)],
        ),
      ),
    );
  }
}
