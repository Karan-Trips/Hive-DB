import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_27_03/Provider/chat_provider.dart';

import '../../../Model/storeClass/store_chat_screen.dart';

class StoreChat extends StatefulWidget {
  const StoreChat({super.key});

  @override
  State<StoreChat> createState() => _StoreChatState();
}

class _StoreChatState extends State<StoreChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Chat'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ChatProvider>(builder: (context, value, child) {
              final List<MapEntry<String, String>> entries =
                  value.chatData.entries.toList();
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final String title = entry.key;
                    final String imageUrl = entry.value;
                    return ChatCardPage(
                        imageUrl: imageUrl, title: title, index: index);
                  },
                  itemCount: 5);
            }),
          ],
        ),
      ),
    );
  }
}
