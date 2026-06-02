import 'package:flutter/material.dart';

import '../models/notice_post.dart';

class NoticePreviewBanner extends StatelessWidget {
  const NoticePreviewBanner({
    super.key,
    required this.notice,
    required this.noticeCount,
    required this.onTap,
  });

  final NoticePost notice;
  final int noticeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 15, 16, 15),
          decoration: BoxDecoration(
            color: notice.color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: notice.color.withValues(alpha: 0.16)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 19,
                backgroundColor: notice.color,
                child: Icon(notice.icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          notice.category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: notice.color,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$noticeCount개 공지',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF8B95A1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      notice.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF191F28),
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      notice.summary,
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
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  key: const Key('noticeJumpButton'),
                  tooltip: '공지사항으로 이동',
                  onPressed: onTap,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.72),
                    foregroundColor: const Color(0xFF4E5968),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
