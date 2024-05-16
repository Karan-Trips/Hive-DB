import 'package:flutter/material.dart';

class Message {
  final String text;
  final String time;
  bool isSender;

  Message(this.text, this.time, this.isSender);

  String get message => text;
  String get timeFormat => time;
  bool get isMee => isSender;
}

class ChatProvider extends ChangeNotifier {
  Map<String, List<Message>> martMessages = {
    'Walmart': [],
    'Stop&Shop': [],
    'John': [],
    'zeearson': [],
    'Kartain Killer': [],
  };

  List<Message> getMessages(String title) {
    return martMessages[title] ?? [];
  }

  void addMessage(String title, Message message) {
    if (martMessages.containsKey(title)) {
      martMessages[title]!.add(message);
    } else {
      martMessages[title] = [message];
    }
    notifyListeners();
  }

  Map<String, String> chatData = {
    'Walmart':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLn31JMx-S7ze-xddjvxO6J_mIG6N8eP6UAZ3cIklHQA&s',
    'Stop&Shop':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTccuErpam8cUdy6ewe1FvXNAocSnlzl3I8f3auvAHRBQ&s',
    'John':
        'https://www.retail4growth.com/public/uploads/editor/2022-09-01/1662012849.jpg',
    'zeearson':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi5Um5ziEb_VDKoeCULequXKWSIzG3WzfppIhLPypuOw&s',
    'Kartain Killer':
        'https://imageio.forbes.com/specials-images/imageserve/600cad5755375c59ead2614b/Meijer/0x0.jpg?format=jpg&crop=900,673,x0,y158,safe&width=960'
  };
}
