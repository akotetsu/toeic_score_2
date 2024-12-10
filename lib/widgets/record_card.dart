// lib/widgets/record_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/study_record.dart';

class RecordCard extends StatelessWidget {
  final TOEICStudyRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  RecordCard({
    required this.record,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    int totalScore = record.listeningScore + record.readingScore;

    // セッションによる色の決定
    Color sessionColor = record.session == '午前' ? Colors.deepPurple : Colors.purpleAccent;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 受験日と時間
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.parse(record.testDate)),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: sessionColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    record.session,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // 受験会場
            Text(
              '受験会場: ${record.testCenter}',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 8.0),
            // スコア表示（L:370 R:350 Total:720）
            Text(
              'L:${record.listeningScore} R:${record.readingScore} Total:$totalScore',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            // ノート
            Text(
              'ノート: ${record.notes}',
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 8.0),
            // 編集・削除ボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


