// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leancloud_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _LeanCloudApi implements LeanCloudApi {
  _LeanCloudApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.xiaoyong.ml/1.1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AllUrlsBean> getClasses(className) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AllUrlsBean>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/classes/${className}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AllUrlsBean.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
