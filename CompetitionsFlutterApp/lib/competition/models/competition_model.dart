import 'dart:core';

import 'package:fluttercrud/competition/models/base_model.dart';
import 'dart:convert';

class Competition extends BaseModel<int> {
  int? judgeId;
  String title = "";
  String category = "";
  int maxPoints = 0;
  String firstPlacePrize = "";
  String description = "";
  DateTime submissionDeadline = DateTime.now();
  bool isFinished = false;

  Competition();

  Competition.all({
    required this.judgeId,
    required this.title,
    required this.category,
    required this.maxPoints,
    required this.firstPlacePrize,
    required this.description,
    required this.submissionDeadline,
    required this.isFinished});

  factory Competition.fromJson(Map<String, dynamic> json) {
    var comp = Competition.all(
      judgeId: json['judgeId'],
      title: json['title'],
      category: json['category'],
      maxPoints: json['maxPoints'],
      firstPlacePrize: json['firstPlacePrize'],
      description: json['description'],
      submissionDeadline: DateTime.parse(json['submissionDeadline']),
      isFinished: json['isFinished'] == 1 ? true : false,
    );
    comp.id = json['id'];
    return comp;
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'judgeId': 0,
    'title': title,
    'category': category,
    'maxPoints': maxPoints,
    'firstPlacePrize': firstPlacePrize,
    'description': description,
    'submissionDeadline': submissionDeadline.toIso8601String(),
    'isFinished': isFinished ? 1 : 0
  };

}