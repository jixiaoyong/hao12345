/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/28
/// description: 搜索引擎
enum SearchEngine { Google, Bing, Baidu }

extension SearchEngineExt on SearchEngine? {
  String get name {
    switch (this) {
      case SearchEngine.Google:
        return 'Google';
      case SearchEngine.Bing:
        return 'Bing';
      case SearchEngine.Baidu:
        return 'Baidu';
      default:
        return 'Google';
    }
  }

  String get url {
    switch (this) {
      case SearchEngine.Google:
        return 'https://www.google.com/search?q=';
      case SearchEngine.Bing:
        return 'https://cn.bing.com/search?q=';
      case SearchEngine.Baidu:
        return 'https://www.baidu.com/s?wd=';
      default:
        return 'https://www.google.com/search?q=';
    }
  }
}
