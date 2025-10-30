// 平台自适配的站点可达性检测
// Web 端：通过后端批量检测接口；非 Web 端：本地并发检测
import 'dart:async';
import 'reachability_io.dart' if (dart.library.html) 'reachability_web.dart'
    as impl;

// 流式检测：逐条返回 { 'url': string, 'reachable': bool, 'reason'?: string }
// 如果 URL 数量 > 45，则并行分批（每批最多 45 个）
Stream<Map<String, dynamic>> streamCheckReachability(List<String> urls) {
  final list = urls.where((e) => e.trim().isNotEmpty).toList();
  if (list.isEmpty) {
    return const Stream.empty();
  }
  const maxBatch = 45;
  if (list.length <= maxBatch) {
    return impl.streamIsReachable(list);
  }
  final controller = StreamController<Map<String, dynamic>>();
  final batches = <List<String>>[];
  for (var i = 0; i < list.length; i += maxBatch) {
    batches.add(list.sublist(i, i + maxBatch > list.length ? list.length : i + maxBatch));
  }
  int active = batches.length;
  for (final batch in batches) {
    final stream = impl.streamIsReachable(batch);
    stream.listen(
      controller.add,
      onError: (e, st) {
        // 忽略单批错误，继续其它批次
      },
      onDone: () {
        active -= 1;
        if (active == 0 && !controller.isClosed) {
          controller.close();
        }
      },
      cancelOnError: false,
    );
  }
  return controller.stream;
}
