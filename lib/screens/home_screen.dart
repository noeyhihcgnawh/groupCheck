import 'package:flutter/material.dart';

// 홈 화면: 로그인한 사용자의 동아리 프로젝트 피드를 보여줍니다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userId});

  final String userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 홈 피드 샘플 데이터: 실제 서버 연동 전까지 화면 구성을 확인하기 위한 데이터입니다.
  static const List<ProjectPost> _posts = [
    ProjectPost(
      clubName: '멋쟁이사자처럼',
      projectName: '캠퍼스 매칭 서비스',
      status: '베타 테스트 준비 중',
      description: '학생들이 스터디와 팀 프로젝트를 빠르게 찾을 수 있도록 매칭 로직을 점검하고 있어요.',
      progress: 0.82,
      daysLeft: 5,
      startDate: '2026년 5월 1일',
      endDate: '2026년 6월 12일',
      deadlineProgress: 0.88,
      accentColor: Color(0xFF3182F6),
      icon: Icons.code_rounded,
      members: [
        ProjectMember(name: '김민지', role: 'PM', avatarColor: Color(0xFF3182F6)),
        ProjectMember(
          name: '이준호',
          role: 'Frontend',
          avatarColor: Color(0xFF00B894),
        ),
        ProjectMember(
          name: '박서연',
          role: 'Backend',
          avatarColor: Color(0xFFFF8A3D),
        ),
        ProjectMember(name: '최도윤', role: 'QA', avatarColor: Color(0xFF9B59B6)),
      ],
      comments: [
        ProjectComment(author: '민지', message: '로그인 화면 플로우 오늘 안에 확인할게요.'),
        ProjectComment(author: '준호', message: '매칭 결과 화면 QA 체크리스트 올렸습니다.'),
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
          name: '한지우',
          role: 'Director',
          avatarColor: Color(0xFF00B894),
        ),
        ProjectMember(
          name: '윤하린',
          role: 'Editor',
          avatarColor: Color(0xFF3182F6),
        ),
        ProjectMember(
          name: '강태오',
          role: 'Sound',
          avatarColor: Color(0xFFFF8A3D),
        ),
      ],
      comments: [],
    ),
    ProjectPost(
      clubName: '창업동아리 스파크',
      projectName: '로컬 상권 리서치',
      status: '인터뷰 수집 중',
      description: '소상공인 인터뷰와 설문 데이터를 모아 다음 주 데모데이 발표 자료로 정리하고 있어요.',
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
          name: '문가영',
          role: 'Data',
          avatarColor: Color(0xFF3182F6),
        ),
      ],
      comments: [],
    ),
  ];

  // 알림 샘플 데이터: 마감기한과 피드 댓글 알림을 표시합니다.
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
      message: '준호님이 캠퍼스 매칭 서비스 피드에 댓글을 남겼습니다.',
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

  // 알림 버튼 액션: 화면 아래에서 알림 내역을 보여줍니다.
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
        // 알림 시트 레이아웃: 화면 높이를 제한하고 목록 영역만 스크롤합니다.
        return FractionallySizedBox(
          heightFactor: 0.72,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 알림 시트 제목 영역
                  const Text(
                    '알림',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF191F28),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // 알림 목록: 알림이 많아져도 하단 오버플로우 없이 스크롤됩니다.
                  Expanded(
                    child: ListView.separated(
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        return _NotificationTile(
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
      // 홈 본문: 요약 지표와 인스타그램 피드 형태의 프로젝트 카드 목록입니다.
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
          const _TodaySummary(),
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
        ],
      ),
    );
  }
}

// 프로젝트 피드 데이터 모델: 카드 하나를 그리는 데 필요한 정보를 담습니다.
class ProjectPost {
  const ProjectPost({
    required this.clubName,
    required this.projectName,
    required this.status,
    required this.description,
    required this.progress,
    required this.daysLeft,
    required this.startDate,
    required this.endDate,
    required this.deadlineProgress,
    required this.accentColor,
    required this.icon,
    required this.members,
    required this.comments,
  });

  final String clubName;
  final String projectName;
  final String status;
  final String description;
  final double progress;
  final int daysLeft;
  final String startDate;
  final String endDate;
  final double deadlineProgress;
  final Color accentColor;
  final IconData icon;
  final List<ProjectMember> members;
  final List<ProjectComment> comments;
}

// 프로젝트 멤버 데이터 모델: 멤버 리스트 시트에 표시할 이름, 역할, 프로필 색상을 담습니다.
class ProjectMember {
  const ProjectMember({
    required this.name,
    required this.role,
    required this.avatarColor,
  });

  final String name;
  final String role;
  final Color avatarColor;
}

// 프로젝트 피드 댓글 데이터 모델입니다.
class ProjectComment {
  const ProjectComment({required this.author, required this.message});

  final String author;
  final String message;
}

