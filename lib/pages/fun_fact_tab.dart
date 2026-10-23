import 'dart:math';
import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../services/fun_fact_generator.dart';

class FunFactTab extends StatefulWidget {
  final List<Planet> planets;
  const FunFactTab({super.key, required this.planets});

  @override
  State<FunFactTab> createState() => _FunFactTabState();
}

class _FunFactTabState extends State<FunFactTab> {
  final _rand = Random();
  late final List<FunFact> _records;
  late final List<FunFact> _pool;
  late FunFact _current;

  @override
  void initState() {
    super.initState();
    _records = generateFunFacts(widget.planets);
    _pool = [..._records, ...widget.planets.map(planetFact)];
    _current = _pool[_rand.nextInt(_pool.length)];
  }

  void _shuffle() =>
      setState(() => _current = _pool[_rand.nextInt(_pool.length)]);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(_current.icon, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                Text(_current.title,
                    style: text.titleLarge, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(_current.text,
                    style: text.bodyLarge, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _shuffle,
                  icon: const Icon(Icons.shuffle),
                  label: const Text('Fun Fact Acak'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('Rekor Galaksi', style: text.titleMedium),
        const SizedBox(height: 8),
        ..._records.map((f) => Card(
              child: ListTile(
                leading: Text(f.icon, style: const TextStyle(fontSize: 28)),
                title: Text(f.title),
                subtitle: Text(f.text),
              ),
            )),
      ],
    );
  }
}
