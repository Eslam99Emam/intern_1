import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/assessments/view/Providers/controllers_providers.dart';
import 'package:intern_1/features/assessments/view/Providers/get_assessment_providers.dart';
import 'package:intern_1/features/assessments/view/Screens/assessment_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MyQRCodeReader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
      height: 300,
      width: 300,
      child: MobileScanner(
        controller: ref.watch(scanner_controller_provider),
        useAppLifecycleState: false,
        onDetect: (result) async {
          log(result.barcodes.first.rawValue.toString());
          final id = int.tryParse(result.barcodes.first.rawValue.toString());

          if (id == null) return;
          var res = await ref.read(getAssessment(id).future);
          log("res.toString()");
          log(res.toString());
          ref.read(scanner_controller_provider).dispose();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AssessmentPage(assessment: res),
            ),
          );
        },
      ),
    );
  }
}
