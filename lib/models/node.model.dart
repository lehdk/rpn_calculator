abstract class Node {
  String display();
}

class NumericNode extends Node {
  int value;

  NumericNode(this.value);
  
  @override
  String display() {
    return value.toString();
  }
}

class AddNode extends Node {
  @override
  String display() {
    return "+";
  }
}

class SubNode extends Node {
  @override
  String display() {
    return "-";
  }
}

class MultNode extends Node {
  @override
  String display() {
    return "*";
  }
}

class DivNode extends Node {
  @override
  String display() {
    return "/";
  }
}

class ModNode extends Node {
  @override
  String display() {
    return "%";
  }
}