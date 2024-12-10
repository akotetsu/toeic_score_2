// lib/screens/graph_screen.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/study_record.dart';

class GraphScreen extends StatelessWidget {
  final List<TOEICStudyRecord> records;

  GraphScreen({required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return Center(
        child: Text(
          'まだ記録がありません。記録を追加してください。',
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      );
    }

    // 受験日順にソート
    List<TOEICStudyRecord> sortedRecords = List.from(records);
    sortedRecords.sort((a, b) => DateTime.parse(a.testDate).compareTo(DateTime.parse(b.testDate)));

    // 各スコアのリストを作成
    List<FlSpot> listeningSpots = [];
    List<FlSpot> readingSpots = [];
    List<FlSpot> totalSpots = [];

    for (int i = 0; i < sortedRecords.length; i++) {
      listeningSpots.add(FlSpot(i.toDouble(), sortedRecords[i].listeningScore.toDouble()));
      readingSpots.add(FlSpot(i.toDouble(), sortedRecords[i].readingScore.toDouble()));
      totalSpots.add(FlSpot(i.toDouble(), (sortedRecords[i].listeningScore + sortedRecords[i].readingScore).toDouble()));
    }

    // X軸のラベル（日付）
    List<String> xLabels = sortedRecords.map((record) => DateFormat('MM/dd').format(DateTime.parse(record.testDate))).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // ラインチャート
          Expanded(
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 990, // 最大スコアに合わせて調整
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < xLabels.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              xLabels[value.toInt()],
                              style: TextStyle(fontSize: 10),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 100,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 100,
                  verticalInterval: 1,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey),
                ),
                lineBarsData: [
                  // リスニングスコア
                  LineChartBarData(
                    spots: listeningSpots,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                  // リーディングスコア
                  LineChartBarData(
                    spots: readingSpots,
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                  // 総合スコア
                  LineChartBarData(
                    spots: totalSpots,
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // 凡例
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16.0,
                height: 16.0,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                ),
              ),
              const SizedBox(width: 8),
              const Text('リスニング'),
              const SizedBox(width: 8),
              Container(
                width: 16.0,
                height: 16.0,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.rectangle,
                ),
              ),
              const Text('リーディング'),
              //SizedBox(width: 16.0),
              const SizedBox(width: 8),
              Container(
                width: 16.0,
                height: 16.0,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.rectangle,
                ),
              ),
              const Text('トータル')
            ],
          ),
        ],
      ),
    );
  }
}

// 凡例を表すカスタムウィジェット
// class LegendItem extends StatelessWidget {
//   final Color color;
//   final String text;
//
//   LegendItem({required this.color, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // カラーブロック
//         Container(
//           width: 16.0,
//           height: 16.0,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.rectangle,
//           ),
//         ),
//         // テキストラベル
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.0,
//             color: Theme.of(context).colorScheme.onBackground,
//           ),
//         ),
//       ],
//     );
//   }
// }
