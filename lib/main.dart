import 'package:flutter/material.dart';

import 'component/hao123_page.dart';
import 'page/manage_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'theme/theme_manager.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // Update system brightness provider when system brightness changes
    // This will automatically trigger themeManagerProvider to rebuild
    final currentBrightness =
        SchedulerBinding.instance.window.platformBrightness;
    ref
        .read(systemBrightnessProvider.notifier)
        .updateBrightness(currentBrightness);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeManagerProvider);

    return MaterialApp(
      title: "常用网址导航",
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: {
        '/manage': (_) => const ManagePage(),
      },
      home: const Hao123Page(),
    );
  }
}
