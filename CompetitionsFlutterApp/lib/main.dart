import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercrud/competition/views/competition_add_screen.dart';
import 'package:fluttercrud/competition/views/competition_edit_screen.dart';
import 'package:fluttercrud/config/locator.dart';
import 'package:fluttercrud/competition/repository/competitions_repository.dart';
import 'package:fluttercrud/competition/view_models/home_view_model.dart';
import 'package:fluttercrud/competition/views/competitions_screen.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  setupLocator();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => HomeViewModel(
              competitionsRepository: locator<CompetitionsRepository>()
          ),
      ),
    ],
    child: const AppStart(),
  ));
}

class AppStart extends StatelessWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/competitions',
      routes: {
        '/competitions': (context) => const HomePage(),
        '/competitions/edit': (context) => const CompetitionEditScreen(),
        '/competitions/add': (context) => const CompetitionAddScreen(),
      },
    );
  }
}
