import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/puntos_model.dart';

class ChartPedido extends StatelessWidget {
  const ChartPedido({Key? key, required this.puntos, required this.indice})
      : super(key: key);
  final List<PedidoPuntos> puntos;
  final int indice;

  List<int> get showIndexes => puntos.map((e) => e.x.toInt()).toList();

  List<FlSpot> get allSpots =>
      puntos.map((e) => FlSpot((e.x.toDouble()), e.y.toDouble())).toList();

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        colors: <Color>[AppTheme.blueBackground],
        showingIndicators: showIndexes,
        spots: allSpots,
        barWidth: 3,
        // dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          colors: <Color>[
            AppTheme.light.withOpacity(0.0),
            AppTheme.light.withOpacity(1.0)
          ],
          show: true,
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return Container(
      alignment: Alignment.center,
      // color: AppTheme.background,
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 0, top: 0),
      width: Responsive.getScreenSize(context).height * .42,
      height: Responsive.getScreenSize(context).height * .42,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          // padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 0),
          alignment: Alignment.center,
          //  color: AppTheme.blueDark,
          margin: const EdgeInsets.only(top: 32.0, left: 30, right: 30),
          width:  (indice == 0 || indice==3)  
              ? Responsive.getScreenSize(context).width * 1.9
              : indice == 1
                  ? Responsive.getScreenSize(context).width * 1.0
                  : Responsive.getScreenSize(context).width * 3.2,
          height: Responsive.getScreenSize(context).height * .54,
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
                        //  dashArray: [8, 10]
                      ),
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
                        lineBarSpot.y.toInt().toString(),
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
                    String text = '';

                    switch (indice) {
                      case 0:
                        text = PedidoPuntos.horasDelDia[a.toInt()];
                        break;
                      case 1:
                        text = PedidoPuntos.diasDeLaSemana[a.toInt()];
                        break;
                      case 2:
                        text = PedidoPuntos.diasDelMes[a.toInt()];
                        break;
                      case 3:
                        text = PedidoPuntos.horasDelDia[a.toInt()];
                        break;
                      default:
                        text = PedidoPuntos.horasDelDia[a.toInt()];
                        break;
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
                drawVerticalLine: false,
                getDrawingHorizontalLine: (double a) {
                  return FlLine(
                      color: AppTheme.light,
                      strokeWidth: 0.5,
                      dashArray: [5, 5]);
                },
              ),
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
