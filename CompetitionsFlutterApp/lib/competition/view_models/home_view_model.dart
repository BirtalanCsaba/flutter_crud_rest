import 'package:flutter/cupertino.dart';
import 'package:fluttercrud/competition/repository/competitions_repository.dart';
import 'package:fluttercrud/competition/services/DatabaseHelper.dart';
import 'package:fluttercrud/competition/services/http_service.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;
import 'package:logging/logging.dart';

import '../models/competition_model.dart';

class HomeViewModel extends ChangeNotifier {
  final log = Logger('HomeViewModel');

  HomeViewModel({
    required this.competitionsRepository,
  });

  List<Competition> competitions = [];

  final CompetitionsRepository competitionsRepository;

  DateTime selectedDate = DateTime.now();
  int maxPoints = 0;

  Future<void> fetchData() async {
    log.info("Competitions are being retrieved.");
    List<Competition>? items = [];
    try {
      items = await HttpService.get();
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot fetch data");
    }
    await competitionsRepository.populate(items);
    competitions = await competitionsRepository.get();
    notifyListeners();
  }

  Future<void> add(Competition competition) async {
    log.info("Adding a competition: ${competition.toJson()}.");
    Competition createdCompetition;
    try {
      createdCompetition = await HttpService.create(competition);
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot add data");
    }
    await competitionsRepository.add(createdCompetition);
    notifyListeners();
  }

  Future<void> update(Competition competition) async {
    log.info("Updating a competition: ${competition.toJson()}.");
    try {
      await HttpService.update(competition);
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot update data");
    }
    await competitionsRepository.update(competition);
    int index = competitions.indexWhere((element) => element.id == competition.id);
    competitions[index] = competition;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    log.info("Deleting a competition with id: $id.");
    try {
      await HttpService.delete(id);
    } on Exception catch(ex) {
      log.severe(ex.toString());
      throw Exception("Cannot update data");
    }
    await competitionsRepository.delete(id);
    competitions.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<Competition> findById(int? id) async {
    log.info("Finding competition by id: $id.");
    return competitionsRepository.findById(id);
  }
}
