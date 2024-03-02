import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calculator/models/node.model.dart';
import 'package:rpn_calculator/widgets/helpers/calculator.dart';

void main() {

  test("Can calculate 01", () {
    // Arrange
    var queue = Queue<Node>();
  
    queue.add(NumericNode(2));
    queue.add(NumericNode(2));
    queue.add(AddNode());

    // Act
    var result = calculateRPN(queue);

    // Assert
    expect(result, 4);
  });

  test("Can calculate 02", () {
    // Arrange
    var queue = Queue<Node>();
  
    queue.add(NumericNode(3));
    queue.add(NumericNode(4));
    queue.add(SubNode());
    queue.add(NumericNode(5));
    queue.add(AddNode());

    // Act
    var result = calculateRPN(queue);

    // Assert
    expect(result, 4);
  });

  test("Can calculate 03", () {
    // Arrange
    var queue = Queue<Node>();
  
    queue.add(NumericNode(3));
    queue.add(NumericNode(4));
    queue.add(MultNode());
    queue.add(NumericNode(5));
    queue.add(NumericNode(6));
    queue.add(MultNode());
    queue.add(AddNode());

    // Act
    var result = calculateRPN(queue);

    // Assert
    expect(result, 42);
  });

  test("Original queue is not modified", () {
    // Arrange
    var queue = Queue<Node>();

    queue.add(NumericNode(2));
    queue.add(NumericNode(2));
    queue.add(AddNode());

    int originalLength = queue.length;
    
    // Act
    calculateRPN(queue);

    // Assert
    expect(queue.length, originalLength);
  });
}