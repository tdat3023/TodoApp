// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:uuid/uuid.dart';
import 'package:word_generator/word_generator.dart';

DateTime generateRandomDateTime(DateTime minDate, DateTime maxDate) {
  final random = Random();

  final minMillis = minDate.millisecondsSinceEpoch;
  final maxMillis = maxDate.millisecondsSinceEpoch;

  final randomMillis = minMillis + random.nextInt(maxMillis - minMillis);

  return DateTime.fromMillisecondsSinceEpoch(randomMillis);
}

void main() {
  final minDate = DateTime(2023, 05, 22); // Ngày bắt đầu khoảng thời gian
  final maxDate = DateTime(2023, 05, 31); // Ngày kết thúc khoảng thời gian

  print("Nhập tên thư file mock data:");
  final WordGenerator wordGenerator = WordGenerator();
  final fileName = stdin.readLineSync();
  final File file = File("assets/jsons/$fileName.json");

  final List<Task> mockTask = List.generate(Random().nextInt(10) + 10, (index) {
    return Task(
      uid: const Uuid().v4(),
      title: wordGenerator.randomName(),
      description: wordGenerator.randomSentence() +
          wordGenerator.randomSentence() +
          wordGenerator.randomSentence(),
      createdAt: generateRandomDateTime(minDate, maxDate),
      modifiedAt: generateRandomDateTime(minDate, maxDate),
      startTime: generateRandomDateTime(minDate, maxDate),
      dueTime: generateRandomDateTime(minDate, maxDate),
      teamMembers: List.generate(Random().nextInt(10) + 1, (index) {
        return TeamMember(
          uid: const Uuid().v4(),
          avatarUrl:
              "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/618.jpg",
          active: Random().nextBool(),
        );
      }),
      taskStages: List.generate(Random().nextInt(10) + 1, (index) {
        return TaskStage(
          uid: const Uuid().v4(),
          isDone: Random().nextBool(),
          description: wordGenerator.randomSentence(),
          active: Random().nextBool(),
        );
      }),
      active: Random().nextBool(),
    );
  });

  String value = "";

  for (var element in mockTask) {
    value += jsonEncode(element.toMap());
    value += ",";
  }
  file.writeAsStringSync("[$value]");
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
          ? DateTime.tryParse(map['createdAt'] as String)
          : null,
      modifiedAt: map['modifiedAt'] != null
          ? DateTime.tryParse(map['modifiedAt'] as String)
          : null,
      startTime: map['startTime'] != null
          ? DateTime.tryParse(map['startTime'].toString())
          : null,
      dueTime: map['dueTime'] != null
          ? DateTime.tryParse(map['dueTime'].toString())
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
}

class TaskStage {
  final String? uid;
  bool? isDone;
  final String? description;
  final bool? active;

  TaskStage({
    this.uid,
    this.isDone,
    this.description,
    this.active,
  });

  TaskStage copyWith({
    String? id,
    String? uid,
    bool? isDone,
    String? description,
    bool? active,
  }) {
    return TaskStage(
      uid: uid ?? this.uid,
      isDone: isDone ?? this.isDone,
      description: description ?? this.description,
      active: active ?? this.active,
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
}
