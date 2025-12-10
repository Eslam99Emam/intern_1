import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/assessments/view/Providers/assessment_providers.dart';
import 'package:intern_1/features/assessments/view/Providers/check_assessment_providers.dart';
import 'package:intern_1/features/assessments/view/Providers/get_assessment_providers.dart';
import 'package:intern_1/features/attempts/view/screens/attempt_page.dart';
import 'package:intern_1/utils/loading_layer.dart';

class AssessmentPage extends ConsumerWidget {
  final AssessmentEntity assessment;

  const AssessmentPage({super.key, required this.assessment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = assessment;
    final duration = ref.watch(durationNotifierProvider(a.duration!.inSeconds));
    if (duration.inSeconds == 0) {
      log("assessment.toString()");
      for (var q in ref.read(getAssessment(assessment.id!)).value!.questions!) {
        q.options!.forEach((o) {
          log(q.id.toString());
          log(q.question.toString());
          log(o.id.toString());
          log(o.option.toString());
          log(o.isChosen.toString());
        });
      }
      final data = ref.read(
        checkAssessment(ref.read(getAssessment(assessment.id!)).value!),
      );
      data.when(
        data: (data) {
          ref.read(loadingProvider.notifier).state = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AttemptPage(attempt: data)),
          );
        },
        error: (error, stackTrace) {
          ref.read(loadingProvider.notifier).state = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        },
        loading: () {
          ref.read(loadingProvider.notifier).state = true;
        },
      );
    }
    return Scaffold(
      body: LoadingLayer(
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      a.title!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Subject: ${a.subject}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Grade: ${a.grade}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: a.questions?.length ?? 0,
                        itemBuilder: (context, index) {
                          final q = a.questions![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  "Q${index + 1}: ${q.question}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  children: q.options!.map((option) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RadioMenuButton<int?>(
                                        style: ButtonStyle(
                                          visualDensity:
                                              .adaptivePlatformDensity,
                                          splashFactory: NoSplash.splashFactory,
                                        ),
                                        value: option.id!,
                                        groupValue: ref
                                            .watch(
                                              getAssessment(assessment.id!),
                                            )
                                            .value
                                            ?.questions
                                            ?.firstWhere((qu) => qu.id == q.id)
                                            .options!
                                            .where((o) => o.isChosen)
                                            .firstOrNull
                                            ?.id,
                                        onChanged: (val) {
                                          ref
                                              .read(
                                                getAssessment(
                                                  assessment.id!,
                                                ).notifier,
                                              )
                                              .setAnswer(q.id!, val!);
                                        },
                                        child: Text(option.option ?? ""),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        ref.read(loadingProvider.notifier).state = true;
                        log(
                          "ref.read(getAssessment(assessment.id!)).toString()",
                        );
                        log(ref.read(getAssessment(assessment.id!)).toString());
                        ref
                            .read(
                              durationNotifierProvider(
                                a.duration!.inSeconds,
                              ).notifier,
                            )
                            .stopDuration();
                        AssessmentEntity final_assessment = ref
                            .read(getAssessment(assessment.id!))
                            .value!;

                        final data = await ref.read(
                          checkAssessmentUseCaseProvider,
                        )(assessment: final_assessment);

                        ref.read(loadingProvider.notifier).state = false;
                        log("done checking assessment");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AttemptPage(attempt: data, home: true),
                          ),
                        );

                        // data.when(
                        //   data: (data) {
                        //     log("data");
                        //     ref.read(loadingProvider.notifier).state = false;
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) =>
                        //             AttemptPage(attempt: data),
                        //       ),
                        //     );
                        //   },
                        //   error: (error, stackTrace) {
                        //     log("error");
                        //     ref.read(loadingProvider.notifier).state = false;
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(error.toString()),
                        //         backgroundColor: Colors.red,
                        //         duration: const Duration(seconds: 3),
                        //       ),
                        //     );
                        //   },
                        //   loading: () {
                        //     log("Loading");
                        //     ref.read(loadingProvider.notifier).state = true;
                        //   },
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(double.maxFinite, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            !ref.watch(startAssessmentProvider)
                ? Positioned(
                    child: Container(
                      width: .maxFinite,
                      height: .maxFinite,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Assessment",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: .w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Subject: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: .w600,
                                ),
                              ),
                              Text(
                                "${a.subject}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: .w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Duration: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: .w600,
                                ),
                              ),
                              Text(
                                "${(a.duration!.inMinutes).toString().padLeft(2, '0')}:${(a.duration!.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: .w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  fixedSize: const Size(100, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "Start",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: .w600,
                                  ),
                                ),
                                onPressed: () {
                                  log("start assessment");
                                  ref
                                          .read(
                                            startAssessmentProvider.notifier,
                                          )
                                          .state =
                                      true;
                                  ref
                                      .read(
                                        durationNotifierProvider(
                                          a.duration!.inSeconds,
                                        ).notifier,
                                      )
                                      .startDuration();
                                  log("assessment started");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
