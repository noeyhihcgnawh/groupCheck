import 'package:flutter/material.dart';

import 'home_screen.dart';

// 앱 기본 화면: 로그인 이후 하단 탭과 각 주요 화면을 관리합니다.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.userId});

  final String userId;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // 현재 선택된 하단 탭 인덱스입니다.
  int _selectedIndex = 0;

  // 하단 탭별 화면 목록입니다. 홈 외 기능은 아직 보류 화면으로 연결합니다.
  late final List<Widget> _pages = [
    HomeScreen(userId: widget.userId),
    const _PendingFeatureScreen(
      icon: Icons.fact_check_rounded,
      title: '출석체크',
      message: '출석 기능은 다음 단계에서 구현할 예정입니다.',
    ),
    const _PendingFeatureScreen(
      icon: Icons.calendar_month_rounded,
      title: '캘린더',
      message: '동아리 일정 확인 기능은 다음 단계에서 구현할 예정입니다.',
    ),
    const _PendingFeatureScreen(
      icon: Icons.tune_rounded,
      title: '옵션',
      message: '앱 설정 기능은 다음 단계에서 구현할 예정입니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack으로 탭 전환 시 각 화면 상태를 유지합니다.
      body: IndexedStack(index: _selectedIndex, children: _pages),
      // 하단 툴바: 홈, 출석체크, 캘린더, 옵션 탭을 제공합니다.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        height: 68,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE8F3FF),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.fact_check_outlined),
            selectedIcon: Icon(Icons.fact_check_rounded),
            label: '출석체크',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month_rounded),
            label: '캘린더',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune_rounded),
            label: '옵션',
          ),
        ],
      ),
    );
  }
}

// 미구현 기능 안내 화면: 아직 구현하지 않은 탭에 임시로 표시됩니다.
class _PendingFeatureScreen extends StatelessWidget {
  const _PendingFeatureScreen({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF191F28),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 54, color: const Color(0xFF3182F6)),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.45,
                  color: Color(0xFF6B7684),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
