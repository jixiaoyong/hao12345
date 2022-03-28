import 'package:dio/dio.dart';
import 'package:hao12345/bean/all_urls_bean.dart';
import 'package:retrofit/http.dart';

import 'network_helper.dart';

part 'leancloud_api.g.dart';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/20
/// description:
/// flutter pub run build_runner build
///
@RestApi(baseUrl: NetworkHelper.BASE_URL)
abstract class LeanCloudApi {
  factory LeanCloudApi(Dio dio, {String baseUrl}) = _LeanCloudApi;

  @GET("/classes/{className}")
  Future<AllUrlsBean> getClasses(@Path("className") String className);
}
