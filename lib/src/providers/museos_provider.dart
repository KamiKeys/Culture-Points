import 'dart:convert';
import 'package:http/http.dart' as http;

//  ---------------------------------------------------------
import 'package:culturepoints/src/models/museos_model.dart';

class MuseosProvider {
  int max;

  List<Museo> museos = [];

  Future<List<Museo>> getMuseos() async {
    final url = Uri.parse(
        "https://datosabiertos.malaga.eu/api/3/action/datastore_search?resource_id=2e09336f-c601-4f07-a204-991f98f826b0&limit=10&offset=${museos.length}");

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    museos.addAll(Museos.fromJsonList(decodedData["result"]["records"]).items);
    max = decodedData["result"]["total"];

    return museos;
  }

  Future<List<Museo>> getAllMuseos() async {
    final url = Uri.parse(
        "https://datosabiertos.malaga.eu/api/3/action/datastore_search?resource_id=2e09336f-c601-4f07-a204-991f98f826b0");

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final _museos = Museos.fromJsonList(decodedData["result"]["records"]).items;
    max = decodedData["result"]["total"];

    return _museos;
  }
}
