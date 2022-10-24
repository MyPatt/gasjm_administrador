import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';

class ChartPedido extends StatelessWidget {
  const ChartPedido();

  List<int> get showIndexes => const [0, 1, 2, 3, 4, 5, 6];
  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 3),
        FlSpot(4, 3.5),
        FlSpot(5, 5),
        FlSpot(6, 8),
      ];

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        colors: <Color>[AppTheme.blueBackground],
        showingIndicators: showIndexes,
        spots: allSpots,
        //  isCurved: true,
        barWidth: 4,
        // dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          colors: <Color>[AppTheme.light.withOpacity(0.0)],
          show: false,
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return Container(
      alignment: Alignment.center,
      width: Responsive.getScreenSize(context).height * .42,
      height: Responsive.getScreenSize(context).height * .55,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          // padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 0),
          alignment: Alignment.center,
          width: Responsive.getScreenSize(context).width * .70,
          height: Responsive.getScreenSize(context).height * .53,
          child: LineChart(
            LineChartData(
              showingTooltipIndicators: showIndexes.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: false,
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                          color: AppTheme.blueDark,
                          strokeWidth: 1.5,
                          dashArray: [8, 10]),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          color: AppTheme.blueBackground,
                          //radius: 5,
                          strokeWidth: 2,
                          strokeColor: AppTheme.blueDark,
                        ),
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: AppTheme.blueDark,
                  tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  tooltipMargin: 8,
                  //  tooltipRoundedRadius: 8,
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map((lineBarSpot) {
                      return LineTooltipItem(
                        lineBarSpot.y.toString(),
                        const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              minX: 0,
              titlesData: FlTitlesData(
                leftTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 0,
                ),
                bottomTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTextStyles: (BuildContext context, double a) {
                    return Theme.of(context).textTheme.caption?.copyWith(
                          color: AppTheme.blueDark,
                        );
                  },
                  getTitles: (double a) {
                    String text;
                    switch (a.toInt()) {
                      case 0:
                        text = '00:00';
                        break;
                      case 1:
                        text = '04:00';
                        break;
                      case 2:
                        text = '08:00';
                        break;
                      case 3:
                        text = '12:00';
                        break;
                      case 4:
                        text = '16:00';
                        break;
                      case 5:
                        text = '20:00';
                        break;
                      case 6:
                        text = '23:59';
                        break;
                      default:
                        return '';
                    }

                    return text;
                  },
                ),
                rightTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 0,
                ),
                topTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 0,
                ),
              ),
              gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (double a) {
                    return FlLine(
                        color: AppTheme.light,
                        strokeWidth: 0.5,
                        dashArray: [5, 5]);
                  },
                  getDrawingVerticalLine: (double a) {
                    return FlLine(
                        color: AppTheme.light,
                        strokeWidth: 0.5,
                        dashArray: [5, 5]);
                  }),
              borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    top: BorderSide.none,
                    bottom: BorderSide(color: AppTheme.light),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
 
/*
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/puntos_model.dart';

class ChartPedido extends StatelessWidget {
  const ChartPedido({Key? key, required this.puntos}) : super(key: key);
  final List<PedidoPuntos> puntos;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
            padding: const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
            alignment: Alignment.center,
            width: Responsive.getScreenSize(context).height * .42,
            height: Responsive.getScreenSize(context).height * .55,
            child: LineChart(
              LineChartData(
                  //  gridData: FlGridData(verticalInterval: 1.0),

                  gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (double a) {
                        return FlLine(
                            color: AppTheme.light,
                            strokeWidth: 0.5,
                            dashArray: [5, 5]);
                      },
                      getDrawingVerticalLine: (double a) {
                        return FlLine(
                            color: AppTheme.light,
                            strokeWidth: 0.5,
                            dashArray: [5, 5]);
                      }),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (BuildContext context, double a) {
                          return Theme.of(context).textTheme.caption?.copyWith(
                                color: AppTheme.blueDark,
                              );
                        }),
                    bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (BuildContext context, double a) {
                          return Theme.of(context).textTheme.caption?.copyWith(
                                color: AppTheme.blueDark,
                              );
                        },
                        getTitles: (double a) {
                          String text;
                          switch (a.toInt()) {
                            case 0:
                              text = 'Hoy';
                              break;
                            case 1:
                              text = '04:00';
                              break;
                            case 2:
                              text = '08:00';
                              break;
                            case 3:
                              text = '12:00';
                              break;
                            case 4:
                              text = '16:00';
                              break;
                            case 5:
                              text = '20:00';
                              break;
                            case 6:
                              text = '23:59';
                              break;
                            default:
                              return '-';
                          }
                          return text;
                        }),
                    topTitles: SideTitles(
                      showTitles: false,
                    ),
                    rightTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> indicators) {
                      return indicators.map(
                        (int index) {
                          final line = FlLine(
                              color: AppTheme.blueDark,
                              strokeWidth: 2,
                              dashArray: [7, 10]);
                          return TouchedSpotIndicatorData(
                            line,
                            FlDotData(show: true),
                          );
                        },
                      ).toList();
                    },
                    getTouchLineEnd: (_, __) => double.infinity,
                    touchTooltipData: LineTouchTooltipData(
                      showOnTopOfTheChartBoxArea: true,
                      tooltipBgColor: AppTheme.blueDark,
                      tooltipRoundedRadius: 15.0,
                      fitInsideHorizontally: true,
                      tooltipMargin: 2,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map(
                          (LineBarSpot touchedSpot) {
                            const textStyle = TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            );
                            return LineTooltipItem(
                              pedidoPuntos[touchedSpot.spotIndex]
                                  .y
                                  .toStringAsFixed(2),
                              textStyle,
                            );
                          },
                        ).toList();
                      },
                    ),
                  ),
                  minX: 0,
                  minY: 0,
                  borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        top: BorderSide.none,
                        bottom: BorderSide(color: AppTheme.light),
                        left: BorderSide(color: AppTheme.light),
                      )),
                  lineBarsData: [
                    LineChartBarData(
                        colors: [
                          AppTheme.blueBackground,
                        ],
                        spots: puntos.map((e) => FlSpot((e.x), e.y)).toList(),
                        isCurved: true,
                        dotData: FlDotData(show: true)) 
                  ]),
              //  swapAnimationCurve: Curves.decelerate,
            )),
      ),
    );
  }
} 
*/