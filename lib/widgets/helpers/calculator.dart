import 'dart:collection';

import '../../models/node.model.dart';

int calculateRPN(Queue<Node> input) {
  int solve(Queue<Node> q) {
    if(q.isEmpty) {
      throw Exception("Invalud expression stack");
    }

    Node top = q.removeLast();

    // Base case
    if(top is NumericNode) {
      return top.value;
    }

    int y = solve(q);
    int x = solve(q);

    switch(top) {
      case AddNode _:
        return x + y;
      case SubNode _:
        return x - y;
      case MultNode _:
        return x * y;
      case DivNode _:
        return x ~/ y;
      case ModNode _:
        return x % y;
      default:
        throw Exception("Invalud operator: $top");
    }
  }

  return solve(Queue<Node>.from(input));
}