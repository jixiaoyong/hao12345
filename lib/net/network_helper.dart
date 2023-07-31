import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'leancloud_api.dart';
import 'leancloud_info.dart';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/20
/// description: 网络工具类
class NetworkHelper {
  static const String BASE_URL = "https://api.android666.cf/1.1/";

  static late NetworkHelper INSTANCE = NetworkHelper._();

  late Dio _dio;
  late LeanCloudApi apiService;

  NetworkHelper._() {
    var dioOptions = BaseOptions(
      baseUrl: BASE_URL,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-LC-Id": LeanCloudInfo.appId,
        "X-LC-Key": LeanCloudInfo.appKey,
        // "X-LC-Sign": LeanCloudInfo.getSign()
      },
    );
    _dio = Dio(dioOptions);

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    apiService = LeanCloudApi(_dio);
  }
}
