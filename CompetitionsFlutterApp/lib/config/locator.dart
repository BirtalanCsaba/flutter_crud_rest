import 'package:fluttercrud/competition/repository/impl/competitions_repository_impl.dart';
import 'package:get_it/get_it.dart';

import '../competition/repository/competitions_repository.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerFactory<CompetitionsRepository>(
          () => CompetitionsRepositoryImpl()
  );
}