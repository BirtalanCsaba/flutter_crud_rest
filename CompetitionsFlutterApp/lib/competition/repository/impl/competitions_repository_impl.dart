import 'package:fluttercrud/competition/models/competition_model.dart';
import 'package:fluttercrud/competition/repository/competitions_repository.dart';
import 'package:collection/collection.dart';

class CompetitionsRepositoryImpl extends CompetitionsRepository {
  List<Competition> competitions = [];
  int nextId = 0;

  CompetitionsRepositoryImpl() {
    // var comp1 = Competition.all(
    //     judgeId: 1,
    //     title: "Landscape photography",
    //     category: "landscape",
    //     maxPoints: 60,
    //     firstPlacePrize: "new camera",
    //     description: "Landscape photography in detail",
    //     submissionDeadline: DateTime.now().add(const Duration(days: 10)),
    //     isFinished: false
    // );
    // var comp2 = Competition.all(
    //     judgeId: 1,
    //     title: "Women portrait",
    //     category: "portrait",
    //     maxPoints: 30,
    //     firstPlacePrize: "new camera",
    //     description: "Portrait photography in detail",
    //     submissionDeadline: DateTime.now().add(const Duration(days: 10)),
    //     isFinished: false
    // );
    // comp1.id = getNextId();
    // comp2.id = getNextId();
    // competitions.add(comp1);
    // competitions.add(comp2);
  }

  int getNextId() {
    return nextId++;
  }

  @override
  Future<Competition> add(Competition item) async {
    competitions.add(item);
    return item;
  }

  @override
  Future<List<Competition>> get() async {
    return competitions;
  }

  @override
  Future<void> update(Competition item) async {
    int index = competitions.indexWhere((element) => element.id == item.id);
    competitions[index] = item;
  }

  @override
  Future<void> delete(int? id) async {
    if (id == null) {
      return;
    }
    competitions.removeWhere((element) => element.id == id);
  }

  @override
  Future<Competition?> findById(int? id) async {
    if (id == null) {
      throw Exception("Id is null");
    }
    Competition? foundCompetition = competitions.firstWhereOrNull(
            (element) => element.id == id
    );
    if (foundCompetition == null) {
      return null;
    }
    var theComp = Competition.all(
      judgeId: foundCompetition.judgeId,
      title: foundCompetition.title,
      category: foundCompetition.category,
      maxPoints: foundCompetition.maxPoints,
      firstPlacePrize: foundCompetition.firstPlacePrize,
      description: foundCompetition.description,
      submissionDeadline: foundCompetition.submissionDeadline,
      isFinished: foundCompetition.isFinished,
    );
    theComp.id = id;
    return theComp;
  }

  @override
  Future<void> populate(List<Competition> items) async {
    competitions = items;
  }

}