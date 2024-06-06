import 'package:ewhatsapp/sqflite_db/item_db.dart';
import 'package:ewhatsapp/view/Placeorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sqflite_db/item_model.dart';
import 'Catalogue.dart';
import 'Wishlist.dart';

class GlobalContext {
  static late BuildContext context;
}

class User2 extends StatelessWidget {
  const User2({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalContext.context = context;
    return Scaffold(
      body: users(),
    );
  }
}

class users extends StatefulWidget {
  final Function(bool)? callBack;

  const users({super.key, this.callBack});

  @override
  State<users> createState() => _usersState();
}

class _usersState extends State<users> {
  final TextEditingController _messageController = TextEditingController();
  final List<Messagemodel> _messages = [];
  List<Item> itemData = [];
  int totalCount = 0;
  int wishCount = 0;
  num total = 0;
  List<Item> items = [
    const Item(
      name: "Beans",
      rate: 50.0,
      piece: "50 Nos per kg",
      image: "https://m.media-amazon.com/images/I/41gKttKlFDL.jpg",
      cartCount: 0,
      totalRate: 50.0,
      isFavourite: false,
    ),
    const Item(
      name: "PineApple",
      rate: 20.6,
      piece: "1 Nos per kg",
      image:
          "https://www.euroharvest.co.uk/wp-content/uploads/2020/09/pineapple.jpg",
      cartCount: 0,
      totalRate: 20.6,
      isFavourite: false,
    ),
    const Item(
      name: "Tomato",
      rate: 20,
      piece: "15 Nos per kg",
      image:
          "https://5.imimg.com/data5/VY/LS/MY-3269076/fresh-natural-tomato-500x500.jpg",
      cartCount: 0,
      totalRate: 20,
      isFavourite: false,
    ),
    const Item(
      name: "Corn",
      rate: 130.5,
      piece: "1 Nos per kg",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOhR6MPb-QwRaDkbRNOAAmTRo4ci3EY-qy2GKz7QNsqiEpXxQeyPkOG1HgKz8lsx_GK_c&usqp=CAU",
      cartCount: 0,
      totalRate: 130.5,
      isFavourite: false,
    ),
    const Item(
      name: "Carrot",
      rate: 25,
      piece: "8 Nos per kg",
      image:
          "https://static.vecteezy.com/system/resources/thumbnails/027/216/346/small/red-carrot-red-carrot-transparent-background-ai-generated-free-png.png",
      cartCount: 0,
      totalRate: 25,
      isFavourite: false,
    ),
    const Item(
      name: "Broccoli",
      rate: 20,
      piece: "8 Nos per kg",
      image:
          "https://themasalamill.com/cdn/shop/products/AdobeStock_250290014.jpg?v=1641676270",
      cartCount: 0,
      totalRate: 20,
      isFavourite: false,
    ),
    const Item(
      name: "Apple",
      rate: 120.0,
      piece: "8 Nos per kg",
      image:
          "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?cs=srgb&dl=pexels-mali-102104.jpg&fm=jpg",
      cartCount: 0,
      totalRate: 120.0,
      isFavourite: false,
    ),
    const Item(
      name: "Mango",
      rate: 100.0,
      piece: "5 Nos per kg",
      image:
          "https://www.clearskin.in/wp-content/uploads/2022/05/Fruits-for-a-Glowing-Skin-in-Summer-Mango.jpg",
      cartCount: 0,
      totalRate: 100.0,
      isFavourite: false,
    ),
    const Item(
      name: "Pomegranate",
      rate: 200.0,
      piece: "3 Nos per kg",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfM-jd8-AKs0t050_HBJgpqI1hexHhnhS2FlzqPYsFXL7cZMuiAht6Ll1c09qNVTjqtr8&usqp=CAU",
      cartCount: 0,
      totalRate: 200.0,
      isFavourite: false,
    ),
    const Item(
      name: "Orange",
      rate: 250.0,
      piece: "8 Nos per kg",
      image:
          "https://static.vecteezy.com/system/resources/previews/027/143/688/original/fresh-single-orange-fruit-isolated-on-transparent-background-png.png",
      cartCount: 0,
      totalRate: 250.0,
      isFavourite: false,
    ),
    const Item(
      name: "Ladies Finger",
      rate: 67.0,
      piece: "9 Nos per kg",
      image:
          "https://t3.ftcdn.net/jpg/00/93/87/58/360_F_93875874_u9pFhj8A6MNFchnUgNTAAAWnmIA4F4Y0.jpg",
      cartCount: 0,
      totalRate: 67.0,
      isFavourite: false,
    ),
    const Item(
      name: "Onion",
      rate: 20,
      piece: "10 Nos per kg",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDhd69KQMVV2KxczxzEf7tEEF0kl-Cn175ow&s",
      cartCount: 0,
      totalRate: 20,
      isFavourite: false,
    ),
    const Item(
      name: "Apple",
      rate: 20,
      piece: "8 Nos per kg",
      image:
          "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?cs=srgb&dl=pexels-mali-102104.jpg&fm=jpg",
      cartCount: 0,
      totalRate: 20,
      isFavourite: false,
    ),
  ];

