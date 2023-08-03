part of base;

class Storage {
  final GetStorage _storage = GetStorage();
  static final Map<String, Storage> _storageLogger = <String, Storage>{};

  factory Storage() {
    return _storageLogger.putIfAbsent('storage', () => Storage._internal());
  }
  Storage._internal();

  dynamic get(
    String key,
  ) {
    return _storage.read(key);
  }

  void set(
    String key,
    dynamic value,
  ) async {
    await _storage.write(key, value);
  }

  void remove(
    String key,
  ) {
    _storage.remove(key);
  }

  void clear() {
    _storage.erase();
  }
}
