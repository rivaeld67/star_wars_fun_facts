import 'package:flutter/material.dart';

/// Konten lokal (bukan dari API) karena API Star Wars publik tidak
/// menyediakan data lightsaber / kyber crystal.
class BonusTab extends StatelessWidget {
  const BonusTab({super.key});

  static const _items = [
    [
      '⚔️',
      'Lightsaber',
      'Senjata khas Jedi dan Sith berupa bilah energi. Bilahnya dibentuk oleh inti kristal kyber di dalam gagang.'
    ],
    [
      '💎',
      'Kyber Crystal',
      'Kristal yang peka terhadap Force dan menjadi jantung lightsaber. Kristal ini memfokuskan energi sehingga membentuk bilah.'
    ],
    [
      '🎨',
      'Warna Bilah',
      'Warna bilah ditentukan oleh kristal kyber-nya. Jedi umumnya biru atau hijau, sedangkan Sith identik dengan merah.'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Bonus: Lightsaber & Kyber',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text('Data lokal (bukan dari API)',
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        ..._items.map((e) => Card(
              child: ListTile(
                leading: Text(e[0], style: const TextStyle(fontSize: 28)),
                title: Text(e[1]),
                subtitle: Text(e[2]),
              ),
            )),
      ],
    );
  }
}