  void _onButtonClicked() {
    if (_messages.last.isbot) {}
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await _setDbItems();
    await _getItemData();
    await _sendFirstMsg();
  }

  Future<void> clearItems() async {
    List<Item> allCartItems = await ItemDatabase.instance.readAllItemhData();
    allCartItems.removeWhere((item) => item.cartCount == 0);
    for (var item in allCartItems) {
      Item data = Item(
          id: item.id,
          name: item.name,
          rate: item.rate,
          image: item.image,
          cartCount: 0,
          piece: item.piece,
          totalRate: item.totalRate,
          isFavourite: item.isFavourite);
      await ItemDatabase.instance.update(data);
    }
    await _getItemData();
  }

  Future<void> _setDbItems() async {
    List<Item> itemsData = await ItemDatabase.instance.readAllItemhData();
    if (itemsData.isEmpty) {
      for (var item in items) {
        Item data = Item(
            id: item.id,
            name: item.name,
            rate: item.rate,
            image: item.image,
            cartCount: item.cartCount,
            piece: item.piece,
            totalRate: item.totalRate,
            isFavourite: item.isFavourite);
        await ItemDatabase.instance.create(data);
      }
    }
  }

  Future<void> _getItemData() async {
    totalCount = 0;
    itemData = await ItemDatabase.instance.readAllItemhData();
    for (var item in itemData) {
      totalCount = totalCount + item.cartCount;
    }
    setState(() {});
  }

  Future<void> _getwishcount() async {
    wishCount = 0;
    itemData = await ItemDatabase.instance.readAllItemhData();

    for (var item in itemData) {
      if (item.isFavourite == true) {
        wishCount = wishCount + 1;
      }
    }
    setState(() {});
  }

