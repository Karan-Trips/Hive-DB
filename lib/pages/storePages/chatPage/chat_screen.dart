import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Model/ChatModel/recevier_model.dart';
import '../../../Model/ChatModel/sender_model.dart';
import '../../../Provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String imageUrl = args['image'];
    final String title = args['title'];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(title),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(builder: (context, val, child) {
              final chatList = val.getMessages(title);
              debugPrint("length = ${chatList.length}");
              return ListView.builder(
                itemBuilder: (context, index) {
                  final message = chatList[index];
                  debugPrint(" isMee =${message.isMee}");
                  return message.isMee
                      ? SenderData(index: index, title: title)
                      : ReciverData(index: index, title: title);
                },
                itemCount: chatList.length,
                shrinkWrap: true,
              );
            }),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 6,
                    textCapitalization: TextCapitalization.characters,
                    controller: chatEditingController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.add_circle,
                        color: Colors.black,
                        size: 25,
                      ),
                      prefixIcon: const Icon(Icons.settings_voice),
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      hintText: 'Send Your Massage',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Consumer<ChatProvider>(
                  builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      if (chatEditingController.text.isNotEmpty) {
                        final String messageText = chatEditingController.text;

                        value.addMessage(
                          title,
                          Message(
                            messageText,
                            DateFormat("hh:mm").format(DateTime.now()),
                            true,
                          ),
                        );

                        chatEditingController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    onLongPress: () {
                      if (chatEditingController.text.isNotEmpty) {
                        final String messageText = chatEditingController.text;

                        value.addMessage(
                          title,
                          Message(
                            messageText,
                            DateFormat("hh:mm").format(DateTime.now()),
                            false,
                          ),
                        );

                        chatEditingController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const FaIcon(
                        size: 20,
                        FontAwesomeIcons.solidPaperPlane,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
