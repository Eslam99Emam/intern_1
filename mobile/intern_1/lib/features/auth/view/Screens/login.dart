import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/auth/view/Providers/Login_Providers.dart';
import 'package:intern_1/features/assessments/view/Screens/home.dart';
import 'package:intern_1/features/auth/view/Widgets/authpage.dart';
import 'package:intern_1/features/auth/view/Screens/signup.dart';
import 'package:intern_1/utils/loading_layer.dart';
import 'package:intern_1/utils/my_background.dart';
import 'package:intern_1/utils/my_fields.dart';

class MyLogin extends ConsumerWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(loginEmailControllerProvider);
    final passwordController = ref.watch(loginPasswordControllerProvider);
    return AuthPage(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(150),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Text(
                "Log in",
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(fontWeightDelta: 2),
              ),
              MyTextField(
                controller: emailController,
                formkey: formkey,
                label: "Email",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }

                  value = value.trim();

                  if (value.length > 254) {
                    return "Email is too long";
                  }

                  final pattern =
                      r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$";
                  final regex = RegExp(pattern);

                  if (!regex.hasMatch(value)) {
                    return "Invalid email format";
                  }

                  if (value.contains("..")) {
                    return "Email cannot contain consecutive dots";
                  }

                  final parts = value.split("@");
                  if (parts.length != 2) return "Invalid email format";

                  final localPart = parts[0];
                  final domainPart = parts[1];

                  if (localPart.length > 64) {
                    return "Local part is too long";
                  }
                  if (domainPart.length > 255) {
                    return "Domain part is too long";
                  }

                  return null;
                },
              ),
              MyTextField(
                controller: passwordController,
                formkey: formkey,
                label: "Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }

                  if (value.length < 10) {
                    return "Password must be at least 10 characters";
                  }

                  if (!RegExp(r"[A-Z]").hasMatch(value)) {
                    return "Must contain an uppercase letter";
                  }

                  if (!RegExp(r"[a-z]").hasMatch(value)) {
                    return "Must contain a lowercase letter";
                  }

                  if (!RegExp(r"\d").hasMatch(value)) {
                    return "Must contain a number";
                  }

                  if (!RegExp("[!@#\$%^&*(),.?\":{}|<>]").hasMatch(value)) {
                    return "Must contain a special character";
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: OutlinedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        final loginRequest = ref.read(loginUseCaseProvider);
                        ref.read(loadingProvider.notifier).state = true;
                        log(
                          ref.read(loadingProvider.notifier).state.toString(),
                        );
                        await loginRequest(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        ref.read(loadingProvider.notifier).state = false;
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Home(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  const begin = Offset(
                                    0.0,
                                    -1.0,
                                  ); // Slide in from the right
                                  const end = Offset.zero; // End at the center
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(
                                    begin: begin,
                                    end: end,
                                  ).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                          ),
                        );
                      } on DioException catch (e) {
                        log((e.error).toString());
                        ref.read(loadingProvider.notifier).state = false;
                        log((e.response?.data).toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              (e.response?.data["message"]).toString(),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundBuilder: (context, states, child) {
                      return MyBackground(child: child ?? Container());
                    },
                  ),
                  child: Text(
                    "Log in",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.apply(color: Colors.white),
                  ),
                ),
              ),
              Text("Don't have any account"),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SignUp(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(
                              1.0,
                              0.0,
                            ); // Slide in from the right
                            const end = Offset.zero; // End at the center
                            const curve = Curves.easeInOut;

                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.titleSmall!.apply(
                    color: Colors.indigo,
                    decoration: .underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
