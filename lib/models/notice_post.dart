import 'package:flutter/material.dart';

class NoticePost {
  const NoticePost({
    required this.category,
    required this.title,
    required this.summary,
    required this.time,
    required this.color,
    required this.icon,
  });

  final String category;
  final String title;
  final String summary;
  final String time;
  final Color color;
  final IconData icon;
}
