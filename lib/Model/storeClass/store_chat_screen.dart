import 'package:flutter/material.dart';

class ChatCardPage extends StatelessWidget {
  const ChatCardPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.index,
  });

  final String imageUrl;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint(index.toString());
        Navigator.pushNamed(context, '/storeChat',
            arguments: {'index': index, 'image': imageUrl, 'title': title});
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Container(
                    padding: const EdgeInsets.all(36),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage(
                          imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      const Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        "Next Time we will provide best service with same product",
                        style:
                            TextStyle(color: Color(0xff999B9C), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "5 min",
                      style: TextStyle(color: Color(0xff999B9C), fontSize: 12),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 1),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 90,
            ),
            child: Divider(
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
