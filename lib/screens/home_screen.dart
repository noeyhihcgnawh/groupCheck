import 'package:flutter/material.dart';

import '../models/notice_post.dart';
import '../models/project_models.dart';
import '../widgets/notice_preview_banner.dart';
import '../widgets/notice_section.dart';
import '../widgets/notification_tile.dart';
import '../widgets/project_feed_card.dart';
import '../widgets/today_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userId});

  final String userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _noticeSectionKey = GlobalKey();

  static const List<ProjectPost> _posts = [
    ProjectPost(
      clubName: '멋쟁이사자처럼',
      projectName: '캠퍼스 매칭 서비스',
      status: '베타 테스트 준비 중',
      description: '학생들이 스터디와 팀 프로젝트를 빠르게 찾을 수 있도록 매칭 로직을 다듬고 있어요.',
      progress: 0.82,
      daysLeft: 5,
      startDate: '2026년 5월 1일',
      endDate: '2026년 6월 12일',
      deadlineProgress: 0.88,
      accentColor: Color(0xFF3182F6),
      icon: Icons.code_rounded,
      members: [
        ProjectMember(name: '김민서', role: 'PM', avatarColor: Color(0xFF3182F6)),
        ProjectMember(
          name: '이준영',
          role: 'Frontend',
          avatarColor: Color(0xFF00B894),
        ),
        ProjectMember(
          name: '박서윤',
          role: 'Backend',
          avatarColor: Color(0xFFFF8A3D),
        ),
        ProjectMember(name: '최도현', role: 'QA', avatarColor: Color(0xFF9B59B6)),
      ],
      comments: [
        ProjectComment(author: '민서', message: '로그인 화면 플로우 오늘 안에 확인할게요.'),
        ProjectComment(author: '준영', message: '매칭 결과 화면 QA 체크리스트 올렸습니다.'),
      ],
    ),
    ProjectPost(
      clubName: '영상제작동아리 프레임',
      projectName: '축제 스케치 필름',
      status: '편집 2차 피드백',
      description: '촬영본 컷 편집을 마치고 자막, 색보정, 사운드 믹싱을 순서대로 진행 중입니다.',
      progress: 0.64,
      daysLeft: 9,
      startDate: '2026년 4월 18일',
      endDate: '2026년 6월 16일',
      deadlineProgress: 0.74,
      accentColor: Color(0xFF00B894),
      icon: Icons.movie_creation_rounded,
      members: [
        ProjectMember(
          name: '한서윤',
          role: 'Director',
          avatarColor: Color(0xFF00B894),
        ),
        ProjectMember(
          name: '오하린',
          role: 'Editor',
          avatarColor: Color(0xFF3182F6),
        ),
        ProjectMember(
          name: '강태호',
          role: 'Sound',
          avatarColor: Color(0xFFFF8A3D),
        ),
      ],
      comments: [],
    ),
    ProjectPost(
      clubName: '창업동아리 스파크',
      projectName: '로컬 고객 리서치',
      status: '인터뷰 수집 중',
      description: '예상 고객 인터뷰와 설문 데이터를 모아 다음 주 데모데이 발표 자료로 정리하고 있어요.',
      progress: 0.47,
      daysLeft: 14,
      startDate: '2026년 5월 10일',
      endDate: '2026년 6월 21일',
      deadlineProgress: 0.52,
      accentColor: Color(0xFFFF8A3D),
      icon: Icons.lightbulb_rounded,
      members: [
        ProjectMember(
          name: '오수빈',
          role: 'Research',
          avatarColor: Color(0xFFFF8A3D),
        ),
        ProjectMember(
          name: '정유찬',
          role: 'Design',
          avatarColor: Color(0xFF9B59B6),
        ),
        ProjectMember(
          name: '문가온',
          role: 'Data',
          avatarColor: Color(0xFF3182F6),
        ),
      ],
      comments: [],
    ),
  ];

  static const List<NoticePost> _notices = [
    NoticePost(
      category: '중요',
      title: 'MT 회비 납부 마감 안내',
      summary: '6월 7일 18:00까지 회비 납부를 완료해주세요.',
      time: '오늘',
      color: Color(0xFFEF4444),
      icon: Icons.campaign_rounded,
    ),
    NoticePost(
      category: '일정',
      title: '정기 회의 장소 변경',
      summary: '이번 주 정기 회의는 학생회관 302호에서 진행됩니다.',
      time: '어제',
      color: Color(0xFF3182F6),
      icon: Icons.event_available_rounded,
    ),
    NoticePost(
      category: '공지',
      title: '신입 부원 프로젝트 팀 배정',
      summary: '신입 부원 프로젝트 팀 배정 결과를 확인해주세요.',
      time: '2일 전',
      color: Color(0xFF00B894),
      icon: Icons.group_add_rounded,
    ),
  ];

  static const List<ProjectNotification> _notifications = [
    ProjectNotification(
      icon: Icons.schedule_rounded,
      title: '프로젝트 마감기한 알림',
      message: '캠퍼스 매칭 서비스 마감이 5일 남았습니다.',
      time: '방금 전',
      color: Color(0xFFFF8A3D),
    ),
    ProjectNotification(
      icon: Icons.chat_bubble_rounded,
      title: '피드 댓글 알림',
      message: '준영님이 캠퍼스 매칭 서비스 피드에 댓글을 남겼습니다.',
      time: '12분 전',
      color: Color(0xFF3182F6),
    ),
    ProjectNotification(
      icon: Icons.schedule_rounded,
      title: '프로젝트 마감기한 알림',
      message: '축제 스케치 필름 2차 편집 피드백 일정이 다가옵니다.',
      time: '1시간 전',
      color: Color(0xFF00B894),
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToNotices() {
    final noticeContext = _noticeSectionKey.currentContext;
    if (noticeContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      noticeContext,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      alignment: 0.08,
    );
  }

  void _showNotifications() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.72,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '알림',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF191F28),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationTile(
                          notification: _notifications[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        title: const Text(
          '홈',
          style: TextStyle(
            color: Color(0xFF191F28),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            tooltip: '알림',
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${widget.userId}님, 안녕하세요',
              style: const TextStyle(
                fontSize: 24,
                height: 1.25,
                fontWeight: FontWeight.w800,
                color: Color(0xFF191F28),
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '참여 중인 동아리 프로젝트 소식을 확인해보세요.',
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF6B7684),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 18),
            NoticePreviewBanner(
              notice: _notices.first,
              noticeCount: _notices.length,
              onTap: _scrollToNotices,
            ),
            const SizedBox(height: 18),
            const TodaySummary(),
            const SizedBox(height: 20),
            const Text(
              '프로젝트 피드',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: Color(0xFF191F28),
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 12),
            for (final post in _posts) ...[
              ProjectFeedCard(post: post),
              const SizedBox(height: 14),
            ],
            const SizedBox(height: 10),
            NoticeSection(key: _noticeSectionKey, notices: _notices),
          ],
        ),
      ),
    );
  }
}
