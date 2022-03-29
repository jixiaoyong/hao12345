import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hao12345/bean/local_setting_config.dart';
import 'package:hao12345/bean/search_engine.dart';
import 'package:hao12345/utils/local_storage.dart';
import 'package:hao12345/utils/some_keys.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bean/all_urls_bean.dart';
import '../net/network_helper.dart';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/28
/// description: todo
class Hao123Page extends StatefulWidget {
  LocalSettingConfig localSettingConfig;

  Hao123Page({
    Key? key,
    required this.localSettingConfig,
  }) : super(key: key);

  @override
  State<Hao123Page> createState() => _Hao123PageState();
}

class _Hao123PageState extends State<Hao123Page> {
  AllUrlsBean? allUrlsBean;

  // for webview
  Results? _onHoverItem;

  late TextEditingController _textController;

  @override
  initState() {
    super.initState();
    _textController = TextEditingController();
    init();
  }

  void init() {
    NetworkHelper.INSTANCE.apiService.getClasses("hao123").then((value) {
      setState(() {
        allUrlsBean = value;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallWidthScreen = kIsWeb && screenWidth <= 400;
    var inputMethodPadding = screenWidth / 20;
    if (isSmallWidthScreen) {
      inputMethodPadding = 0;
    }

    var iconSize = screenWidth / 8;
    if (iconSize < 80) {
      iconSize = 80;
    }

    debugPrint(
        "screenWidth: $screenWidth,isSmallWidthScreen: $isSmallWidthScreen,inputMethodPadding: $inputMethodPadding");

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                isSmallWidthScreen ? 0 : (screenWidth / 6),
                0,
                isSmallWidthScreen ? 0 : (screenWidth / 6),
                kIsWeb ? 150 : 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //icon
                Image.network(
                  "https://avatars.githubusercontent.com/u/18367427?v=4",
                  height: iconSize,
                  width: iconSize,
                ),
                // search box
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: inputMethodPadding, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: isSmallWidthScreen ? 10 : 20),
                                  child: TextField(
                                    controller: _textController,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    onSubmitted: (String value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      launch(
                                          "${widget.localSettingConfig.searchEngine?.url}${value}");
                                    },
                                  ),
                                )),
                                if (!isSmallWidthScreen)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: DropdownButton(
                                        items: SearchEngine.values.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name),
                                          );
                                        }).toList(),
                                        value: widget
                                            .localSettingConfig.searchEngine,
                                        onChanged: (e) {
                                          setState(() {
                                            widget.localSettingConfig
                                                    .searchEngine =
                                                e as SearchEngine?;
                                          });
                                          LocalStorage.setItem(
                                              SomeKeys.SETTING_CONFIG,
                                              json.encode(
                                                  widget.localSettingConfig));
                                        },
                                        underline: Container()),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // navigation website urls
                allUrlsBean == null
                    ? loadingBody()
                    : loadedBody(allUrlsBean!, isSmallWidthScreen)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, innerState) {
                  var fontSize = widget.localSettingConfig.fontSize!;

                  return AlertDialog(
                    title: const Text('设置'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("文字大小:$fontSize"),
                        Slider(
                          value: fontSize,
                          onChanged: (value) {
                            innerState(() {});
                            setState(() {
                              widget.localSettingConfig.fontSize = value;
                            });
                            LocalStorage.setItem(SomeKeys.SETTING_CONFIG,
                                json.encode(widget.localSettingConfig));
                          },
                          divisions: 10,
                          min: 10,
                          max: 20,
                          label: "${fontSize}",
                        ),
                      ],
                    ),
                  );
                });
              });
        },
        child: Icon(Icons.settings),
      ),
    );
  }

  loadedBody(AllUrlsBean allUrlsBean, bool isSmallWidthScreen) {
    if (allUrlsBean.results?.isNotEmpty == true) {
      var data = allUrlsBean.results!;
      return Wrap(
        spacing: isSmallWidthScreen ? 5 : 20,
        runSpacing: isSmallWidthScreen ? 2.0 : 20.0,
        alignment: WrapAlignment.center,
        clipBehavior: Clip.hardEdge,
        children: data.map((item) {
          var isSelected = _onHoverItem == item;
          return GestureDetector(
            onTap: () {
              launch(
                item.url!,
              );
            },
            child: MouseRegion(
              onHover: (event) {
                setState(() {
                  _onHoverItem = item;
                });
              },
              child: Chip(
                label: Text(
                  item.name ?? "",
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: widget.localSettingConfig.fontSize ?? 15),
                ),
                backgroundColor: isSelected ? Colors.blue : Colors.grey[100],
              ),
            ),
          );
        }).toList(),
      );
    } else {
      const Center(
        child: Text("Nothing here,try again later"),
      );
    }
  }

  loadingBody() {
    return Center(
      child: Column(
        children: const [
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("loading..."),
          ),
        ],
      ),
    );
  }
}
