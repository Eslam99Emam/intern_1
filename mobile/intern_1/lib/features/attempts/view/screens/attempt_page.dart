import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/assessments/view/Screens/home.dart';
import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';
import 'package:intl/intl.dart';

class AttemptPage extends ConsumerWidget {
  final AttemptEntity attempt;

  const AttemptPage({super.key, required this.attempt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = attempt;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  Row(
                    children: [
                      Text(
                        a.title!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton.filled(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.home),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Score: ${a.score}/${a.totalScore}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'd MMM yyyy',
                          'en_US',
                        ).format(a.submittedAt!.toLocal()),
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
                        final q = a.questions?[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "Q${index + 1}: ${q?.question}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Column(
                                children: q!.options!.map((option) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: .max,
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: Colors.black54,
                                                  width: 2,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              option.option ?? "",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          option.isCorrect! || option.isChosen!
                                              ? Icons.check
                                              : null,
                                          color: option.isCorrect!
                                              ? Colors.green
                                              : option.isChosen!
                                              ? Colors.grey
                                              : null,
                                        ),
                                      ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
