import 'dart:convert';
import 'dart:ffi';

import 'package:fluttercrud/competition/models/competition_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:logging/logging.dart';

class HttpService {
  static final log = Logger('HttpService');

  static Future<List<Competition>> get() async {
    log.info("Getting competitions on: /competitions");
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/competitions'))
        .timeout(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> competitions = jsonDecode(response.body);
      List<Competition> competitionsList = [];
      for (var competition in competitions) {
        competitionsList.add(Competition.fromJson(competition));
      }
      return competitionsList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log.severe("Get method failed.");
      throw Exception('Failed to load competitions');
    }

  }

  static Future<Competition> create(Competition competition) async {
    log.info("Creating competition (${competition.toJson()}) on: /competitions");
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/competitions'),
      body: json.encode(competition.toJson()),
      headers: {"Content-Type": "application/json"},
    )
        .timeout(const Duration(seconds: 2));
    if (response.statusCode != 200) {
      log.severe("Post method failed.");
      throw Exception('Failed to create competitions');
    }
    return Competition.fromJson(jsonDecode(response.body));
  }

  static Future<void> update(Competition competition) async {
    log.info("Updating competition (${competition.toJson()}) on: /competitions");
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8080/competitions'),
      body: json.encode(competition.toJson()),
      headers: {"Content-Type": "application/json"},
    )
        .timeout(const Duration(seconds: 2));
    if (response.statusCode != 200) {
      log.severe("Put method failed.");
      throw Exception('Failed to update competition');
    }
  }

  static Future<void> delete(int id) async {
    log.info("Deleting competition with id ($id) on: /competitions/$id");
    final response = await http.delete(
        Uri.parse('http://10.0.2.2:8080/competitions/$id'),
    )
        .timeout(const Duration(seconds: 2));
    if (response.statusCode != 200) {
      log.severe("Delete method failed.");
      throw Exception('Failed to delete competitions');
    }
  }
}