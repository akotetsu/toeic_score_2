// lib/screens/add_record_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/study_record.dart';

class AddRecordScreen extends StatefulWidget {
  final TOEICStudyRecord? existingRecord;
  final Function(TOEICStudyRecord) onSave;

  AddRecordScreen({this.existingRecord, required this.onSave});

  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _testDateController;
  String _selectedSession = '午前';
  late TextEditingController _testCenterController;
  late TextEditingController _listeningScoreController;
  late TextEditingController _readingScoreController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _testDateController = TextEditingController(
        text: widget.existingRecord != null
            ? widget.existingRecord!.testDate
            : '');
    _selectedSession = widget.existingRecord != null
        ? widget.existingRecord!.session
        : '午前';
    _testCenterController = TextEditingController(
        text: widget.existingRecord != null
            ? widget.existingRecord!.testCenter
            : '');
    _listeningScoreController = TextEditingController(
        text: widget.existingRecord != null
            ? widget.existingRecord!.listeningScore.toString()
            : '');
    _readingScoreController = TextEditingController(
        text: widget.existingRecord != null
            ? widget.existingRecord!.readingScore.toString()
            : '');
    _notesController = TextEditingController(
        text: widget.existingRecord != null
            ? widget.existingRecord!.notes
            : '');
  }

  @override
  void dispose() {
    _testDateController.dispose();
    _testCenterController.dispose();
    _listeningScoreController.dispose();
    _readingScoreController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveRecord() {
    if (_formKey.currentState!.validate()) {
      final int listeningScore =
          int.tryParse(_listeningScoreController.text) ?? 0;
      final int readingScore =
          int.tryParse(_readingScoreController.text) ?? 0;

      if (listeningScore < 0 || listeningScore > 495 ||
          readingScore < 0 || readingScore > 495) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('スコアは0から495の範囲で入力してください。')),
        );
        return;
      }

      final record = TOEICStudyRecord(
        testDate: _testDateController.text,
        session: _selectedSession,
        testCenter: _testCenterController.text,
        listeningScore: listeningScore,
        readingScore: readingScore,
        notes: _notesController.text,
      );

      widget.onSave(record);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingRecord != null ? '記録を編集' : '記録を追加'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 受験日
              TextFormField(
                controller: _testDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: '受験日',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime initialDate = _testDateController.text.isNotEmpty
                      ? DateTime.parse(_testDateController.text)
                      : DateTime.now();
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _testDateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '受験日を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // 受験時間（午前/午後）
              DropdownButtonFormField<String>(
                value: _selectedSession,
                decoration: InputDecoration(
                  labelText: '受験時間',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
                items: ['午前', '午後']
                    .map((session) => DropdownMenuItem(
                  value: session,
                  child: Text(session),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSession = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '受験時間を選択してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // 受験会場
              TextFormField(
                controller: _testCenterController,
                decoration: InputDecoration(
                  labelText: '受験会場',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '受験会場を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // LISTENINGスコア
              TextFormField(
                controller: _listeningScoreController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'LISTENINGスコア',
                  prefixIcon: Icon(Icons.headset),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'LISTENINGスコアを入力してください';
                  }
                  if (int.tryParse(value) == null) {
                    return '有効な数値を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // READINGスコア
              TextFormField(
                controller: _readingScoreController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'READINGスコア',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'READINGスコアを入力してください';
                  }
                  if (int.tryParse(value) == null) {
                    return '有効な数値を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // ノート
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'ノート',
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _saveRecord,
          child: Text('保存'),
        ),
      ],
    );
  }
}
