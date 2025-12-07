import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/auth/data/models/user_model.dart';
import 'package:intern_1/features/auth/domain/entities/User_Entity.dart';
import 'package:intern_1/features/auth/view/Providers/Signup_Providers.dart';
import 'package:intern_1/home.dart';
import 'package:intern_1/features/auth/view/Screens/login.dart';
import 'package:intern_1/main.dart';
import 'package:intern_1/utils/loading_layer.dart';

class SignUp extends ConsumerWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(signupNameControllerProvider);
    final emailController = ref.watch(signupEmailControllerProvider);
    final phoneController = ref.watch(signupPhoneControllerProvider);
    final gradeController = ref.watch(signupGradeControllerProvider);
    final passwordController = ref.watch(signupPasswordControllerProvider);
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
                "Sign Up",
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(fontWeightDelta: 2),
              ),
              MyTextField(
                controller: nameController,
                formkey: formkey,
                label: "Name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    log("value == null || value.trim().isEmpty (name)");
                    return "Name is required";
                  }
                  if (value.trim().length < 3) {
                    log("value.trim().length < 3 (name)");
                    return "Name is too short";
                  }
                  return null;
                },
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
                controller: phoneController,
                formkey: formkey,
                label: "Phone Number",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Phone number is required";
                  }

                  value = value.trim();

                  // Remove leading +
                  String cleaned = value.startsWith("+")
                      ? value.substring(1)
                      : value;

                  if (!RegExp(r'^\d+$').hasMatch(cleaned)) {
                    return "Phone must contain digits only";
                  }

                  if (cleaned.length < 8 || cleaned.length > 15) {
                    return "Invalid phone number length";
                  }

                  if (cleaned.startsWith("00")) {
                    return "Phone should not start with '00'";
                  }

                  return null;
                },
              ),
              MyDropdownField(
                label: "Grade",
                value: gradeController.text,
                items: const ["G13", "G14"],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    log("value == null || value.isEmpty (grade)");
                    return "Please select a grade";
                  }
                  return null;
                },
                onChanged: (value) {
                  gradeController.text = value ?? "";
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
              SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () async {
                  try {
                    log("pressed");
                    log((formkey.currentState!.validate()).toString());
                    if (formkey.currentState!.validate()) {
                      UserEntity user = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        grade: gradeController.text,
                        password: passwordController.text,
                      );
                      log(user.toString());
                      final signupRequest = ref.read(signupUseCaseProvider);
                      ref.read(loadingProvider.notifier).state = true;
                      log(ref.read(loadingProvider.notifier).state.toString());
                      await signupRequest(user: user);
                      ref.read(loadingProvider.notifier).state = false;
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Home(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                const begin = Offset(
                                  -1.0,
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
                    }
                  } on DioException catch (e) {
                    log(e.toString());
                    ref.read(loadingProvider.notifier).state = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text(e.response!.data["message"]),
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundBuilder: (context, states, child) {
                    return MyBackground(child: child ?? Container());
                  },
                ),
                child: Text(
                  "Sign Up",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.apply(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text("Or If you have an account"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MyLogin(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                const begin = Offset(
                                  -1.0,
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
                      "Log In",
                      style: Theme.of(context).textTheme.titleSmall!.apply(
                        color: Colors.indigo,
                        decoration: .underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
