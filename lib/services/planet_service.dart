import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/planet.dart';

class PlanetService {
  static const String _url = 'https://sw.simplr.sh/api/planets/all.json';

  Future<List<Planet>> fetchPlanets() async {
    final res =
        await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 15));
    if (res.statusCode != 200) {
      throw Exception('Server membalas HTTP ${res.statusCode}');
    }
    final decoded = jsonDecode(res.body);
    final List raw = decoded is List ? decoded : (decoded['results'] as List);

    final planets = raw
        .map((e) => Planet.fromJson(e as Map<String, dynamic>))
        .where((p) => p.name.toLowerCase() != 'unknown') // buang entri kosong
        .toList();
    if (planets.isEmpty) throw Exception('Data planet kosong');
    return planets;
  }
}
