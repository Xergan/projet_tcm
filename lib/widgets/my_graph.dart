import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tcm/blocs/sensor/sensor_data_cubit.dart';

class MyGraph extends StatelessWidget {
  final String idCapteur;
  final DateTime dateTime;

  const MyGraph({super.key, required this.idCapteur, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    context.read<SensorDataCubit>().fetchDatas(idCapteur, dateTime);

    return BlocBuilder<SensorDataCubit, SensorDataState>(
      builder: (context, state) {
        if (state is SensorDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SensorDataError) {
          return Center(child: Text('Erreur : ${state.errorMessage}'));
        } else if (state is SensorDataLoaded) {
          final lineData =
              state.datas.map((item) {
                  final date = DateTime.parse(item['Datetime']);
                  final index = (date.hour * 2) + (date.minute >= 30 ? 1 : 0);
                  final remplissage = item['Remplissage']?.toDouble() ?? 0.0;
                  return FlSpot(index.toDouble(), remplissage);
                }).toList()
                ..sort((a, b) => a.x.compareTo(b.x));

          if (lineData.isEmpty) {
            return const Center(
              child: Text(
                'Pas de données disponibles.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          final existingIndices = lineData.map((e) => e.x.toInt()).toSet();

          return LineChart(
            LineChartData(
              minY: 0,
              maxY: 100,
              minX: 0,
              maxX: lineData.length > 1 ? lineData.length - 1 : 1,
              lineBarsData: [
                LineChartBarData(
                  spots: lineData,
                  isCurved: true,
                  color: Colors.cyan,
                  barWidth: 2,
                  belowBarData: BarAreaData(show: true),
                  dotData: FlDotData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 20,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toInt()}%',
                        style: TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index % 6 != 0 || !existingIndices.contains(index)) {
                        return const SizedBox.shrink();
                      }

                      final hour = (index ~/ 2);
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('${hour}h', style: TextStyle(fontSize: 10)),
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          );
        } else {
          return const Center(child: Text('État inconnu.'));
        }
      },
    );
  }
}

FlLine getGridLine() {
  return FlLine(color: Colors.white10, strokeWidth: 1);
}
