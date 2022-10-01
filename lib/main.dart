

import 'config.dart';
import 'api/stream_api.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'page/channel_list_page.dart';
Future main() async {
  final client = StreamChatClient(Config.apiKey, logLevel: Level.SEVERE);

  await StreamApi.initUser(
    client,
    username: 'Emily',
    urlImage:
        'https://static.javatpoint.com/tutorial/flutter/images/flutter-creating-android-platform-specific-code3.png',
    id: Config.idEmily,
    token: Config.tokenEmily,
  );

  final channel = await StreamApi.watchChannel(
    client,
    type: 'messaging',
    id: 'sample',
  );

  runApp( MyApp(client: client, channel: channel,));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;
  const MyApp({Key? key, required this.client, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'StreamChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stream Chat', client: client, channel: channel,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final StreamChatClient client;
  final Channel channel;
  const MyHomePage({Key? key, required this.title, required this.client, required this.channel}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamChat(client: widget.client ,
      child: StreamChannel(
        channel: widget.channel,
        child: ChannelListPage(
          client: widget.client,
          ),
      )
      ),
    );
  }
}
