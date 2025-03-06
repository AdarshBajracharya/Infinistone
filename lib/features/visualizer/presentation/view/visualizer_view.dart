import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: WallAndFloorVisualizer(),
    debugShowCheckedModeBanner: false,
  ));
}

class WallAndFloorVisualizer extends StatefulWidget {
  const WallAndFloorVisualizer({super.key});

  @override
  _WallAndFloorVisualizerState createState() => _WallAndFloorVisualizerState();
}

class _WallAndFloorVisualizerState extends State<WallAndFloorVisualizer> {
  File? _wallImage;
  File? _floorImage;
  double _scale = 1.0;
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  final Offset _position = Offset.zero;

  Future<void> _pickImage(bool isWall) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isWall) {
          _wallImage = File(pickedFile.path);
        } else {
          _floorImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("3D Room Visualizer")),
      body: Center(
        child: GestureDetector(
          onScaleUpdate: (details) {
            setState(() {
              _scale = details.scale.clamp(0.5, 2.0);
              _rotationX += details.focalPointDelta.dy * 0.01;
              _rotationY += details.focalPointDelta.dx * 0.01;
            });
          },
          child: Container(
            alignment: Alignment.center,
            width: 400,
            height: 400,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(_position.dx, _position.dy)
                ..scale(_scale)
                ..rotateX(_rotationX)
                ..rotateY(_rotationY),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Wall
                  GestureDetector(
                    onTap: () => _pickImage(true),
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        image: _wallImage != null
                            ? DecorationImage(
                                image: FileImage(_wallImage!),
                                fit: BoxFit.cover)
                            : null,
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black),
                      ),
                      child: _wallImage == null
                          ? const Center(
                              child: Text("Tap to select wall texture"))
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Floor
                  GestureDetector(
                    onTap: () => _pickImage(false),
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-1.1),
                      child: Container(
                        width: 300,
                        height: 180,
                        decoration: BoxDecoration(
                          image: _floorImage != null
                              ? DecorationImage(
                                  image: FileImage(_floorImage!),
                                  fit: BoxFit.cover)
                              : null,
                          color: Colors.brown[300],
                          border: Border.all(color: Colors.black),
                        ),
                        child: _floorImage == null
                            ? const Center(
                                child: Text("Tap to select floor texture"))
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
