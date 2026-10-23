import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../utils/format.dart';
import 'planet_detail_page.dart';

class PlanetListTab extends StatefulWidget {
  final List<Planet> planets;
  const PlanetListTab({super.key, required this.planets});

  @override
  State<PlanetListTab> createState() => _PlanetListTabState();
}

class _PlanetListTabState extends State<PlanetListTab> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final list = widget.planets
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Cari planet...',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const Center(child: Text('Planet tidak ditemukan'))
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final p = list[i];
                    final pop = p.population == null
                        ? 'tidak diketahui'
                        : formatNumber(p.population!);
                    return ListTile(
                      leading: CircleAvatar(child: Text(p.name[0])),
                      title: Text(p.name),
                      subtitle: Text(
                          'Iklim: ${orUnknown(p.climate)} • Populasi: $pop'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PlanetDetailPage(planet: p)),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
