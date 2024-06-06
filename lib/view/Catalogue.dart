import 'package:ewhatsapp/sqflite_db/item_db.dart';
import 'package:ewhatsapp/view/Placeorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sqflite_db/item_model.dart';
import 'Productsview.dart';
import 'Wishlist.dart';

class Catalogue extends StatefulWidget {
  final Function(bool) callBack;

  const Catalogue({super.key, required this.callBack});

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  int _itemCount = 0;
  List<Item> itemData = [];
  int totalCount = 0;

  final CartService _cartService = CartService();

  @override
  void initState() {
    _getItemData();
    super.initState();
  }

  Future<void> _getItemData() async {
    itemData = [];
    totalCount = 0;
    itemData = await ItemDatabase.instance.readAllItemhData();
    for (var item in itemData) {
      totalCount = totalCount + item.cartCount;
    }
    setState(() {});
  }

  Future<void> _loadItemCount() async {
    int count = await _cartService.getItemCount();
    setState(() {
      _itemCount = count;
    });
  }

  void _incrementItemCount() async {
    setState(() {
      _itemCount++;
    });
    await _cartService.saveItemCount(_itemCount);
  }

  void _decrementItemCount() async {
    if (_itemCount > 0) {
      setState(() {
        _itemCount--;
      });
      await _cartService.saveItemCount(_itemCount);
    }
  }

  getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() async {
      // totalCount = await prefs.getInt(key);
    });
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 48.w,
        backgroundColor: Color(0xFF128C7E),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Catalogue',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 45.w,
                height: 45.w,
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
                              width: 33.w,
                              height: 33.w,
                              padding: const EdgeInsets.all(7).w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF128C7E),
                              ),
                              child: const FittedBox(
                                  child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
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
                          width: 16.w,
                          height: 16.w,
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
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 45.w,
                height: 45.w,
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
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              width: 33.w,
                              height: 33.w,
                              padding: const EdgeInsets.all(7).w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF128C7E),
                              ),
                              child: const FittedBox(
                                  child: Icon(
                                Icons.favorite_rounded,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ),
                    // if (totalCount != 0)
                    //   Positioned(
                    //     top: 0,
                    //     left: 0,
                    //     child: Container(
                    //       width: 18.w,
                    //       height: 18.w,
                    //       padding: const EdgeInsets.all(2).w,
                    //       decoration: const BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.green,
                    //       ),
                    //       child: FittedBox(
                    //         child: Text(
                    //           "$totalCount",
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
            // Builder(
            //   builder: (context) => IconButton(
            //       icon: const Icon(
            //         Icons.more_vert_outlined,
            //         color: Colors.white,
            //       ),
            //       onPressed: () {
            //         SnackBar snackdemo = SnackBar(
            //           content: Row(
            //             children: [
            //               Icon(Icons.cancel, color: Colors.white),
            //               SizedBox(width: 10),
            //               Text('The feature is not in use.'),
            //             ],
            //           ),
            //           backgroundColor: Color(0xFF128C7E),
            //           elevation: 10,
            //           behavior: SnackBarBehavior.floating,
            //           margin: EdgeInsets.all(5),
            //           duration: Duration(seconds: 1),
            //           animation: CurvedAnimation(
            //             parent: AnimationController(
            //               duration: Duration(milliseconds: 500),
            //               vsync: ScaffoldMessenger.of(context),
            //             ),
            //             curve: Curves.bounceOut,
            //           ),
            //         );
            //         ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            //       }),
            // ),
          ],
        ),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  itemData.length,
                  (index) => GestureDetector(
                    onTap: () async {
                      // Show the shimmer effect dialog
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (BuildContext context) {
                      //     return Center(
                      //       child: Shimmer.fromColors(
                      //         baseColor: Colors.grey[300]!,
                      //         highlightColor: Colors.grey[100]!,
                      //         child: Container(
                      //           width: double.infinity,
                      //           height: double.infinity,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );

                      // await Future.delayed(Duration(milliseconds: 800));

                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Productsview(
                          itemdata: itemData[index],
                          callBack: (bool value) async {
                            if (value) {
                              await _getItemData();
                              await widget.callBack(true);
                            }
                          },
                        ),
                      ));
                      // Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.transparent,
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
                                height: 90.w,
                                width: 90.w,
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
                              padding: const EdgeInsets.all(12.0),
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
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        itemData[index].piece,
                                        style: TextStyle(fontSize: 9),
                                      ),
                                      Text(
                                        "\u20B9 ${itemData[index].rate}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (itemData[index].isFavourite) {
                                                Item item = Item(
                                                  id: itemData[index].id,
                                                  name: itemData[index].name,
                                                  rate: itemData[index].rate,
                                                  piece: itemData[index].piece,
                                                  image: itemData[index].image,
                                                  cartCount:
                                                      itemData[index].cartCount,
                                                  totalRate:
                                                      itemData[index].totalRate,
                                                  isFavourite: false,
                                                );
                                                await ItemDatabase.instance
                                                    .update(item);
                                                SnackBar snackdemo = SnackBar(
                                                  content: const Row(
                                                    children: [
                                                      Icon(
                                                          Icons.cancel_outlined,
                                                          color: Colors.white),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          'Item Remove from your WishList'),
                                                    ],
                                                  ),
                                                  backgroundColor:
                                                      Color(0xFF128C7E),
                                                  elevation: 10,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(5),
                                                  duration:
                                                      Duration(seconds: 1),
                                                  animation: CurvedAnimation(
                                                    parent: AnimationController(
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      vsync:
                                                          ScaffoldMessenger.of(
                                                              context),
                                                    ),
                                                    curve: Curves.bounceOut,
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackdemo);
                                              } else {
                                                Item item = Item(
                                                  id: itemData[index].id,
                                                  name: itemData[index].name,
                                                  rate: itemData[index].rate,
                                                  piece: itemData[index].piece,
                                                  image: itemData[index].image,
                                                  cartCount:
                                                      itemData[index].cartCount,
                                                  totalRate:
                                                      itemData[index].totalRate,
                                                  isFavourite: true,
                                                );
                                                await ItemDatabase.instance
                                                    .update(item);
                                                SnackBar snackdemo = SnackBar(
                                                  content: const Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .check_circle_outline,
                                                          color: Colors.white),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          'Item Added to your WishList'),
                                                    ],
                                                  ),
                                                  backgroundColor:
                                                      Color(0xFF128C7E),
                                                  elevation: 10,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(5),
                                                  duration:
                                                      Duration(seconds: 1),
                                                  animation: CurvedAnimation(
                                                    parent: AnimationController(
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      vsync:
                                                          ScaffoldMessenger.of(
                                                              context),
                                                    ),
                                                    curve: Curves.bounceOut,
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackdemo);
                                              }
                                              await widget.callBack(true);
                                              await _getItemData();
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: Icon(
                                              Icons.favorite_rounded,
                                              color: itemData[index].isFavourite
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 20.w,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Container(
                                              child: Text(
                                            "(Add to Wishlist)",
                                            style: TextStyle(fontSize: 8),
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),
                          Container(
                            height: 100.w,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                if (itemData[index].cartCount != 0)
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () async {
                                      Item item = Item(
                                        id: itemData[index].id,
                                        name: itemData[index].name,
                                        rate: itemData[index].rate,
                                        piece: itemData[index].piece,
                                        image: itemData[index].image,
                                        cartCount:
                                            itemData[index].cartCount - 1,
                                        totalRate:
                                            (itemData[index].cartCount - 1) *
                                                itemData[index].rate,
                                        isFavourite:
                                            itemData[index].isFavourite,
                                      );
                                      await ItemDatabase.instance.update(item);
                                      await widget.callBack(true);
                                      await _getItemData();
                                    },
                                  ),
                                if (itemData[index].cartCount != 0)
                                  Container(
                                    height: 19.w,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF128C7E),
                                      // Corrected the color code to a valid hex value
                                      borderRadius:
                                          BorderRadius.circular(5.0.w),
                                      // Example of rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.1.w),
                                          spreadRadius: 2.w,
                                          blurRadius: 5.w,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                          itemData[index].cartCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
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
                                      cartCount: itemData[index].cartCount + 1,
                                      totalRate:
                                          (itemData[index].cartCount + 1) *
                                              itemData[index].rate,
                                      isFavourite: itemData[index].isFavourite,
                                    );
                                    await ItemDatabase.instance.update(item);
                                    await widget.callBack(true);
                                    await _getItemData();
                                  },
                                ),
                              ],
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
          if (totalCount != 0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => placeorder(
                            callBack: (bool value) async {
                              if (value) {
                                await _getItemData();
                                await widget.callBack(true);
                              }
                            },
                          )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF128C7E),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  height: 45.w,
                  width: ScreenUtil().screenWidth * 0.9,
                  child: Center(
                    child: Text(
                      'View Cart [ $totalCount ]',
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16.0, // Adjust the font size as needed
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class ItemModel {
  final String Name;
  final num Rate;
  final String Piece;
  final String Image;

  const ItemModel({
    required this.Name,
    required this.Rate,
    required this.Piece,
    required this.Image,
  });
}

class CartService {
  static const String _cartItemCountKey = 'cart_item_count';

  Future<void> saveItemCount(int count) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_cartItemCountKey, count);
  }

  Future<int> getItemCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_cartItemCountKey) ?? 0;
  }
}

class SharedPrefsKeys {
  static const String Beans = "Beans";
  static const String PineApple = "PineApple";
  static const String Tomato = "Tomato";
  static const String Corn = "Corn";
  static const String Carrot = "Carrot";
  static const String Broccoli = "Broccoli";
  static const String Apple = "Apple7";
  static const String Mango = "Mango";
  static const String Pomegranate = "Pomegranate";
  static const String Orange = "Orange";
  static const String LadiesFinger = "LadiesFinger";
  static const String Onion = "Onion";
}

class SharedPrefsHelper {
  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
}