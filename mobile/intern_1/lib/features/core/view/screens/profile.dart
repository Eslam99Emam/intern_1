import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/view/providers/periodic_analysis_providers.dart';
import 'package:intern_1/features/core/view/providers/profile_providers.dart';
import 'package:intern_1/features/core/view/providers/subject_analysis_providers.dart';
import 'package:intern_1/utils/my_background.dart';

class Profile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: MyBackground(
        child: SafeArea(
          child: ref
              .watch(getProfileNotifierProvider)
              .when(
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    child: Center(
                      child: Stack(
                        alignment: AlignmentGeometry.topCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 66),
                            padding: EdgeInsets.only(
                              top: 36,
                              left: 24,
                              right: 24,
                              bottom: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              crossAxisAlignment: .start,
                              mainAxisSize: .max,
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data["name"]} (${data["grade"]})',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .apply(fontWeightDelta: 3),
                                          overflow: .ellipsis,
                                        ),
                                        Text(
                                          (data["email"]) ?? "Email",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .apply(fontWeightDelta: 0),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "AVG",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .apply(fontWeightDelta: 2),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    (data["average"] as double)
                                                        .toStringAsFixed(1),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .apply(fontWeightDelta: 2),
                                              ),
                                              TextSpan(
                                                text: " %",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleSmall!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Insights",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .apply(
                                        fontWeightDelta: 3,
                                        color: Colors.cyan,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    children: [
                                      Text(
                                        "Last 6 Months Scores",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .apply(fontWeightDelta: 2),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 16.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        height: 175,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue.withAlpha(75),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: ref
                                            .watch(periodicAnalysisProvider)
                                            .when(
                                              data: (data) {
                                                final months = [];

                                                List<FlSpot> flSpots = [];

                                                for (var entry
                                                    in data.entries) {
                                                  months.add(
                                                    entry.key.replaceAll(
                                                      "-",
                                                      "\n",
                                                    ),
                                                  );
                                                  if (months.contains(
                                                    entry.key.replaceAll(
                                                      "-",
                                                      "\n",
                                                    ),
                                                  )) {
                                                    flSpots.add(
                                                      FlSpot(
                                                        months
                                                            .indexOf(
                                                              entry.key
                                                                  .replaceAll(
                                                                    "-",
                                                                    "\n",
                                                                  ),
                                                            )
                                                            .toDouble(),
                                                        double.parse(
                                                          (entry.value / 100)
                                                              .toStringAsFixed(
                                                                2,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                                return LineChart(
                                                  LineChartData(
                                                    titlesData: FlTitlesData(
                                                      topTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: false,
                                                        ),
                                                      ),
                                                      rightTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: false,
                                                        ),
                                                      ),
                                                      leftTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          reservedSize: 38,
                                                          interval: 0.2,
                                                          minIncluded: false,
                                                          getTitlesWidget: (value, meta) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    top: 8.0,
                                                                  ),
                                                              child: Text(
                                                                "${(value * 100).toStringAsFixed(0)}%",
                                                                style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          showTitles: true,
                                                        ),
                                                      ),
                                                      bottomTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          reservedSize: 32,
                                                          interval: 1,

                                                          getTitlesWidget: (value, meta) {
                                                            final index = value
                                                                .toInt();
                                                            return Padding(
                                                              padding: EdgeInsets.only(
                                                                left: index == 0
                                                                    ? 32.0
                                                                    : 0.0,
                                                                right:
                                                                    index ==
                                                                        months.length -
                                                                            1
                                                                    ? 32.0
                                                                    : 0.0,
                                                              ),
                                                              child: Text(
                                                                months[index],
                                                                textAlign:
                                                                    .center,
                                                                style:
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          showTitles: true,
                                                        ),
                                                      ),
                                                    ),
                                                    lineBarsData: [
                                                      LineChartBarData(
                                                        isCurved: true,
                                                        barWidth: 3,
                                                        color: Colors.blue,
                                                        dotData: FlDotData(
                                                          show: false,
                                                        ),
                                                        spots: flSpots,
                                                      ),
                                                    ],
                                                    maxY: 1,
                                                    borderData: FlBorderData(
                                                      border: Border(
                                                        bottom: BorderSide(),
                                                        left: BorderSide(),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              error: (error, stackTrace) =>
                                                  Text(error.toString()),
                                              loading: () => Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                      ),
                                      Text(
                                        "Average Score for each subject",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .apply(fontWeightDelta: 2),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 16.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        height: 175,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue.withAlpha(75),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: ref
                                            .watch(subjectAnalysisProvider)
                                            .when(
                                              data: (data) {
                                                final subjects = [];

                                                List<BarChartGroupData> bars =
                                                    [];
                                                // BarChartGroupData(
                                                //         x: 0,
                                                //         barRods: [
                                                //           BarChartRodData(
                                                //             toY: 50,
                                                //             color: Colors.blue,
                                                //           ),
                                                //         ],
                                                //       )

                                                for (var subject in data) {
                                                  subjects.add(
                                                    subject["subject"],
                                                  );
                                                  bars.add(
                                                    BarChartGroupData(
                                                      x: subjects.indexOf(
                                                        subject["subject"],
                                                      ),
                                                      barRods: [
                                                        BarChartRodData(
                                                          toY: double.parse(
                                                            (subject["avg_percentage"]
                                                                    as double)
                                                                .toStringAsFixed(
                                                                  1,
                                                                ),
                                                          ),
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                                return BarChart(
                                                  BarChartData(
                                                    borderData: FlBorderData(
                                                      border: const Border(
                                                        bottom: BorderSide(),
                                                        left: BorderSide(),
                                                      ),
                                                    ),
                                                    gridData: FlGridData(
                                                      show: true,
                                                    ),
                                                    titlesData: FlTitlesData(
                                                      topTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: false,
                                                        ),
                                                      ),
                                                      rightTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: false,
                                                        ),
                                                      ),

                                                      leftTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          reservedSize: 38,
                                                          interval: 20,
                                                          showTitles: true,
                                                          minIncluded: false,
                                                          getTitlesWidget: (value, meta) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    top: 8,
                                                                  ),
                                                              child: Text(
                                                                "${(value).toStringAsFixed(0)}%",
                                                                style:
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),

                                                      bottomTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: true,
                                                          interval: 1,
                                                          reservedSize: 22,
                                                          getTitlesWidget: (value, meta) {
                                                            final index = value
                                                                .toInt();
                                                            log('index $index');
                                                            return Center(
                                                              child: Text(
                                                                subjects[index],
                                                                style:
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          8,
                                                                    ),
                                                                textAlign:
                                                                    .center,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),

                                                    barGroups: bars,
                                                    maxY: 100,
                                                    barTouchData: BarTouchData(
                                                      touchTooltipData: BarTouchTooltipData(
                                                        tooltipPadding:
                                                            EdgeInsets.symmetric(
                                                              vertical: 0.0,
                                                              horizontal: 12.0,
                                                            ),
                                                        getTooltipColor:
                                                            (group) {
                                                              return Colors
                                                                  .transparent;
                                                            },
                                                        tooltipHorizontalAlignment:
                                                            .center,
                                                        getTooltipItem:
                                                            (
                                                              group,
                                                              groupIndex,
                                                              rod,
                                                              rodIndex,
                                                            ) {
                                                              return BarTooltipItem(
                                                                "${rod.toY.toStringAsFixed(0)}%",
                                                                TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              );
                                                            },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              error: (error, stackTrace) {
                                                log('$error');
                                                log('$stackTrace');
                                                return Text(error.toString());
                                              },
                                              loading: () => Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: CircleAvatar(
                              radius: 42,
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              child: Text(
                                "E",
                                style: Theme.of(context).textTheme.displaySmall!
                                    .apply(fontWeightDelta: 3),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton.filled(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
        ),
      ),
    );
  }
}
