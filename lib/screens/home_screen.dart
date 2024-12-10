// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'results_list_screen.dart';
import 'graph_screen.dart';
import '../models/study_record.dart';
import 'add_record_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // 記録リストの管理
  final List<TOEICStudyRecord> _records = [];

  // タブに対応するウィジェットをリストとして保持
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      ResultsListScreen(
        records: _records,
        onEdit: _editRecord,
        onDelete: _deleteRecord,
      ),
      GraphScreen(
        records: _records,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 記録を追加するメソッド
  void _addRecord(TOEICStudyRecord record) {
    setState(() {
      _records.add(record);
      // グラフ画面の更新
      _widgetOptions[1] = GraphScreen(records: _records);
    });
  }

  // 記録を編集するメソッド
  void _editRecord(int index, TOEICStudyRecord updatedRecord) {
    setState(() {
      _records[index] = updatedRecord;
      // グラフ画面の更新
      _widgetOptions[1] = GraphScreen(records: _records);
    });
  }

  // 記録を削除するメソッド
  void _deleteRecord(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('記録を削除'),
        content: Text('この記録を削除してもよろしいですか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _records.removeAt(index);
                // グラフ画面の更新
                _widgetOptions[1] = GraphScreen(records: _records);
              });
              Navigator.of(context).pop();
            },
            child: Text('削除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // FAB を押したときに記録入力画面を表示
  void _showAddRecordDialog() {
    showDialog(
      context: context,
      builder: (context) => AddRecordScreen(
        onSave: (newRecord) {
          _addRecord(newRecord);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOEIC受験記録管理'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: _showAddRecordDialog,
        child: Icon(Icons.add),
        tooltip: '記録を追加',
      )
          : null, // グラフタブにはFABを表示しない
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '結果一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'グラフ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary, // セカンダリーカラー
        onTap: _onItemTapped,
      ),
    );
  }
}
