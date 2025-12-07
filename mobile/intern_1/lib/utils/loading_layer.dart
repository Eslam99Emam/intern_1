import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

class LoadingLayer extends ConsumerWidget {
  const LoadingLayer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        ref.watch(loadingProvider)
            ? Container(
                color: Colors.black26,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Container(),
      ],
    );
  }
}
