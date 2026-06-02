import 'package:flutter/material.dart';

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

class ProjectComment {
  const ProjectComment({required this.author, required this.message});

  final String author;
  final String message;
}

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
