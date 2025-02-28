import 'dart:math';

import 'package:flutter/material.dart';

class Simple3DRoom extends StatefulWidget {
  const Simple3DRoom({super.key});

  @override
  _Simple3DRoomState createState() => _Simple3DRoomState();
}

class _Simple3DRoomState extends State<Simple3DRoom> {
  double _rotationX = 0;
  double _rotationY = 0;
  double _startX = 0;
  double _startY = 0;

  // Clamp rotation values to stay within the slider's range
  void _updateRotation(double deltaX, double deltaY) {
    setState(() {
      _rotationX = (_rotationX + deltaY * 0.01).clamp(-1.5, 1.5);
      _rotationY = (_rotationY + deltaX * 0.01).clamp(-1.5, 1.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple 3D Room Effect')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onPanUpdate: (details) {
                  _updateRotation(
                    details.localPosition.dx - _startX,
                    details.localPosition.dy - _startY,
                  );
                  _startX = details.localPosition.dx;
                  _startY = details.localPosition.dy;
                },
                onPanStart: (details) {
                  _startX = details.localPosition.dx;
                  _startY = details.localPosition.dy;
                },
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Perspective
                    ..rotateX(_rotationX)
                    ..rotateY(_rotationY),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Floor
                      Transform(
                        transform: Matrix4.translationValues(0, 100, 0),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.brown[300],
                        ),
                      ),
                      // Ceiling
                      Transform(
                        transform: Matrix4.translationValues(0, -100, 0),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.brown[400],
                        ),
                      ),
                      // Left Wall
                      Transform(
                        transform: Matrix4.translationValues(-100, 0, 0)
                          ..rotateY(pi / 2),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.blue[300],
                        ),
                      ),
                      // Right Wall
                      Transform(
                        transform: Matrix4.translationValues(100, 0, 0)
                          ..rotateY(pi / 2),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.blue[500],
                        ),
                      ),
                      // Back Wall
                      Transform(
                        transform: Matrix4.translationValues(0, 0, -100),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.green[300],
                        ),
                      ),
                      // Front Wall (Optional, can be transparent or omitted)
                      Transform(
                        transform: Matrix4.translationValues(0, 0, 100),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.green[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildSlider('Rotation X', _rotationX, -1.5, 1.5, (value) {
            setState(() => _rotationX = value);
          }),
          _buildSlider('Rotation Y', _rotationY, -1.5, 1.5, (value) {
            setState(() => _rotationY = value);
          }),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}
