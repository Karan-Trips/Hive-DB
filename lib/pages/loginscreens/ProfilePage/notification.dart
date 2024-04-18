import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined)),
          centerTitle: true,
          title: const Text(
            "Notification",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15.58,
            );
          },
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: Colors.white,
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const ShapeDecoration(shadows: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 6)
                  ], shape: StadiumBorder(), color: Colors.green),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
              title: const Text(
                "Your order has been successfully placed!",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              subtitle: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Id : ABC1234",
                    style: TextStyle(color: Color(0xff5B5B5B), fontSize: 10),
                  ),
                  Text(
                    "10:30 AM",
                    style: TextStyle(color: Color(0xff5B5B5B), fontSize: 10),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
