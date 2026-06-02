import 'package:flutter/material.dart';

import '../models/notice_post.dart';

class NoticeSection extends StatelessWidget {
  const NoticeSection({super.key, required this.notices});

  final List<NoticePost> notices;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          key: Key('noticeSectionTitle'),
          '공지사항',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: Color(0xFF191F28),
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 12),
        for (final notice in notices) ...[
          _NoticeCard(notice: notice),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.notice});

  final NoticePost notice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: notice.color.withValues(alpha: 0.12),
            child: Icon(notice.icon, color: notice.color, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: notice.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        notice.category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: notice.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      notice.time,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8B95A1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Text(
                  notice.title,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF191F28),
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  notice.summary,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4E5968),
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
