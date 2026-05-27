import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

// 앱 시작점: Flutter 앱을 실행합니다.
void main() {
  runApp(const MyApp());
}

// 앱 공통 설정: 테마, 앱 이름, 첫 화면을 관리합니다.
//홍준기 - 커밋 테스트
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GroupCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3182F6),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}
