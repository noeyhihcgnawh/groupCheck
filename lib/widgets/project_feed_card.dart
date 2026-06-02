import 'package:flutter/material.dart';

import '../models/project_models.dart';

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
