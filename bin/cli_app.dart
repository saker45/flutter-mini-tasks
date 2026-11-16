// Mini Task 1: CLI-based Todo + Calculator app.
// Run from the project root with:  dart run bin/cli_app.dart
import 'dart:io';

void main() {
  while (true) {
    print('\n=== Mini CLI App ===');
    print('1. Todo list');
    print('2. Calculator');
    print('0. Exit');
    final choice = _ask('Choose an option: ');
    switch (choice) {
      case '1':
        _todoMenu();
        break;
      case '2':
        _calculatorMenu();
        break;
      case '0':
        print('Goodbye!');
        return;
      default:
        print('Invalid option, try again.');
    }
  }
}

String _ask(String prompt) {
  stdout.write(prompt);
  return (stdin.readLineSync() ?? '').trim();
}

// ---------------------------------------------------------------- Todo
class Todo {
  Todo(this.title);
  final String title;
  bool done = false;
}

void _todoMenu() {
  final todos = <Todo>[];

  void show() {
    if (todos.isEmpty) {
      print('  (no todos yet)');
      return;
    }
    for (var i = 0; i < todos.length; i++) {
      final t = todos[i];
      print('  ${i + 1}. [${t.done ? 'x' : ' '}] ${t.title}');
    }
  }

  int? readIndex() {
    final n = int.tryParse(_ask('Todo number: '));
    if (n == null || n < 1 || n > todos.length) {
      print('Invalid todo number.');
      return null;
    }
    return n - 1;
  }

  while (true) {
    print('\n--- Todo List ---');
    show();
    print('a) Add   d) Mark done   r) Remove   b) Back');
    switch (_ask('Choose: ').toLowerCase()) {
      case 'a':
        final title = _ask('Title: ');
        if (title.isEmpty) {
          print('Title cannot be empty.');
        } else {
          todos.add(Todo(title));
          print('Added.');
        }
        break;
      case 'd':
        final i = readIndex();
        if (i != null) {
          todos[i].done = true;
          print('Marked as done.');
        }
        break;
      case 'r':
        final i = readIndex();
        if (i != null) {
          final removed = todos.removeAt(i);
          print('Removed "${removed.title}".');
        }
        break;
      case 'b':
        return;
      default:
        print('Invalid option.');
    }
  }
}

// ---------------------------------------------------------- Calculator
void _calculatorMenu() {
  print('\n--- Calculator --- (type "b" at any prompt to go back)');
  while (true) {
    final aText = _ask('First number: ');
    if (aText.toLowerCase() == 'b') return;
    final op = _ask('Operator (+ - * /): ');
    if (op.toLowerCase() == 'b') return;
    final bText = _ask('Second number: ');
    if (bText.toLowerCase() == 'b') return;

    final a = double.tryParse(aText);
    final b = double.tryParse(bText);
    if (a == null || b == null) {
      print('Please enter valid numbers.');
      continue;
    }

    double? result;
    switch (op) {
      case '+':
        result = a + b;
        break;
      case '-':
        result = a - b;
        break;
      case '*':
        result = a * b;
        break;
      case '/':
        if (b == 0) {
          print('Cannot divide by zero.');
        } else {
          result = a / b;
        }
        break;
      default:
        print('Unknown operator "$op".');
    }
    if (result != null) {
      print('Result: $a $op $b = $result');
    }
  }
}
