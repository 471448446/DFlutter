import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketHelloRoutePage extends SimplePageRoute {
  WebSocketHelloRoutePage({super.key}) : super('Websocket');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WebSocketHelloState();
}

class _WebSocketHelloState extends State<_Pages> {
  final TextEditingController _controller = TextEditingController();
  late IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    //创建websocket连接
    //https://www.piesocket.com/websocket-tester
    // var url = 'ws://echo.websocket.org';
    var url =
        'wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV';
    channel = IOWebSocketChannel.connect(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                //网络不通会走到这
                if (snapshot.hasError) {
                  _text = "网络不通...${snapshot.error}";
                } else if (snapshot.hasData) {
                  _text = "echo: ${snapshot.data}";
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
