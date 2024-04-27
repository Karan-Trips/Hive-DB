import 'package:flutter/material.dart';

class ManagePaymentsDetails extends StatefulWidget {
  const ManagePaymentsDetails({super.key});

  @override
  State<ManagePaymentsDetails> createState() => _ManagePaymentsDetailsState();
}

class _ManagePaymentsDetailsState extends State<ManagePaymentsDetails> {
  int selectedCard = 0;
  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, String>> cardsdetails = {
      "assets/images/mastercard2x.png": {
        "Anthony Bailey": "•••• •••• •••• 5678"
      },
      "assets/images/mastro2x.png": {"Anthony Jhosph": "•••• •••• •••• 5678"},
      "assets/images/visa@2x.png": {"Stive Mark": "•••• •••• •••• 5678"},
    };
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  spreadRadius: 10,
                  offset: Offset(0, 3))
            ]),
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
              centerTitle: true,
              title: const Text(
                "Mange Payment",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: List.generate(
                  cardsdetails.length,
                  (index) {
                    String cardImage = cardsdetails.keys.elementAt(index);
                    String cardHolderName = cardsdetails[cardImage]!.keys.first;
                    String cardNumber = cardsdetails[cardImage]!.values.first;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCard = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: selectedCard == index
                              ? Border.all(
                                  width: 1, color: const Color(0xffC58808))
                              : Border.all(width: 0, color: Colors.transparent),
                          color: selectedCard == index
                              ? const Color(0xfffdeece)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(7.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.4,
                                    color: const Color.fromRGBO(
                                        196, 197, 197, 0.24),
                                  ),
                                ),
                                child: Image.asset(
                                  cardImage,
                                  width: 60,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cardHolderName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  cardNumber,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.green, width: 2)),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Add New',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