  Future<void> _sendFirstMsg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSent = prefs.getBool('send');
    if (isSent != null) {
      itemData.removeWhere((item) => item.cartCount == 0);
      total = 0;
      for (var item in itemData) {
        total += item.totalRate;
      }
      _messages.insert(
          0,
          Messagemodel(
              text: "",
              isTap: false,
              message: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(
                            "Assets/images/istockphoto-1206806317-612x612.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius value as needed
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: 150,
                        child: Text(
                          "${itemData.length} items\n\u20B9 $total (estimated total)",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
              isbot: false,
              time: DateFormat("HH:mm").format(DateTime.now()),
              action: []));
      _messages.insert(
          0,
          Messagemodel(
              text: "",
              message: _getBotResponse(""),
              isTap: false,
              isbot: true,
              time: DateFormat("HH:mm").format(DateTime.now()),
              action: actionList(
                "",
              )));
      await prefs.remove('send');
    }
  }

  newState() {
    for (int i = 0; i < _messages.length; i++) {
      if (i == 0) {
      } else {
        List<Widget> widgetReturn(text) {
          if (text == 'Select & Continue') {
            return [
              SizedBox(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF7F1FD), // Background color
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      // _sendMessage("Yes");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffF7F1FD),
                      ), // Background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Circular radius
                        ),
                      ),
                    ),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Color(0xFF128C7E), // Text color
                        fontSize: 16.0, // Font size
                        // You can add more text styles here if needed
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.w),
              SizedBox(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                child: Stack(
                  children: [
                    Container(
                      width: 210.0.w, // Specify desired width
                      height: 40.0.w, // Specify desired height
                      decoration: BoxDecoration(
                        color: Color(0xffF7F1FD), // Background color
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Shadow color
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // _sendMessage("Change");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xffF7F1FD),
                          ), // Background color
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Circular radius
                            ),
                          ),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: Color(0xFF128C7E), // Text color
                            fontSize: 16.0, // Font size
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 210.0.w, // Specify desired width
                    //   height: 40.0.w, // Specify desired height
                    //   decoration: BoxDecoration(
                    //     color: Color(0xffF7F1FD),
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ];
          } else if (text == 'Yes') {
            return [
              SizedBox(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF7F1FD), // Background color
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      // _sendMessage("Cash On delivery");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffF7F1FD)), // Background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Circular radius
                        ),
                      ),
                    ),
                    child: Text(
                      "Cash On delivery",
                      style: TextStyle(
                        color: Color(0xFF128C7E), // Text color
                        fontSize: 16.0, // Font size
                        // You can add more text styles here if needed
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              SizedBox(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF7F1FD), // Background color
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      // _sendMessage("UPI");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffF7F1FD)), // Background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Circular radius
                        ),
                      ),
                    ),
                    child: Text(
                      "UPI",
                      style: TextStyle(
                        color: Color(0xFF128C7E), // Text color
                        fontSize: 16.0, // Font size
                        // You can add more text styles here if needed
                      ),
                    ),
                  ),
                ),
              ),
            ];
          } else if (text == 'UPI') {
            return [
              SizedBox(
                width: 210.0.w, // Specify desired width
                height: 40.0.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF7F1FD), // Background color
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      // _sendMessage("Pay Now");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffF7F1FD)), // Background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Circular radius
                        ),
                      ),
                    ),
                    child: const Text(
                      "Pay Now",
                      style: TextStyle(
                        color: Color(0xFF128C7E),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          } else if (text == 'Pay Now') {
            return [];
          } else if (text == 'Cash On delivery') {
            return [];
          } else {
            return [
              SizedBox(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                child: Stack(
                  children: [
                    Container(
                      width: 210.0.w, // Specify desired width
                      height: 40.0.w, // Specify desired height
                      decoration: BoxDecoration(
                        color: Color(0xffF7F1FD), // Background color
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Shadow color
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // _sendMessage("Change");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffF7F1FD)), // Background color
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Circular radius
                            ),
                          ),
                        ),
                        child: Text(
                          "Change",
                          style: TextStyle(
                            color: Color(0xFF128C7E), // Text color
                            fontSize: 16.0, // Font size
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 210.0.w, // Specify desired width
                    //   height: 40.0.w, // Specify desired height
                    //   decoration: BoxDecoration(
                    //     color: Color(0xffF7F1FD),
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              SizedBox(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5), // Background color
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      // _sendMessage("Select & Continue");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffF7F1FD)), // Background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Select & Continue",
                      style: TextStyle(
                        color: Color(0xFF128C7E), // Text color
                        fontSize: 16.0, // Font size
                        // You can add more text styles here if needed
                      ),
                    ),
                  ),
                ),
              ),
            ];
          }
        }

        _messages[i].action = widgetReturn(_messages[i].text);
      }
    }
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.insert(
          0,
          Messagemodel(
              text: text,
              isTap: false,
              message: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              isbot: false,
              time: DateFormat("HH:mm").format(DateTime.now()),
              action: [IconButton(onPressed: () {}, icon: Icon(Icons.add))]));
      _messages.insert(
          0,
          Messagemodel(
              text: text,
              isTap: false,
              message: _getBotResponse(text),
              isbot: true,
              time: DateFormat("HH:mm").format(DateTime.now()),
              action: actionList(text)));
    });
    _messageController.clear();

    setState(() {
      newState();
    });
  }

  Widget _getBotResponse(String text) {
    if (text == 'Change') {
      return Container(
        width: 190.w,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DO YOU WANT QUICK DELIVERY?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Normal Deliver in 1Hr',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Quick deliver in 30 minutes',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              '(Additional Cost of 10 is applicable)',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else if (text == 'Select & Continue') {
      return Container(
        width: 190.w,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do You Want Quick Delivery?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '> Normal Delivery in 1hr',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              '> Fast Delivery in 30mins\n\n[Additional cost Rs10 ]',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else if (text == 'Yes') {
      return Container(
        width: 190.w,
        child: const Text(
          'CHOOSE PAYMENT METHOD',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (text == 'Cash On delivery') {
      clearItems();
      return Container(
        width: 190.w,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR ORDER HAS BEEN PLACED',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'THANK YOU!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else if (text == 'UPI') {
      return Container(
        width: 190.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Summary',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'You are ordering',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'WhatsApp Order',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Total Amount: \u20B9 $total',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else if (text == 'Pay Now') {
      clearItems();
      return Container(
        width: 190.w,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR ORDER HAS BEEN PLACED',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'THANK YOU!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 190.w,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DELIVERY ADDRESS:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'BB Complex, Neelankarai',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'First Street',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Chennai,600028',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 88.w,
        backgroundColor: const Color(0xFF128C7E),
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            const CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200'),
            ),
          ],
        ),
        title: const Text(
          'E-Cart',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_checkout_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Catalogue(
                        callBack: (value) async {
                          if (value) {
                            await _getItemData();
                          }
                        },
                      )));
            },
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                SnackBar snackdemo = SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.white),
                      SizedBox(width: 10),
                      Text('The feature is not in use.'),
                    ],
                  ),
                  backgroundColor: Color(0xFF128C7E),
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(5),
                  duration: Duration(seconds: 1),
                  animation: CurvedAnimation(
                    parent: AnimationController(
                      duration: Duration(milliseconds: 500),
                      vsync: ScaffoldMessenger.of(context),
                    ),
                    curve: Curves.bounceOut,
                  ),
                );
                ScaffoldMessenger.of(GlobalContext.context)
                    .showSnackBar(snackdemo);
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("Assets/images/jt4AoG.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.only(bottom: 30).w,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: _messages[index].isbot == true
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Container(
                        // constraints: BoxConstraints(
                        //   maxWidth: 200.w,
                        // ),
                        child: buildChatBubble(
                          message: _messages[index],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              width: ScreenUtil().screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            // width: ScreenUtil().screenWidth * 0.80,
                            height: 50.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20).w,
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // EmojiPicker(
                                //   onEmojiSelected: (category, emoji) {
                                //     // _controller.text += emoji.emoji;
                                //   },
                                //   config: Config(
                                //     columns: 7,
                                //     emojiSizeMax: 32.0,
                                //     verticalSpacing: 0,
                                //     horizontalSpacing: 0,
                                //     gridPadding: EdgeInsets.zero,
                                //     initCategory: Category.RECENT,
                                //     bgColor: const Color(0xFFF2F2F2),
                                //     indicatorColor: Colors.blue,
                                //     iconColor: Colors.grey,
                                //     iconColorSelected: Colors.blue,
                                //     backspaceColor: Colors.blue,
                                //     skinToneDialogBgColor: Colors.white,
                                //     skinToneIndicatorColor: Colors.grey,
                                //     enableSkinTones: true,
                                //     recentTabBehavior: RecentTabBehavior.RECENT,
                                //     recentsLimit: 28,
                                //     tabIndicatorAnimDuration: kTabScrollDuration,
                                //     categoryIcons: const CategoryIcons(),
                                //     buttonMode: ButtonMode.MATERIAL,
                                //   ),
                                // ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.emoji_emotions,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    SnackBar snackdemo = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.cancel,
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('The feature is not in use.'),
                                        ],
                                      ),
                                      backgroundColor: Color(0xFF128C7E),
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                      duration: Duration(seconds: 1),
                                      animation: CurvedAnimation(
                                        parent: AnimationController(
                                          duration: Duration(milliseconds: 500),
                                          vsync: ScaffoldMessenger.of(context),
                                        ),
                                        curve: Curves.bounceOut,
                                      ),
                                    );
                                    ScaffoldMessenger.of(GlobalContext.context)
                                        .showSnackBar(snackdemo);
                                  },
                                ),

                                Expanded(
                                  child: TextField(
                                    controller: _messageController,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      hintText: 'Message',
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 20.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide
                                            .none, // Removes the border
                                      ),
                                    ),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            20.0), // Color and size of the input text
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.attach_file,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    SnackBar snackdemo = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.cancel,
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('The feature is not in use.'),
                                        ],
                                      ),
                                      backgroundColor: Color(0xFF128C7E),
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                      duration: Duration(seconds: 1),
                                      animation: CurvedAnimation(
                                        parent: AnimationController(
                                          duration: Duration(milliseconds: 500),
                                          vsync: ScaffoldMessenger.of(context),
                                        ),
                                        curve: Curves.bounceOut,
                                      ),
                                    );
                                    ScaffoldMessenger.of(GlobalContext.context)
                                        .showSnackBar(snackdemo);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    SnackBar snackdemo = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.cancel,
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('The feature is not in use.'),
                                        ],
                                      ),
                                      backgroundColor: Color(0xFF128C7E),
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                      duration: Duration(seconds: 1),
                                      animation: CurvedAnimation(
                                        parent: AnimationController(
                                          duration: Duration(milliseconds: 500),
                                          vsync: ScaffoldMessenger.of(context),
                                        ),
                                        curve: Curves.bounceOut,
                                      ),
                                    );
                                    ScaffoldMessenger.of(GlobalContext.context)
                                        .showSnackBar(snackdemo);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100).w),
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF128C7E),
                            ),
                            child: _messageController.text.isNotEmpty
                                ? (IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (_messageController.text.isNotEmpty) {
                                        // _sendMessage(_messageController.text);
                                      }
                                    },
                                  ))
                                : IconButton(
                                    icon: const Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      SnackBar snackdemo = SnackBar(
                                        content: Row(
                                          children: [
                                            Icon(Icons.cancel,
                                                color: Colors.white),
                                            SizedBox(width: 10),
                                            Text('The feature is not in use.'),
                                          ],
                                        ),
                                        backgroundColor: Color(0xFF128C7E),
                                        elevation: 10,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(5),
                                        duration: Duration(seconds: 1),
                                        animation: CurvedAnimation(
                                          parent: AnimationController(
                                            duration:
                                                Duration(milliseconds: 500),
                                            vsync:
                                                ScaffoldMessenger.of(context),
                                          ),
                                          curve: Curves.bounceOut,
                                        ),
                                      );
                                      ScaffoldMessenger.of(
                                              GlobalContext.context)
                                          .showSnackBar(snackdemo);
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100).w),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Wishlist(
                                callBack: (bool value) {
                                  _getItemData();
                                },
                              ),
                            ),
                          );
                        },
                        // onTap: () {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => Wishlist(
                        //             callBack: (bool value) async {
                        //               if (value) {
                        //                 await _getItemData();
                        //                 await widget.callBack!(true);
                        //               }
                        //             },
                        //           )));
                        // },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          width: 38.w,
                          height: 38.w,
                          padding: const EdgeInsets.all(7).w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const FittedBox(
                              child: Icon(
                            Icons.favorite_rounded,
                            color: Colors.grey,
                          )),
                        ),
                      ),
                    ),
                  ),
                  if (wishCount != 0)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 18.w,
                        height: 18.w,
                        padding: const EdgeInsets.all(2).w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: FittedBox(
                          child: Text(
                            "$wishCount",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: 50.w,
              height: 50.w,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100).w),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => placeorder(
                                callBack: (bool value) async {
                                  if (value) {
                                    await _getItemData();
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          width: 38.w,
                          height: 38.w,
                          padding: const EdgeInsets.all(7).w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const FittedBox(
                              child: Icon(
                            Icons.shopping_cart,
                            color: Colors.grey,
                          )),
                        ),
                      ),
                    ),
                  ),
                  if (totalCount != 0)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 18.w,
                        height: 18.w,
                        padding: const EdgeInsets.all(2).w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: FittedBox(
                          child: Text(
                            "$totalCount",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChatBubble({required Messagemodel message}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: message.isbot
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                FittedBox(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          // Shadow color
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: message.isbot ? Colors.white : Colors.green[50],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(message.isbot ? 0 : 10),
                        topRight: Radius.circular(message.isbot ? 10 : 0),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        message.message,
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              message.time,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.w),
                if (message.isbot) ...message.action,
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> actionList(String text) {
    if (text == 'Select & Continue') {
      return [
        SizedBox(
          width: 210.0.w, // Specify desired width
          height: 40.0.w, // Specify desired height
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                _sendMessage("Yes");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Circular radius
                  ),
                ),
              ),
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Color(0xFF128C7E), // Text color
                  fontSize: 16.0, // Font size
                  // You can add more text styles here if needed
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.w),
        SizedBox(
          width: 210.0.w, // Specify desired width
          height: 40.0.w, // Specify desired height
          child: Stack(
            children: [
              Container(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    // _sendMessage("Change");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffF7F1FD)), // Background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Circular radius
                      ),
                    ),
                  ),
                  child: Text(
                    "No",
                    style: TextStyle(
                      color: Color(0xFF128C7E), // Text color
                      fontSize: 16.0, // Font size
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: 210.0.w, // Specify desired width
              //   height: 40.0.w, // Specify desired height
              //   decoration: BoxDecoration(
              //     color: Colors.grey.withOpacity(0.5),
              //     borderRadius: BorderRadius.circular(20.0),
              //   ),
              // ),
            ],
          ),
        ),
      ];
    } else if (text == 'Yes') {
      return [
        SizedBox(
          width: 210.0.w, // Specify desired width
          height: 40.0.w, // Specify desired height
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                _sendMessage("Cash On delivery");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Circular radius
                  ),
                ),
              ),
              child: Text(
                "Cash On delivery",
                style: TextStyle(
                  color: Color(0xFF128C7E), // Text color
                  fontSize: 16.0, // Font size
                  // You can add more text styles here if needed
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.w,
        ),
        SizedBox(
          width: 210.0.w, // Specify desired width
          height: 40.0.w, // Specify desired height
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                _sendMessage("UPI");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Circular radius
                  ),
                ),
              ),
              child: Text(
                "UPI",
                style: TextStyle(
                  color: Color(0xFF128C7E), // Text color
                  fontSize: 16.0, // Font size
                  // You can add more text styles here if needed
                ),
              ),
            ),
          ),
        ),
      ];
    } else if (text == 'UPI') {
      return [
        SizedBox(
          width: 210.0.w, // Specify desired width
          height: 40.0.w,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                _sendMessage("Pay Now");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Circular radius
                  ),
                ),
              ),
              child: const Text(
                "Pay Now",
                style: TextStyle(
                  color: Color(0xFF128C7E),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ];
    } else if (text == 'Pay Now') {
      return [];
    } else if (text == 'Cash On delivery') {
      return [];
    } else {
      return [
        SizedBox(
          width: 210.0.w, // Specify desired width
          height: 40.0.w, // Specify desired height
          child: Stack(
            children: [
              Container(
                width: 210.0.w, // Specify desired width
                height: 40.0.w, // Specify desired height
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    // _sendMessage("Change");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffF7F1FD)), // Background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Circular radius
                      ),
                    ),
                  ),
                  child: Text(
                    "Change",
                    style: TextStyle(
                      color: Color(0xFF128C7E), // Text color
                      fontSize: 16.0, // Font size
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: 210.0.w, // Specify desired width
              //   height: 40.0.w, // Specify desired height
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(20.0),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 5.w,
        ),
        SizedBox(
          width: 210.0.w, // Specify desired width
          height: 40.0.w, // Specify desired height
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                _sendMessage("Select & Continue");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                "Select & Continue",
                style: TextStyle(
                  color: Color(0xFF128C7E), // Text color
                  fontSize: 16.0, // Font size
                  // You can add more text styles here if needed
                ),
              ),
            ),
          ),
        ),
      ];
    }
  }
}

class Messagemodel {
  Widget message;
  bool isbot;
  String time;
  List<Widget> action;
  bool isTap;
  String text;
  Messagemodel(
      {required this.message,
      required this.isbot,
      required this.time,
      required this.isTap,
      required this.action,
      required this.text});
}
