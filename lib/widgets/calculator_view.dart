import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rpn_calculator/widgets/helpers/button_data.dart';
import 'package:rpn_calculator/widgets/helpers/calculator.dart';

import '../models/node.model.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {

  String display = "0";

  var rpn = Queue<Node>();

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // number display
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    display,
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // input buttons
            Wrap(
              children: 
                InputButton.buttons.map((v) => 
                  SizedBox(
                    width: screenSize.width / 4,
                    height: screenSize.width / 4,
                    child: createButton(v)),
                ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget createButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Material(
        color: calculateButtonColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(75),
          borderSide: const BorderSide(
            color: Colors.lime
          ),
        ),
        child: InkWell(
          onTap: () => onButtonPressed(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onButtonPressed(String value) {
    
    // Check if button pressed is a number
    int? number = int.tryParse(value);

    // Handle number
    if(number != null) {
      Node? last = rpn.lastOrNull;
      if(last == null || last is! NumericNode) {
        rpn.add(NumericNode(0));
        last = rpn.last;
      }

      if(last is! NumericNode) {
        return;
      }

      last.value = int.parse(last.value.toString() + value);
    }

    // Handle other buttons
    switch (value) {
      case InputButton.clear:
        rpn.clear();
        break;
      case InputButton.push:
        var last = rpn.lastOrNull;
        if(last != null && last is NumericNode && last.value == 0) {
          break;
        }

        rpn.add(NumericNode(0));
        break;
      case InputButton.add:
        rpn.add(AddNode());
        break;
      case InputButton.sub:
        rpn.add(SubNode());
        break;
      case InputButton.mult:
        rpn.add(MultNode());
        break;
      case InputButton.div:
        rpn.add(DivNode());
        break;
      default:
    }

    String? result;

    try {
      result = calculateRPN(rpn).toString();
    // ignore: empty_catches
    } catch(e) {}

    setState(() {
      display = humanView(rpn) + ((result == null) ? "" : " = $result");
    });
  }

  Color calculateButtonColor(String value) {
    return [InputButton.div, InputButton.mult, InputButton.sub, InputButton.add].contains(value)
      ? Colors.greenAccent
      : Colors.blueGrey;
  }

  String humanView(Queue<Node> q) {
    if(q.isEmpty) return "0";
    return q.map((node) => node.display()).join(" ");
  }
}