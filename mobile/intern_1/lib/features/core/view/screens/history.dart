import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:intern_1/main.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        child: Center(
          child: SingleChildScrollView(
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
                            style: Theme.of(context).textTheme.headlineLarge!
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
                      margin: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(16.0),
                                child: Text(
                                  '15',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(16.0),
                                child: Text(
                                  'Last Assessment at 2025 May',
                                  style: Theme.of(context).textTheme.labelSmall!
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
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Padding(
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
                                  'Exam ID #${index + 1}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  'Subject: ${index % 6 == 0
                                      ? "Arabic"
                                      : index % 6 == 1
                                      ? "English"
                                      : index % 6 == 2
                                      ? "Maths"
                                      : index % 6 == 3
                                      ? "Physics"
                                      : index % 6 == 4
                                      ? "Flutter"
                                      : index % 6 == 5
                                      ? "Data Science"
                                      : ""}',
                                ),
                                trailing: Text(
                                  'Score\n${index + 1}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge,
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
          ),
        ),
      ),
    );
  }
}
