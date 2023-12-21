//import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// ignore_for_file: public_member_api_docs

import 'package:components/src/theme/color_scheme/light_color_scheme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/report/chart/indicator.dart';

class DCPieChart extends StatefulWidget {
  final int one_star;
  final int two_star;
  final int three_star;
  final int four_star;
  final int five_star;
  final int sum_star;

  const DCPieChart({
    Key? key,
    required this.one_star,
    required this.two_star,
    required this.three_star,
    required this.four_star,
    required this.five_star,
    required this.sum_star,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DCPieChartState();
}

class DCPieChartState extends State<DCPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final DocCareLightColorScheme colorScheme = DocCareLightColorScheme();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(
                    widget.one_star.toDouble() /
                        widget.sum_star.toDouble() *
                        100,
                    widget.two_star.toDouble() /
                        widget.sum_star.toDouble() *
                        100,
                    widget.three_star.toDouble() /
                        widget.sum_star.toDouble() *
                        100,
                    widget.four_star.toDouble() /
                        widget.sum_star.toDouble() *
                        100,
                    widget.five_star.toDouble() /
                        widget.sum_star.toDouble() *
                        100,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: colorScheme.primary,
                text: 'One Star',
                textColor: colorScheme.onBackground,
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: colorScheme.secondary,
                text: 'Two Star',
                textColor: colorScheme.onBackground,
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: colorScheme.error,
                text: 'Three Star',
                textColor: colorScheme.onBackground,
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: colorScheme.quinary,
                text: 'Four Star',
                textColor: colorScheme.onBackground,
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: colorScheme.quartenary,
                text: 'Five Star',
                textColor: colorScheme.onBackground,
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
    double one_star_percent,
    double two_star_percent,
    double three_star_percent,
    double four_star_percent,
    double five_star_percent,
  ) {
    final DocCareLightColorScheme colorScheme = DocCareLightColorScheme();
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: colorScheme.primary,
            value: one_star_percent,
            title: one_star_percent.toInt().toString() + " %",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondary,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: colorScheme.secondary,
            value: two_star_percent,
            title: two_star_percent.toInt().toString() + " %",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondary,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: colorScheme.error,
            value: three_star_percent,
            title: three_star_percent.toInt().toString() + " %",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondary,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: colorScheme.quinary,
            value: four_star_percent,
            title: four_star_percent.toInt().toString() + " %",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondary,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: colorScheme.quartenary,
            value: five_star_percent,
            title: five_star_percent.toInt().toString() + " %",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondary,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
