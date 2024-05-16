import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_27_03/Provider/chat_provider.dart';

class ReciverData extends StatelessWidget {
  final int index;
  final String title;

  const ReciverData({
    required this.index,
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 80, left: 20, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: LowerNipMessageClipper(sizeOfNip: 1, MessageType.receive),
            child: Container(
              decoration: const BoxDecoration(color: Color(0xffDCDCDC)),
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, left: 25, right: 25),
              child: Consumer<ChatProvider>(builder: (context, value, child) {
                final message = value.getMessages(title)[index];
                return Text(message.message);
              }),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: Consumer<ChatProvider>(
                  builder: (context, value, child) => Text(
                      value.getMessages(title)[index].timeFormat.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
