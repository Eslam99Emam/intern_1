import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:intern_1/features/attempts/view/providers/get_history_providers.dart';
import 'package:intern_1/utils/my_background.dart';
import 'package:intl/intl.dart';

class History extends ConsumerWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: MyBackground(
        child: Center(
          child: ref
              .watch(getHistoryNotifierProvider)
              .when(
                data: (data) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast,
                    ),
                    child: SafeArea(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 32.0,
                              ),
                              child: Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    "Reports",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .apply(fontWeightDelta: 2),
                                  ),
                                  IconButton.filled(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back),
                                  ),
                                ],
                              ),
                            ),
                            GlassContainer(
                              height: 200,
                              margin: EdgeInsets.fromLTRB(
                                32.0,
                                16.0,
                                32.0,
                                16.0,
                              ),
                              color: Colors.transparent,
                              borderColor: Colors.black.withAlpha(15),
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(0),
                                  blurRadius: 8.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              blur: 10,
                              frostedOpacity: 0.075,
                              isFrostedGlass: true,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(16.0),
                                        child: Text(
                                          'Your Total Assessments Are:',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(16.0),
                                        child: Text(
                                          '${data.length}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(16.0),
                                        child: Text(
                                          // 'Last Assessment at ${DateFormat.yMMMMd(data.first.datetime).replaceFirst(' ', ' at ')}',
                                          'Last Assessment at ${data.first.submittedAt?.toLocal().toString().split(' ')[0]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .apply(
                                                color: Colors.grey[700],
                                                fontWeightDelta: 1,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                              indent: 32.0,
                              endIndent: 32.0,
                              radius: BorderRadius.circular(24.0),
                              color: const Color.from(
                                alpha: 1,
                                red: 0.6,
                                green: 0.6,
                                blue: 0.6,
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    log('${data[index].id}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0,
                                      vertical: 8.0,
                                    ),
                                    child: Card(
                                      color: Colors.white.withAlpha(175),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(
                                            '${data[index].title}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                          subtitle: Text(
                                            'Submitted At: ${DateFormat('d MMM yyyy', 'en_US').format(data[index].submittedAt!.toLocal())}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelSmall,
                                          ),
                                          trailing: Text(
                                            'Score\n${((data[index].score! / data[index].totalScore!) * 100).toStringAsFixed(1)}%',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  log(stackTrace.toString());
                  return Text(error.toString());
                },
                loading: () => CircularProgressIndicator(),
              ),
        ),
      ),
    );
  }
}
