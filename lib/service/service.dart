import 'dart:convert';
import 'package:flutter_load_json_from_local/models/model.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<List<AbilityListModel>> fetchNotes() async {
    var url = 'https://run.mocky.io/v3/ec38799c-82d6-49d9-a033-0f0491816fd4';
    var response = await http.get(url);

    var notes = List<AbilityListModel>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(AbilityListModel.fromJson(noteJson));
      }
    }
    return notes;
  }
}
