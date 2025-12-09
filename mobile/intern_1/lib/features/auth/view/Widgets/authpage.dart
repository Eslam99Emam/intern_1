import 'package:flutter/material.dart';
import 'package:intern_1/utils/loading_layer.dart';
import 'package:intern_1/utils/my_background.dart';

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
