import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

// [Corrected] Your Worker URL for the API endpoint.
const String _workerUrl = 'https://service.apphub.qzz.io/api/check-url';

/// Web 端流式批量检测：服务端以换行分隔 JSON（NDJSON）流式返回
/// 逐条产出：{ "url": string, "reachable": bool }
Stream<Map<String, dynamic>> streamIsReachable(List<String> urls) async* {
  if (urls.isEmpty) {
    return;
  }


  final xhr = html.HttpRequest();
  xhr.open('POST', _workerUrl);
  xhr.setRequestHeader('Content-Type', 'application/json');

  final controller = StreamController<Map<String, dynamic>>();
  String buffer = '';

  void handleChunk() {
    final text = xhr.responseText ?? '';
    if (text.length <= buffer.length) return;
    final chunk = text.substring(buffer.length);
    buffer = text;
    final parts = chunk.split('\n');
    for (final line in parts) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      try {
        final obj = jsonDecode(trimmed);
        if (obj is Map<String, dynamic>) controller.add(obj);
      } catch (_) {
        // 忽略半包或解析失败的片段，等待后续补全
      }
    }
  }

  xhr.onProgress.listen((_) => handleChunk());
  xhr.onReadyStateChange.listen((_) {
    if (xhr.readyState == html.HttpRequest.DONE) {
      handleChunk();
      controller.close();
    }
  });
  xhr.onError.listen((_) {
    controller.add({'error': '网络错误或跨域受限'});
    controller.close();
  });

  xhr.send(jsonEncode({'urls': urls}));
  yield* controller.stream;
}
