// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(TOEICStudyApp());
}

class TOEICStudyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOEIC Study Records',
      debugShowCheckedModeBanner: false, // デバッグバナーを非表示
      theme: ThemeData(
        // テーマの基本色を紫に設定
        primarySwatch: Colors.deepPurple,
        // カラースキームをカスタマイズ
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
          secondary: Colors.purpleAccent, // セカンダリーカラー
          //background: Colors.white, // 背景色
          surface: Colors.white, // 表面色
          onPrimary: Colors.white, // primary色上のテキスト色
          onSecondary: Colors.white, // secondary色上のテキスト色
          //onBackground: Colors.black87, // 背景色上のテキスト色
          onSurface: Colors.black87, // 表面色上のテキスト色
        ),
        // アプリバーのテーマをカスタマイズ
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white, // アイコンやテキストの色
          elevation: 4.0,
        ),
        // FloatingActionButton のテーマをカスタマイズ
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.purpleAccent,
          foregroundColor: Colors.white,
        ),
        // テキストテーマをカスタマイズ
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
          headlineSmall: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        // ボタンのテーマをカスタマイズ
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // ボタンの背景色
            foregroundColor: Colors.white, // ボタンのテキスト色
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        // アイコンテーマをカスタマイズ
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        // 入力フィールドのテーマをカスタマイズ
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          labelStyle: TextStyle(color: Colors.deepPurple),
          prefixIconColor: Colors.deepPurple,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.purpleAccent),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
