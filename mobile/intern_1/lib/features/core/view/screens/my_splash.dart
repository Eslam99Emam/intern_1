import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/auth/view/Screens/login.dart';
import 'package:intern_1/features/core/view/providers/verify_token_providers.dart';
import 'package:intern_1/features/auth/view/Screens/home.dart';

class MySplash extends ConsumerWidget {
  const MySplash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var token = ref.watch(verifyTokenNotifierProvider);
    return Scaffold(
      body: Center(
        child: token.when(
          data: (data) {
            if (data) return Home();
            return MyLogin();
          },
          error: (error, stackTrace) {
            log(error.toString());
            log(stackTrace.toString());
            return MyLogin();
          },
          loading: () => Column(
            mainAxisSize: .min,
            children: [
              Image.asset('assets/logo.png'),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
