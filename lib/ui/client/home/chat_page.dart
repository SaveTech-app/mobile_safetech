import 'package:flutter/material.dart';

class ClientChatPage extends StatefulWidget {
  const ClientChatPage({super.key});

  @override
  State<ClientChatPage> createState() => _ClientChatPageState();
}

class _ClientChatPageState extends State<ClientChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ClientChatPage'),
      ),
    );
  }
}
