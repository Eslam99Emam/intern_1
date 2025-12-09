import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intern_1/utils/my_background.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        child: SafeArea(
          child: Padding(
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
                      mainAxisAlignment: .center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Eslam Emam",
                                  // textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(fontWeightDelta: 3),
                                ),
                                Text(
                                  "Grade 14",
                                  // textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
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
                                        text: "60",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
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
                          style: Theme.of(context).textTheme.titleLarge!.apply(
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
                                style: Theme.of(context).textTheme.titleMedium!
                                    .apply(fontWeightDelta: 2),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16.0),
                                padding: EdgeInsets.all(16.0),
                                height: 175,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.withAlpha(75),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: LineChart(
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
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: Text(
                                                "${(value * 100).toStringAsFixed(0)}%",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            );
                                          },
                                          showTitles: true,
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          reservedSize: 14,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            const months = [
                                              "Jan",
                                              "Feb",
                                              "Mar",
                                              "Apr",
                                              "May",
                                              "Jun",
                                              "Jul",
                                              "Aug",
                                              "Sep",
                                              "Oct",
                                              "Nov",
                                              "Dec",
                                            ];

                                            final index = value.toInt();
                                            return Text(
                                              months[index],
                                              style: const TextStyle(
                                                fontSize: 10,
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
                                        dotData: FlDotData(show: false),
                                        spots: [
                                          FlSpot(0, 0),
                                          FlSpot(1, 0.7),
                                          FlSpot(2, 0.6),
                                          FlSpot(3, 0.8),
                                          FlSpot(4, 0.2),
                                          FlSpot(5, 0.9),
                                          FlSpot(6, 0.4),
                                        ],
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
                                ),
                              ),
                              Text(
                                "Average Score for each subject",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .apply(fontWeightDelta: 2),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16.0),
                                padding: EdgeInsets.all(16.0),
                                height: 175,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.withAlpha(75),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: BarChart(
                                  BarChartData(
                                    borderData: FlBorderData(
                                      border: const Border(
                                        bottom: BorderSide(),
                                        left: BorderSide(),
                                      ),
                                    ),
                                    gridData: FlGridData(show: true),

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
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                              ),
                                              child: Text(
                                                "${(value).toStringAsFixed(0)}%",
                                                style: const TextStyle(
                                                  fontSize: 10,
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
                                            const months = [
                                              "Arabic",
                                              "English",
                                              "Maths",
                                              "Physics",
                                              "Flutter",
                                              "Data\nScience",
                                            ];

                                            final index = value.toInt();
                                            return Center(
                                              child: Text(
                                                months[index],
                                                style: const TextStyle(
                                                  fontSize: 8,
                                                ),
                                                textAlign: .center,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    barGroups: [
                                      BarChartGroupData(
                                        x: 0,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 50,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 1,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 81,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 2,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 73,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 3,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 25,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 4,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 92,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                      BarChartGroupData(
                                        x: 5,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 100,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ],
                                    maxY: 100,
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipPadding: EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 12.0,
                                        ),
                                        getTooltipColor: (group) {
                                          return Colors.transparent;
                                        },
                                        tooltipHorizontalAlignment: .center,
                                        getTooltipItem:
                                            (group, groupIndex, rod, rodIndex) {
                                              return BarTooltipItem(
                                                "${rod.toY.toStringAsFixed(0)}%",
                                                TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                      ),
                                    ),
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
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.apply(fontWeightDelta: 3),
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
          ),
        ),
      ),
    );
  }
}
