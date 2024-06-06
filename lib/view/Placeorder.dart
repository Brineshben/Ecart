import 'package:ewhatsapp/view/Users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sqflite_db/item_db.dart';
import '../sqflite_db/item_model.dart';
import 'Catalogue.dart';

class placeorder extends StatefulWidget {
  final Function(bool) callBack;

  const placeorder({super.key, required this.callBack});

  @override
  State<placeorder> createState() => _placeorderState();
}

class _placeorderState extends State<placeorder> {
  List<Item> itemData = [];
  int totalCount = 0;
  num totalAmount = 0;

  @override
  void initState() {
    _getItemData();
    super.initState();
  }

  Future<void> _getItemData() async {
    totalCount = 0;
    totalAmount = 0;
    itemData = [];
    itemData = await ItemDatabase.instance.readAllItemhData();
    itemData.removeWhere((item) => item.cartCount == 0);
    for (var item in itemData) {
      totalCount = totalCount + item.cartCount;
      totalAmount = totalAmount + (item.cartCount * item.rate);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Container(
                    height: 35.w,
                    width: 100.w,
                    color: Colors.white,
                    child: Text(
                      'Total items:$totalCount',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Catalogue(
                          callBack: (bool value) async {
                            await widget.callBack(true);
                          },
                        ),
                      ),
                      (Route<dynamic> route) => true,
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Catalogue(
                          callBack: (bool value) async {
                            await _getItemData();
                            await widget.callBack(true);
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 35.w,
                    width: 100.w,
                    child: Center(
                      // Center widget to center the text
                      child: Text(
                        'Add more',
                        style: TextStyle(
                          color: Color(0xFF128C7E), // Text color
                          fontSize: 16.0, // Adjust the font size as needed
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8).w,
                child: Column(
                  children: List.generate(
                    itemData.length,
                    (index) => GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF128C7E).withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 70.w,
                                width: 70.w,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      itemData[index].image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                )),
                          ),
                          // Image.asset(
                          //   "Assets/images/images.jpeg",
                          //   width: 100.w,
                          //
                          // ),
                          Container(
                            height: 100.w,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        itemData[index].name,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        height: 35.w,
                                        width: 130.w,
                                        color: Colors.white,
                                        child: Row(
                                          children: <Widget>[
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () async {
                                                Item item = Item(
                                                  id: itemData[index].id,
                                                  name: itemData[index].name,
                                                  rate: itemData[index].rate,
                                                  piece: itemData[index].piece,
                                                  image: itemData[index].image,
                                                  cartCount: itemData[index]
                                                          .cartCount -
                                                      1,
                                                  totalRate: (itemData[index]
                                                              .cartCount -
                                                          1) *
                                                      itemData[index].rate,
                                                  isFavourite: itemData[index]
                                                      .isFavourite,
                                                );
                                                await ItemDatabase.instance
                                                    .update(item);
                                                await widget.callBack(true);
                                                await _getItemData();
                                              },
                                            ),
                                            Container(
                                              height: 25.w,
                                              width: 25.w,
                                              decoration: BoxDecoration(
                                                color: Colors.black12,
                                                // Corrected the color code to a valid hex value
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                // Example of rounded corners
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  itemData[index]
                                                      .cartCount
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        16, // Added a font size for better readability
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () async {
                                                Item item = Item(
                                                  id: itemData[index].id,
                                                  name: itemData[index].name,
                                                  rate: itemData[index].rate,
                                                  piece: itemData[index].piece,
                                                  image: itemData[index].image,
                                                  cartCount: itemData[index]
                                                          .cartCount +
                                                      1,
                                                  totalRate: (itemData[index]
                                                              .cartCount +
                                                          1) *
                                                      itemData[index].rate,
                                                  isFavourite: itemData[index]
                                                      .isFavourite,
                                                );
                                                await ItemDatabase.instance
                                                    .update(item);
                                                await widget.callBack(true);
                                                await _getItemData();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),

                          Container(
                            height: 90.w,
                            width: 90.w,
                            color: Colors.white,
                            child: Center(
                              // Center widget to center the text
                              child: Text(
                                "\u20B9 ${itemData[index].totalRate.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Color(0xFF128C7E), // Text color
                                  fontSize:
                                      16.0, // Adjust the font size as needed
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF128C7E).withOpacity(0.4.w),
                  spreadRadius: 3.w,
                  blurRadius: 4.w,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            width: double.infinity,
            height: 45.w,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 35.w,
                    width: 130.w,
                    color: Colors.white,
                    child: Text(
                      'Sub Total:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 35.w,
                      child: Text(
                        "\u20B9 $totalAmount",
                        style: TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 16.0, // Adjust the font size as needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50.w,
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'The Bussiness will confirm Your Order and Total Price ,Including any fees tax and discounts ',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (itemData.isNotEmpty) {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setBool('send', true);
              }
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const users()),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              width: double.infinity,
              height: 60.w,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1.w),
                        spreadRadius: 2.w,
                        blurRadius: 2.w,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: const Color(0xFF128C7E),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  height: 35.w,
                  width: 250.w,
                  child: const Center(
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
