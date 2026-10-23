import '../models/planet.dart';
import '../utils/format.dart';

class FunFact {
  final String icon;
  final String title;
  final String text;
  const FunFact(this.icon, this.title, this.text);
}

Planet? _best(List<Planet> list, num? Function(Planet) key, {bool max = true}) {
  final valid = list.where((p) => key(p) != null).toList();
  if (valid.isEmpty) return null;
  valid.sort((a, b) =>
      max ? key(b)!.compareTo(key(a)!) : key(a)!.compareTo(key(b)!));
  return valid.first;
}

/// Mengolah data mentah API menjadi fun fact (ranking, agregasi, hitungan).
List<FunFact> generateFunFacts(List<Planet> planets) {
  final facts = <FunFact>[];

  final big = _best(planets, (p) => p.diameter);
  if (big != null) {
    facts.add(FunFact('🪐', 'Planet Terbesar',
        '${big.name} berdiameter ${formatNumber(big.diameter!)} km, yang terbesar dalam data.'));
  }
  final small = _best(planets, (p) => p.diameter, max: false);
  if (small != null) {
    facts.add(FunFact('🔬', 'Planet Terkecil',
        '${small.name} hanya berdiameter ${formatNumber(small.diameter!)} km, yang terkecil dalam data.'));
  }
  final crowded = _best(planets, (p) => p.population);
  if (crowded != null) {
    facts.add(FunFact('🏙️', 'Paling Padat Penduduk',
        '${crowded.name} dihuni ${formatNumber(crowded.population!)} jiwa, terbanyak di antara semua planet.'));
  }
  final empty = _best(
      planets, (p) => (p.population ?? 0) > 0 ? p.population : null,
      max: false);
  if (empty != null) {
    facts.add(FunFact('🏜️', 'Paling Sepi',
        '${empty.name} hanya berpenduduk ${formatNumber(empty.population!)} jiwa (tidak termasuk planet tanpa penduduk).'));
  }
  final longDay = _best(planets, (p) => p.rotationPeriod);
  if (longDay != null) {
    facts.add(FunFact('🌗', 'Hari Terpanjang',
        'Satu hari di ${longDay.name} berlangsung ${longDay.rotationPeriod} jam standar.'));
  }
  final longYear = _best(planets, (p) => p.orbitalPeriod);
  if (longYear != null) {
    facts.add(FunFact('☄️', 'Tahun Terpanjang',
        '${longYear.name} butuh ${formatNumber(longYear.orbitalPeriod!)} hari untuk mengorbit satu kali.'));
  }
  final wet = _best(planets, (p) => p.surfaceWater);
  if (wet != null) {
    facts.add(FunFact('🌊', 'Paling Berair',
        'Permukaan ${wet.name} tertutup air sekitar ${wet.surfaceWater!.toStringAsFixed(0)}%.'));
  }
  final star = _best(planets, (p) => p.filmCount > 0 ? p.filmCount : null);
  if (star != null) {
    facts.add(FunFact('🎬', 'Bintang Layar Lebar',
        '${star.name} muncul di ${star.filmCount} film, paling sering di antara semua planet.'));
  }
  final home =
      _best(planets, (p) => p.residentCount > 0 ? p.residentCount : null);
  if (home != null) {
    facts.add(FunFact('👥', 'Kampung Halaman Tokoh',
        '${home.name} adalah asal ${home.residentCount} tokoh yang tercatat di API.'));
  }
  final temperate = planets
      .where((p) => p.climate.toLowerCase().contains('temperate'))
      .length;
  facts.add(FunFact('🌤️', 'Iklim Favorit',
      '$temperate dari ${planets.length} planet memiliki iklim temperate (sedang).'));

  return facts;
}

/// Fun fact singkat untuk satu planet (dipakai tombol "Fun Fact Acak").
FunFact planetFact(Planet p) {
  final pop = p.population == null
      ? 'tidak diketahui'
      : '${formatNumber(p.population!)} jiwa';
  return FunFact('✨', p.name,
      '${p.name} beriklim ${orUnknown(p.climate)} dengan medan ${orUnknown(p.terrain)}. Populasinya: $pop.');
}
