import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class HttpHelloRoutePage extends SimplePageRoute {
  HttpHelloRoutePage() : super('网络请求');

  @override
  Widget pageBody(BuildContext context) => _Pages(context);
}

class _Pages extends StatefulWidget {
  BuildContext topContext;

  _Pages(this.topContext);

  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  String response = "";

  HttpClient client = HttpClient()

    /// 全局设置，可以再么个request中覆盖
    // 对应请求头中的keep-alive字段值，为了避免频繁建立连接，httpClient在请求结束后会保持连接一段时间，超过这个阈值后才会关闭连接。
    ..idleTimeout = const Duration(seconds: 10)
    //和服务器建立连接的超时，如果超过这个值则会抛出SocketException异常。默认用系统的时长
    ..connectionTimeout = const Duration(seconds: 10)
    //同一个host，同时允许建立连接的最大数量。 默认是null不限制
    ..maxConnectionsPerHost = 5
    //对应请求头中的Content-Encoding，如果设置为true，则请求头中Content-Encoding的值为当前HttpClient支持的压缩算法列表，目前只有"gzip"
    ..autoUncompress = true
    //对应请求头中的User-Agent字段。这里被后面重写了
    ..userAgent = "test";

  @override
  void deactivate() {
    super.deactivate();
    print("-------------页面被销毁");
    client.close(force: true);
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  realLoad();
                },
                child: const Text('请求一下')),
            ElevatedButton(
                onPressed: () {
                  loadFromNet();
                  // 这里需要用最顶层的context。因为上个页面启动的是HttpHelloRoutePage，所以回退也只能是它，
                  Navigator.pop(widget.topContext, "提前返回");
                },
                child: const Text('模拟关闭页面，没有关闭网络请求')),
            ElevatedButton(
                onPressed: () {
                  client.close();
                },
                child: const Text('关闭Client')),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [Text(response)],
              ),
            )),
          ],
        ),
      );

  loadFromNet() async {
    /// 看下页面退出后，有啥影响
    /// 这里做了个延时认为，点击请求后，立马退出页面
    /// 网络发起请求是，因为页面退出，是没有发起请求，catch了异常：Bad state: Client is closed
    /// 但是setState没有判断页面是否可用
    print("---------准备请求");
    Future.delayed(const Duration(seconds: 2), () {
      print("---------开始请求");
      realLoad();
      print("---------请求完成");
    });
  }

  Future<void> realLoad() async {
    try {
      sleep(const Duration(seconds: 3));

      HttpClientRequest request =
          await client.getUrl(Uri.parse("https://www.baidu.com/"));
      // 使用iso的 agent
      request.headers.add(
        "user-agent",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
      );
      var httpClientResponse = await request.close();
      var string = await httpClientResponse.transform(utf8.decoder).join();
      print("请求是否成功? ${string.isNotEmpty}");
      print(httpClientResponse.headers);
      setState(() {
        response = string;
      });
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          response = "请求失败$e";
        });
      }
    }
  }
}
