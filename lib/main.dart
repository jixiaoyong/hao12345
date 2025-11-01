import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'component/hao123_page.dart';
import 'page/manage_page.dart';
import 'theme/theme_manager.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeManagerProvider);
    useOnPlatformBrightnessChange((previous, current) =>
        ref.read(systemBrightnessProvider.notifier).updateBrightness(current));

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
