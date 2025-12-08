import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

final login_EmailProvider = Provider((ref) => TextEditingController());

final login_PasswordProvider = Provider((ref) => TextEditingController());

final bottomsheet_scrollController =
    Provider((ref) => DraggableScrollableController());

final loginFormKey = Provider((ref) => GlobalKey<FormState>());

final signupFormKey = Provider((ref) => GlobalKey<FormState>());