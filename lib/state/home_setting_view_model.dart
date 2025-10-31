import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hao12345/bean/local_setting_config.dart';
import 'package:hao12345/bean/search_engine.dart';
import 'package:hao12345/utils/local_storage.dart';
import 'package:hao12345/utils/some_keys.dart';

/// Repository for managing local setting storage
class HomeSettingRepository {
  Future<LocalSettingConfig> loadSettings() async {
    final configStr = LocalStorage.getItem(SomeKeys.SETTING_CONFIG);
    return LocalSettingConfig.fromJsonStrOrNull(configStr);
  }

  Future<void> saveSettings(LocalSettingConfig config) async {
    final configJson = json.encode(config.toJson());
    LocalStorage.setItem(SomeKeys.SETTING_CONFIG, configJson);
  }
}

final homeSettingRepositoryProvider =
    Provider<HomeSettingRepository>((ref) => HomeSettingRepository());

class HomeSettingViewModel extends Notifier<LocalSettingConfig> {
  late final HomeSettingRepository _repository;

  @override
  LocalSettingConfig build() {
    _repository = ref.read(homeSettingRepositoryProvider);
    return _loadSettings();
  }

  LocalSettingConfig _loadSettings() {
    final configStr = LocalStorage.getItem(SomeKeys.SETTING_CONFIG);
    return LocalSettingConfig.fromJsonStrOrNull(configStr);
  }

  /// Update font size
  Future<void> updateFontSize(double fontSize) async {
    final updated = state.copyWith(fontSize: fontSize);
    state = updated;
    await _repository.saveSettings(updated);
  }

  /// Update search icon
  Future<void> updateSearchIcon(String searchIcon) async {
    final updated = state.copyWith(searchIcon: searchIcon);
    state = updated;
    await _repository.saveSettings(updated);
  }

  /// Update search engine
  Future<void> updateSearchEngine(SearchEngine searchEngine) async {
    final updated = state.copyWith(searchEngine: searchEngine);
    state = updated;
    await _repository.saveSettings(updated);
  }

  /// Update theme preference
  /// isDarkTheme: null = 自动跟随系统, false = 亮色, true = 暗色
  Future<void> updateThemePreference(bool? isDarkTheme) async {
    final updated = state.copyWith(isDarkTheme: isDarkTheme);
    state = updated;
    await _repository.saveSettings(updated);
  }

  /// Refresh settings from storage
  Future<void> refresh() async {
    state = _loadSettings();
  }
}

final homeSettingViewModelProvider =
    NotifierProvider<HomeSettingViewModel, LocalSettingConfig>(
        HomeSettingViewModel.new);
