class Planet {
  final String name;
  final String climate;
  final String terrain;
  final String gravity;
  final int? diameter; // km
  final int? population;
  final int? rotationPeriod; // jam
  final int? orbitalPeriod; // hari
  final double? surfaceWater; // persen
  final int residentCount;
  final int filmCount;

  const Planet({
    required this.name,
    required this.climate,
    required this.terrain,
    required this.gravity,
    this.diameter,
    this.population,
    this.rotationPeriod,
    this.orbitalPeriod,
    this.surfaceWater,
    required this.residentCount,
    required this.filmCount,
  });

  // API mengirim angka sebagai String, dan "unknown" untuk data kosong.
  static int? _toInt(dynamic v, {bool zeroIsUnknown = false}) {
    final n = int.tryParse('$v');
    if (n == null) return null;
    if (zeroIsUnknown && n <= 0) return null;
    return n;
  }

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: (json['name'] ?? 'unknown').toString().trim(),
      climate: (json['climate'] ?? 'unknown').toString().trim(),
      terrain: (json['terrain'] ?? 'unknown').toString().trim(),
      gravity: (json['gravity'] ?? 'unknown').toString().trim(),
      diameter: _toInt(json['diameter'], zeroIsUnknown: true),
      population: _toInt(json['population']),
      rotationPeriod: _toInt(json['rotation_period'], zeroIsUnknown: true),
      orbitalPeriod: _toInt(json['orbital_period'], zeroIsUnknown: true),
      surfaceWater: double.tryParse('${json['surface_water']}'),
      residentCount: (json['residents'] as List?)?.length ?? 0,
      filmCount: (json['films'] as List?)?.length ?? 0,
    );
  }
}
