import 'dart:async';
import 'dart:convert';

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
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'competition/models/competition_model.dart';


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

class AppStart extends StatefulWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  late final StompClient stompClient;
  late final HomeViewModel _homeViewModel;

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/competitions/add',
      callback: (frame) {
        dynamic frameBody = jsonDecode(frame.body!);
        print(frameBody);
        _homeViewModel.addFromWebsocket(Competition.fromJson(frameBody));
      },
    );
    stompClient.subscribe(
      destination: '/topic/competitions/update',
      callback: (frame) {
        dynamic frameBody = jsonDecode(frame.body!);
        print(frameBody);
        _homeViewModel.updateFromWebsocket(Competition.fromJson(frameBody));
      },
    );
    stompClient.subscribe(
      destination: '/topic/competitions/delete',
      callback: (frame) {
        dynamic frameBody = jsonDecode(frame.body!);
        print(frameBody);
        _homeViewModel.deleteFromWebsocket(frameBody);
      },
    );
  }

  @override
  void initState() {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.2.2:8080/stomp-endpoint',
        onConnect: onConnect,
        reconnectDelay: const Duration(seconds: 5),
        connectionTimeout: const Duration(seconds: 5),
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );
    stompClient.activate();

    super.initState();
  }

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
