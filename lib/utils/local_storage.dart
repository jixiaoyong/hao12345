import 'dart:html';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/28
/// description: save data to local storage
class LocalStorage {
  static final Storage _storage = window.localStorage;

  static void setItem(String key, String value) {
    _storage[key] = value;
  }

  static String? getItem(String key) {
    return _storage[key];
  }

  static void removeItem(String key) {
    _storage.remove(key);
  }
}
