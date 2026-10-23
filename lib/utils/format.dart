/// 1000000 -> "1.000.000"
String formatNumber(int n) => n
    .toString()
    .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.');

/// Data API sering berisi "unknown" / "N/A" -> tampilkan teks yang ramah.
String orUnknown(String s) {
  final t = s.trim();
  final l = t.toLowerCase();
  return (t.isEmpty || l == 'unknown' || l == 'n/a') ? 'tidak diketahui' : t;
}
