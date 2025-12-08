import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/view/screens/my_splash.dart';
import 'package:intern_1/features/auth/view/Screens/home.dart';
import 'package:intern_1/features/auth/view/Screens/login.dart';
import 'package:intern_1/utils/loading_layer.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.white)),
      home: MySplash(),
    );
  }
}

class MyQRCodeReader extends StatefulWidget {
  const MyQRCodeReader({super.key});

  @override
  State<MyQRCodeReader> createState() => _MyQRCodeReaderState();
}

class _MyQRCodeReaderState extends State<MyQRCodeReader>
    with AutomaticKeepAliveClientMixin {
  MobileScannerController scanner_controller = MobileScannerController(
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
      height: 300,
      width: 300,
      child: MobileScanner(
        controller: scanner_controller,
        onDetect: (result) {
          log(result.barcodes.first.rawValue.toString());
        },
      ),
    );
  }
}

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

class AuthPage extends StatefulWidget {
  AuthPage({super.key, required this.child});
  Widget child;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingLayer(
        child: MyBackground(
          child: SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: widget.child,
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

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.controller,
    required this.formkey,
    required this.validator,
    required this.label,
  });
  String label;
  GlobalKey<FormState> formkey;
  TextEditingController controller;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}

class MyDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;

  const MyDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    log(value.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: DropdownButtonFormField<String>(
              initialValue: value,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              validator: validator,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
