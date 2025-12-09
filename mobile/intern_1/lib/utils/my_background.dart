import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class MyBackground extends StatelessWidget {
  final Widget child;

  const MyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MeshGradient(
      options: MeshGradientOptions(noiseIntensity: 0.5, blend: 5),
      points: [
        MeshGradientPoint(
          position: Offset(0.2, 0.2),
          color: Color.fromARGB(97, 0, 122, 126),
        ),
        MeshGradientPoint(
          position: Offset(0.5, 0.5),
          color: Color.fromARGB(100, 0, 103, 149),
        ),
        MeshGradientPoint(
          position: Offset(0.8, 0.8),
          color: Color.fromARGB(100, 0, 76, 94),
        ),
      ],
      child: child,
    );
  }
}
