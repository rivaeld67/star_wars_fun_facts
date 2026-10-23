import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../utils/format.dart';

class PlanetDetailPage extends StatelessWidget {
  final Planet planet;
  const PlanetDetailPage({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    final p = planet;
    final rows = <MapEntry<String, String>>[
      MapEntry('Diameter',
          p.diameter == null ? 'tidak diketahui' : '${formatNumber(p.diameter!)} km'),
      MapEntry('Lama sehari',
          p.rotationPeriod == null ? 'tidak diketahui' : '${p.rotationPeriod} jam'),
      MapEntry('Lama setahun',
          p.orbitalPeriod == null ? 'tidak diketahui' : '${formatNumber(p.orbitalPeriod!)} hari'),
      MapEntry('Gravitasi', orUnknown(p.gravity)),
      MapEntry('Iklim', orUnknown(p.climate)),
      MapEntry('Medan', orUnknown(p.terrain)),
      MapEntry('Air permukaan',
          p.surfaceWater == null ? 'tidak diketahui' : '${p.surfaceWater!.toStringAsFixed(0)}%'),
      MapEntry('Populasi',
          p.population == null ? 'tidak diketahui' : '${formatNumber(p.population!)} jiwa'),
      MapEntry('Tokoh tercatat', '${p.residentCount} tokoh'),
      MapEntry('Muncul di film', '${p.filmCount} film'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: ListView(
        children: rows
            .map((r) => ListTile(title: Text(r.key), subtitle: Text(r.value)))
            .toList(),
      ),
    );
  }
}
