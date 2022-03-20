import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'net/bean/all_urls_bean.dart';
import 'net/network_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AllUrlsBean? allUrlsBean;

  // for webview
  Results? _onHoverItem;
  var runSpacing = kIsWeb ? 20.0 : 2.0;

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
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, kIsWeb ? 150 : 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //icon
              Image.network(
                "https://avatars.githubusercontent.com/u/18367427?v=4",
                height: 100,
                width: 100,
              ),
              // search box
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 150, vertical: 20),
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
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextField(
                                  controller: _textController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  onSubmitted: (String value) {
                                    if (value.isEmpty) {
                                      return;
                                    }
                                    launch(
                                        "https://www.google.com.hk/search?q=${value}");
                                  },
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  child: Text("Google"),
                                ),
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
              allUrlsBean == null ? loadingBody() : loadedBody(allUrlsBean!)
            ],
          ),
        ),
      ),
    ));
  }

  loadedBody(AllUrlsBean allUrlsBean) {
    if (allUrlsBean.results?.isNotEmpty == true) {
      var data = allUrlsBean.results!;
      return Wrap(
        spacing: 5,
        runSpacing: runSpacing,
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
                      color: isSelected ? Colors.white : Colors.black),
                ),
                backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
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
          Text("loading..."),
        ],
      ),
    );
  }
}