// 홈 알림 데이터 모델입니다.
class ProjectNotification {
  const ProjectNotification({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String message;
  final String time;
  final Color color;
}

// 오늘의 요약 영역: 프로젝트 수, 업데이트 수, 마감 임박 항목을 표시합니다.
class _TodaySummary extends StatelessWidget {
  const _TodaySummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          _SummaryItem(label: '진행 프로젝트', value: '3'),
          _VerticalDivider(),
          _SummaryItem(label: '오늘 업데이트', value: '8'),
          _VerticalDivider(),
          _SummaryItem(label: '마감 임박', value: '1'),
        ],
      ),
    );
  }
}

// 요약 항목 하나: 숫자와 라벨을 세로로 표시합니다.
class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF191F28),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7684),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// 요약 항목 사이를 구분하는 세로 선입니다.
class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 42, color: const Color(0xFFE5E8EB));
  }
}

// 알림 목록 항목: 알림 종류, 메시지, 시간을 표시합니다.
class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final ProjectNotification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: notification.color.withValues(alpha: 0.12),
            child: Icon(notification.icon, color: notification.color, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF191F28),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4E5968),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.time,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8B95A1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 프로젝트 피드 카드: 동아리별 프로젝트 현황을 카드 형태로 보여줍니다.
class ProjectFeedCard extends StatefulWidget {
  const ProjectFeedCard({super.key, required this.post});

  final ProjectPost post;

  @override
  State<ProjectFeedCard> createState() => _ProjectFeedCardState();
}

class _ProjectFeedCardState extends State<ProjectFeedCard> {
  late final TextEditingController _commentController;
  late final List<ProjectComment> _comments;
  bool _showComments = false;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _comments = List<ProjectComment>.of(widget.post.comments);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // 댓글 추가: 입력된 내용을 현재 피드 댓글 목록에 즉시 반영합니다.
  void _addComment() {
    final message = _commentController.text.trim();
    if (message.isEmpty) {
      return;
    }

    setState(() {
      _comments.add(ProjectComment(author: '나', message: message));
      _commentController.clear();
      _showComments = true;
    });
  }

  // 멤버 버튼 액션: 카톡 친구 리스트처럼 멤버 프로필과 역할을 하단 시트로 보여줍니다.
  void _showMembers() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return _MemberListSheet(post: widget.post);
      },
    );
  }

  // 마감기한 버튼 액션: 프로젝트 시작일과 종료일을 년/월/일 형식으로 보여줍니다.
  void _showDeadlineInfo() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return _DeadlineInfoSheet(post: widget.post);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
            // 카드 헤더: 동아리 이름, 상태, 더보기 버튼을 배치합니다.
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: post.accentColor.withValues(alpha: 0.12),
                  child: Icon(post.icon, color: post.accentColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.clubName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF191F28),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        post.status,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7684),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: '더보기',
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded),
                ),
              ],
            ),
          ),
          // 카드 이미지 영역처럼 보이는 프로젝트 대표 비주얼입니다.
          _ProjectPreview(post: post),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.projectName,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF191F28),
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: Color(0xFF4E5968),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                // 프로젝트 진행률 바입니다.
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: post.progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE5E8EB),
                    color: post.accentColor,
                  ),
                ),
                const SizedBox(height: 12),
                // 진행률, 참여 인원, 마감일, 댓글 버튼을 한 줄로 보여줍니다.
                Row(
                  children: [
                    _MetaChip(
                      icon: Icons.trending_up_rounded,
                      label: '${(post.progress * 100).round()}% 완료',
                    ),
                    const SizedBox(width: 8),
                    _MetaChip(
                      icon: Icons.group_rounded,
                      label: '${post.members.length}명',
                      onTap: _showMembers,
                    ),
                    const SizedBox(width: 8),
                    _DeadlineChip(
                      label: 'D-${post.daysLeft}',
                      progress: post.deadlineProgress,
                      onTap: _showDeadlineInfo,
                    ),
                    const SizedBox(width: 8),
                    _CommentCircleButton(
                      count: _comments.length,
                      isActive: _showComments,
                      onPressed: () {
                        setState(() {
                          _showComments = !_showComments;
                        });
                      },
                    ),
                  ],
                ),
                if (_showComments) ...[
                  const SizedBox(height: 16),
                  _CommentsPanel(
                    comments: _comments,
                    controller: _commentController,
                    onSubmitted: _addComment,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 프로젝트 대표 비주얼: 이미지가 없어도 피드 카드가 시각적으로 보이도록 구성합니다.
class _ProjectPreview extends StatelessWidget {
  const _ProjectPreview({required this.post});

  final ProjectPost post;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.65,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: post.accentColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -28,
              top: -24,
              child: Icon(
                post.icon,
                size: 150,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 20,
              child: Text(
                post.projectName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  height: 1.15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 멤버 리스트 하단 시트: 카톡 친구 목록처럼 프로필, 이름, 역할을 한 줄씩 표시합니다.
class _MemberListSheet extends StatelessWidget {
  const _MemberListSheet({required this.post});

  final ProjectPost post;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.68,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 멤버 시트 제목과 현재 팀 이름을 표시합니다.
              Text(
                post.clubName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF6B7684),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '팀 멤버 ${post.members.length}명',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF191F28),
                ),
              ),
              const SizedBox(height: 16),
              // 멤버 목록: 멤버가 많아져도 시트 내부에서 스크롤됩니다.
              Expanded(
                child: ListView.separated(
                  itemCount: post.members.length,
                  itemBuilder: (context, index) {
                    return _MemberListTile(member: post.members[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 멤버 한 줄: 좌측 프로필 사진 영역, 이름, 우측 역할 배지를 표시합니다.
class _MemberListTile extends StatelessWidget {
  const _MemberListTile({required this.member});

  final ProjectMember member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: member.avatarColor.withValues(alpha: 0.14),
            child: Text(
              member.name.characters.first,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: member.avatarColor,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              member.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF191F28),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F6),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              member.role,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Color(0xFF4E5968),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 마감기한 상세 시트: 프로젝트 시작일과 종료일을 년/월/일 형식으로 보여줍니다.
class _DeadlineInfoSheet extends StatelessWidget {
  const _DeadlineInfoSheet({required this.post});

  final ProjectPost post;

  @override
  Widget build(BuildContext context) {
    final percent = (post.deadlineProgress * 100).round();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 마감기한 시트 제목 영역
            Text(
              post.projectName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF191F28),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '마감기한 진행률 $percent%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFFEF4444),
              ),
            ),
            const SizedBox(height: 18),
            _DateInfoRow(label: '프로젝트 시작', value: post.startDate),
            const SizedBox(height: 10),
            _DateInfoRow(label: '프로젝트 종료', value: post.endDate),
          ],
        ),
      ),
    );
  }
}

// 날짜 정보 한 줄: 기간 라벨과 날짜 값을 구분해서 표시합니다.
class _DateInfoRow extends StatelessWidget {
  const _DateInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF6B7684),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xFF191F28),
            ),
          ),
        ],
      ),
    );
  }
}

