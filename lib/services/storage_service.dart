import 'package:hive/hive.dart';

class StorageService {
  static final Box _box = Hive.box('data');
  static void storage(StorageKey key, String value) => _box.put(key.name, value);
  static get(StorageKey key) => _box.get(key.name);

  static bool showHome = true;
  static bool searchResult = false;
}

enum StorageKey {
  registered,
  history
}
