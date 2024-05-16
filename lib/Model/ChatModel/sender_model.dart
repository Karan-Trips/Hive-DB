// ignore_for_file: must_be_immutable

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_27_03/Provider/chat_provider.dart';

class SenderData extends StatelessWidget {
  final int index;
  final String title;

  SenderData({
    required this.index,
    super.key,
    required this.title,
  });

  String currentDate = DateFormat("dd MMM").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var currentDate = DateFormat("dd MMM").format(DateTime.now());

    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 80, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (index == 0)
              Center(
                child: Text(
                  currentDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ClipPath(
              clipper: LowerNipMessageClipper(sizeOfNip: 3, MessageType.send),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff8BCB01).withOpacity(.2)),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 20, left: 25, right: 25),
                    child: Consumer<ChatProvider>(
                      builder: (context, value, child) {
                        final message = value.getMessages(title)[index];
                        return Text(message.message);
                      },
                    )),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Consumer<ChatProvider>(
                      builder: (context, value, child) => Text(
                        value.getMessages(title)[index].timeFormat.toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(
                        2,
                        (index) => const Padding(
                              padding: EdgeInsets.only(left: 3),
                              child: Icon(
                                size: 5,
                                Icons.circle,
                                color: Colors.green,
                              ),
                            )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
