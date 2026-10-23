import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../services/planet_service.dart';
import 'fun_fact_tab.dart';
import 'planet_list_tab.dart';
import 'bonus_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Planet>> _future;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _future = PlanetService().fetchPlanets();
  }

  void _reload() => setState(() => _future = PlanetService().fetchPlanets());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Star Wars Fun Facts')),
      body: FutureBuilder<List<Planet>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 48),
                    const SizedBox(height: 12),
                    Text('Gagal memuat data.\n${snap.error}',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    FilledButton(
                        onPressed: _reload, child: const Text('Coba Lagi')),
                  ],
                ),
              ),
            );
          }
          final planets = snap.data!;
          return IndexedStack(index: _index, children: [
            FunFactTab(planets: planets),
            PlanetListTab(planets: planets),
            const BonusTab(),
          ]);
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Fun Fact'),
          NavigationDestination(icon: Icon(Icons.public), label: 'Planet'),
          NavigationDestination(icon: Icon(Icons.flash_on), label: 'Bonus'),
        ],
      ),
    );
  }
}