// 마감기한 칩: 빨간 게이지로 마감기한 진행률을 직관적으로 보여줍니다.
class _DeadlineChip extends StatelessWidget {
  const _DeadlineChip({
    required this.label,
    required this.progress,
    required this.onTap,
  });

  final String label;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 32,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                // 빨간 게이지 배경: 마감기한 진행률만큼 칩 내부를 채웁니다.
                FractionallySizedBox(
                  widthFactor: clampedProgress,
                  heightFactor: 1,
                  child: Container(color: const Color(0xFFFFDADA)),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 14,
                        color: Color(0xFFEF4444),
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFB42318),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 댓글 원형 버튼: 메타 정보 오른쪽에서 댓글 영역을 열고 닫습니다.
class _CommentCircleButton extends StatelessWidget {
  const _CommentCircleButton({
    required this.count,
    required this.isActive,
    required this.onPressed,
  });

  final int count;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton.filledTonal(
        tooltip: '댓글 $count개',
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: isActive
              ? const Color(0xFFE8F3FF)
              : const Color(0xFFF2F4F6),
          foregroundColor: isActive
              ? const Color(0xFF3182F6)
              : const Color(0xFF6B7684),
          padding: EdgeInsets.zero,
          minimumSize: const Size(32, 32),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
      ),
    );
  }
}

// 댓글 패널: 댓글 목록과 새 댓글 입력창을 표시합니다.
class _CommentsPanel extends StatelessWidget {
  const _CommentsPanel({
    required this.comments,
    required this.controller,
    required this.onSubmitted,
  });

  final List<ProjectComment> comments;
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (comments.isEmpty)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '아직 댓글이 없습니다.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8B95A1),
                ),
              ),
            )
          else
            for (final comment in comments) ...[
              _CommentRow(comment: comment),
              const SizedBox(height: 8),
            ],
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 3,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSubmitted(),
                  decoration: InputDecoration(
                    hintText: '댓글을 입력하세요',
                    hintStyle: const TextStyle(color: Color(0xFF8B95A1)),
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 11,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 36,
                height: 36,
                child: IconButton.filled(
                  tooltip: '댓글 등록',
                  onPressed: onSubmitted,
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF3182F6),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(Icons.arrow_upward_rounded, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 댓글 한 줄: 작성자와 댓글 내용을 표시합니다.
class _CommentRow extends StatelessWidget {
  const _CommentRow({required this.comment});

  final ProjectComment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: const Color(0xFFE8F3FF),
          child: Text(
            comment.author.characters.first,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Color(0xFF3182F6),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13,
                height: 1.35,
                color: Color(0xFF4E5968),
              ),
              children: [
                TextSpan(
                  text: '${comment.author} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF191F28),
                  ),
                ),
                TextSpan(text: comment.message),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 카드 하단 메타 정보 칩: 진행률, 인원, D-day 같은 짧은 정보를 표시합니다.
class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: const Color(0xFF6B7684)),
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4E5968),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
