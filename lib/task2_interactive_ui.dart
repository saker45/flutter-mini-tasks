import 'package:flutter/material.dart';

/// Task 2: three horizontal sections.
///  1. small red box (left)
///  2. yellow box (middle) showing a counter, +1 on every tap
///  3. box (right) that is green when the counter is even, blue when odd
class InteractiveBoxesScreen extends StatefulWidget {
  const InteractiveBoxesScreen({super.key});

  @override
  State<InteractiveBoxesScreen> createState() => _InteractiveBoxesScreenState();
}

class _InteractiveBoxesScreenState extends State<InteractiveBoxesScreen> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    final isEven = _counter % 2 == 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Task 2 - Interactive UI')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Box size adapts to the available width AND height,
            // so it works on phones, tablets and in landscape mode.
            final side = (constraints.maxWidth / 3.6)
                .clamp(0.0, constraints.maxHeight * 0.8);

            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Small red box
                  Container(
                    key: const Key('redBox'),
                    width: side * 0.55,
                    height: side * 0.55,
                    color: Colors.red,
                  ),
                  // 2. Yellow tappable counter box
                  GestureDetector(
                    onTap: _increment,
                    child: Container(
                      key: const Key('yellowBox'),
                      width: side,
                      height: side,
                      color: Colors.yellow,
                      alignment: Alignment.center,
                      child: Text(
                        '$_counter',
                        key: const Key('counterText'),
                        style: TextStyle(
                          fontSize: side * 0.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  // 3. Colour-changing box
                  Container(
                    key: const Key('colorBox'),
                    width: side,
                    height: side,
                    color: isEven ? Colors.green : Colors.blue,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
