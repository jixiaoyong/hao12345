import 'package:flutter/material.dart';

/// @description: 加载中界面
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20
class LoadingBodyWidget extends StatelessWidget {
  const LoadingBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
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
