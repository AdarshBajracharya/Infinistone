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

  void _updateRotation(double deltaX, double deltaY) {
    setState(() {
      _rotationX = (_rotationX + deltaY * 0.01).clamp(-pi / 4, pi / 4);
      _rotationY = (_rotationY + deltaX * 0.01).clamp(-pi / 4, pi / 4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3D Room')),
      body: GestureDetector(
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
        child: Center(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015) // Perspective
              ..rotateX(_rotationX)
              ..rotateY(_rotationY),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildWall(Colors.brown[300]!, 200, 200, 0, 100, 0), // Floor
                _buildWall(Colors.brown[400]!, 200, 200, 0, -100, 0), // Ceiling
                _buildWall(Colors.blue[300]!, 200, 200, -100, 0, 0,
                    rotateY: pi / 2), // Left Wall
                _buildWall(Colors.blue[500]!, 200, 200, 100, 0, 0,
                    rotateY: pi / 2), // Right Wall
                _buildWall(
                    Colors.green[300]!, 200, 200, 0, 0, -100), // Back Wall
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWall(
      Color color, double width, double height, double x, double y, double z,
      {double rotateY = 0, double rotateX = 0}) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(x, y, z)
        ..rotateY(rotateY)
        ..rotateX(rotateX),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 1),
        ),
      ),
    );
  }
}
