import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

enum TaskProgress {
  imcoming,
  inProgress,
  done,
  failure,
}

class Task {
  final String? uid;
  final String? title;
  final String? description;
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final DateTime? startTime;
  final DateTime? dueTime;
  final List<TeamMember> teamMembers;
  final List<TaskStage> taskStages;
  final bool? active;

  const Task({
    required this.uid,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.modifiedAt,
    required this.startTime,
    required this.dueTime,
    required this.teamMembers,
    required this.taskStages,
    required this.active,
  });

  Task copyWith({
    String? uid,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? modifiedAt,
    DateTime? startTime,
    DateTime? dueTime,
    List<TeamMember>? teamMembers,
    List<TaskStage>? taskStages,
    bool? active,
  }) {
    return Task(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      startTime: startTime ?? this.startTime,
      dueTime: dueTime ?? this.dueTime,
      teamMembers: teamMembers ?? this.teamMembers,
      taskStages: taskStages ?? this.taskStages,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'description': description,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'modifiedAt': modifiedAt?.millisecondsSinceEpoch,
      'startTime': startTime?.millisecondsSinceEpoch,
      'dueTime': dueTime?.millisecondsSinceEpoch,
      'teamMembers': teamMembers.map((x) => x.toMap()).toList(),
      'taskStages': taskStages.map((x) => x.toMap()).toList(),
      'active': active,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      uid: map['uid'] != null ? map['uid'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      modifiedAt: map['modifiedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['modifiedAt'] as int)
          : null,
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int)
          : null,
      dueTime: map['dueTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueTime'] as int)
          : null,
      teamMembers: List<TeamMember>.from(
        (map['teamMembers'] as List? ?? []).map<TeamMember>(
          (x) => TeamMember.fromMap(x as Map<String, dynamic>),
        ),
      ),
      taskStages: List<TaskStage>.from(
        (map['taskStages'] as List? ?? []).map<TaskStage>(
          (x) => TaskStage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      active: map['active'] != null ? map['active'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(uid: $uid, title: $title, description: $description, createdAt: $createdAt, modifiedAt: $modifiedAt, startTime: $startTime, dueTime: $dueTime, teamMembers: $teamMembers, taskStages: $taskStages, active: $active)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt &&
        other.startTime == startTime &&
        other.dueTime == dueTime &&
        listEquals(other.teamMembers, teamMembers) &&
        listEquals(other.taskStages, taskStages) &&
        other.active == active;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode ^
        startTime.hashCode ^
        dueTime.hashCode ^
        teamMembers.hashCode ^
        taskStages.hashCode ^
        active.hashCode;
  }
}

class TaskStage {
  final String? uid;
  bool? isDone;
  final String? description;
  final bool? active;
  final bool isEditing;

  TaskStage({
    this.uid,
    this.isDone,
    this.description,
    this.active,
    this.isEditing = false,
  });

  TaskStage copyWith({
    String? uid,
    bool? isDone,
    String? description,
    bool? active,
    bool? isEditing,
  }) {
    return TaskStage(
      uid: uid ?? this.uid,
      isDone: isDone ?? this.isDone,
      description: description ?? this.description,
      active: active ?? this.active,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'isDone': isDone,
      'description': description,
      'active': active,
    };
  }

  factory TaskStage.fromMap(Map<String, dynamic> map) {
    return TaskStage(
      uid: map['uid'] != null ? map['uid'] as String : null,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskStage.fromJson(String source) =>
      TaskStage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskStage(uid: $uid, isDone: $isDone, description: $description, active: $active)';
  }

  @override
  bool operator ==(covariant TaskStage other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.isDone == isDone &&
        other.description == description &&
        other.active == active;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        isDone.hashCode ^
        description.hashCode ^
        active.hashCode;
  }
}

class TeamMember {
  final String? uid;
  final String? avatarUrl;
  final bool? active;
  const TeamMember({
    this.uid,
    this.avatarUrl,
    this.active,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'avatarUrl': avatarUrl,
      'active': active,
    };
  }

  TeamMember copyWith({
    String? id,
    String? uid,
    String? avatarUrl,
    bool? active,
  }) {
    return TeamMember(
      uid: uid ?? this.uid,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      active: active ?? this.active,
    );
  }

  factory TeamMember.fromMap(Map<String, dynamic> map) {
    return TeamMember(
      uid: map['uid'] != null ? map['uid'] as String : null,
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      active: map['active'] != null ? map['active'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamMember.fromJson(String source) =>
      TeamMember.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeamMember(uid: $uid, avatarUrl: $avatarUrl, active: $active)';
  }

  @override
  bool operator ==(covariant TeamMember other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.avatarUrl == avatarUrl &&
        other.active == active;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ avatarUrl.hashCode ^ active.hashCode;
  }
}
