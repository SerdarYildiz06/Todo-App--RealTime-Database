import 'dart:convert';

import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String defination;
  int importance;
  TaskModel({
    required this.id,
    required this.title,
    required this.defination,
    required this.importance,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? defination,
    int? importance,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      defination: defination ?? this.defination,
      importance: importance ?? this.importance,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'defination': defination});
    result.addAll({'importance': importance});

    return result;
  }

  Color setImportanceBackGroundColor(int importance) {
    switch (importance) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

  factory TaskModel.fromMap(Map<dynamic, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      defination: map['defination'] ?? '',
      importance: map['importance'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, defination: $defination, importance: $importance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.title == title &&
        other.defination == defination &&
        other.importance == importance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        defination.hashCode ^
        importance.hashCode;
  }
}
