// lib/screens/results_list_screen.dart

import 'package:flutter/material.dart';
import '../models/study_record.dart';
import '../widgets/record_card.dart';
import 'add_record_screen.dart';

class ResultsListScreen extends StatelessWidget {
  final List<TOEICStudyRecord> records;
  final Function(int, TOEICStudyRecord) onEdit;
  final Function(int) onDelete;

  ResultsListScreen({
    required this.records,
    required this.onEdit,
    required this.onDelete,
  });

  // 編集用ダイアログを表示
  void _showEditDialog(BuildContext context, int index, TOEICStudyRecord record) {
    showDialog(
      context: context,
      builder: (context) => AddRecordScreen(
        existingRecord: record,
        onSave: (editedRecord) {
          onEdit(index, editedRecord);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return records.isEmpty
        ? Center(
      child: Text(
        'まだ記録がありません。',
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    )
        : ListView.builder(
      padding: EdgeInsets.only(bottom: 80.0), // FABのスペースを確保
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return RecordCard(
          record: record,
          onEdit: () => _showEditDialog(context, index, record),
          onDelete: () => onDelete(index),
        );
      },
    );
  }
}
