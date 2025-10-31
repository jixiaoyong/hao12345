import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'theme.dart';
import '../state/home_setting_view_model.dart';

/// System brightness notifier - tracks current system brightness
class SystemBrightnessNotifier extends Notifier<Brightness> {
  @override
  Brightness build() {
    return SchedulerBinding.instance.window.platformBrightness;
  }

  void updateBrightness(Brightness brightness) {
    state = brightness;
  }
}

/// System brightness provider - tracks current system brightness
/// This provider updates when system brightness changes
final systemBrightnessProvider =
    NotifierProvider<SystemBrightnessNotifier, Brightness>(
        SystemBrightnessNotifier.new);

/// Theme Manager Provider
/// Derives theme from settings and system brightness
/// Automatically updates when either settings or system brightness changes
final themeManagerProvider = Provider<ThemeData>((ref) {
  final settings = ref.watch(homeSettingViewModelProvider);
  final systemBrightness = ref.watch(systemBrightnessProvider);

  // Determine theme based on preference
  final bool? isDarkTheme = settings.isDarkTheme;
  final bool isDarkMode = isDarkTheme ??
      (systemBrightness == Brightness.dark);

  return isDarkMode ? kDarkTheme : kLightTheme;
});
