import 'package:dio/dio.dart';

// 非 Web 平台：使用 HEAD/GET 并发检测
Future<Map<String, bool>> isReachable(List<String> urls) async {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 8),
    sendTimeout: const Duration(seconds: 8),
    followRedirects: true,
    validateStatus: (s) => s != null && s >= 200 && s < 400,
  ));
  Future<bool> one(String url) async {
    if (url.isEmpty) return false;
    try {
      final head = await dio.head(url, options: Options(followRedirects: true));
      if (head.statusCode != null && head.statusCode! < 400) return true;
    } catch (_) {}
    try {
      final get = await dio.get(url, options: Options(method: 'GET'));
      return get.statusCode != null && get.statusCode! < 400;
    } catch (_) {
      return false;
    }
  }

  final futures = <Future<MapEntry<String, bool>>>[];
  for (final u in urls) {
    futures.add(one(u).then((ok) => MapEntry(u, ok)));
  }
  final entries = await Future.wait(futures);
  return {for (final e in entries) e.key: e.value};
}

// 非 Web 平台：提供一个一次性产出所有结果的流（与 Web API 对齐）
Stream<Map<String, dynamic>> streamIsReachable(List<String> urls) async* {
  if (urls.isEmpty) return;
  final map = await isReachable(urls);
  for (final entry in map.entries) {
    yield {'url': entry.key, 'reachable': entry.value};
  }
}


