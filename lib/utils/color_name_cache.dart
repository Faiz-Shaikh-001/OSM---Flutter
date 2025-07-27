// Color name cache
class ColorNameCache {
  static final Map<String, String> _cache = {};

  static String? get(String hex) => _cache[hex];

  static void set(String hex, String name) {
    _cache[hex] = name;
  }
}
