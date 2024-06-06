import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../sqflite_db/item_db.dart';
import '../sqflite_db/item_model.dart';
import 'Placeorder.dart';

class Wishlist extends StatefulWidget {
  final Function(bool) callBack;

  const Wishlist({super.key, required this.callBack});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<Item> itemData = [];

  @override
  void initState() {
    _getItemData();
    super.initState();
  }

  Future<void> _getItemData() async {
    itemData = [];
    itemData = await ItemDatabase.instance.readAllItemhData();
    itemData.removeWhere((item) => item.isFavourite == false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Your Wishlist'),
      ),
      body: SingleChildScrollView(
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              overflow: TextOverflow.ellipsis,
                              // maxLines: 1,

                              itemData[index].name,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              itemData[index].piece,
                              style: TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "\u20B9 ${itemData[index].rate}",
                              style: TextStyle(fontSize: 15.w),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    InkWell(
                      onTap: () async {
                        Item item = Item(
                          id: itemData[index].id,
                          name: itemData[index].name,
                          rate: itemData[index].rate,
                          piece: itemData[index].piece,
                          image: itemData[index].image,
                          cartCount: itemData[index].cartCount,
                          totalRate: itemData[index].totalRate,
                          isFavourite: false,
                        );
                        await ItemDatabase.instance.update(item);
                        await widget.callBack(true);
                        await _getItemData();
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1.w,
                              blurRadius: 1.w,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          // Use Center widget to align the Icon in the middle
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.delete_outlined,
                                color: Color(0xFF128C7E)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (itemData[index].cartCount <= 0) {
                          Item item = Item(
                            id: itemData[index].id,
                            name: itemData[index].name,
                            rate: itemData[index].rate,
                            piece: itemData[index].piece,
                            image: itemData[index].image,
                            cartCount: itemData[index].cartCount,
                            totalRate: itemData[index].cartCount,
                            isFavourite: itemData[index].isFavourite,
                          );
                          await ItemDatabase.instance.update(item);
                          await widget.callBack(true);
                          await _getItemData();
                        } else {}
                      },
                      child: GestureDetector(
                        onTap: () async {
                          if (itemData[index].cartCount == 0) {
                            Item item = Item(
                              id: itemData[index].id,
                              name: itemData[index].name,
                              rate: itemData[index].rate,
                              piece: itemData[index].piece,
                              image: itemData[index].image,
                              cartCount: itemData[index].cartCount + 1, // Increment cart count
                              totalRate: itemData[index].totalRate, // Update total rate
                              isFavourite: itemData[index].isFavourite,
                            );
                            await ItemDatabase.instance.update(item);
                            await widget.callBack(true);
                          }

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => placeorder(
                              callBack: (bool value) async {
                                if (value) {
                                  await _getItemData();
                                  await widget.callBack(true);
                                }
                              },
                            ),
                          ));
                        },

                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1.w,
                                blurRadius: 1.w,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            // Use Center widget to align the Icon in the middle
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.add_shopping_cart_outlined,
                                  color: Color(0xFF128C7E)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20.w),
          //         topRight: Radius.circular(20.w)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color(0xFF128C7E).withOpacity(0.4.w),
          //         spreadRadius: 3.w,
          //         blurRadius: 4.w,
          //         offset: Offset(0, 3),
          //       ),
          //     ],
          //   ),
          //   height: 40.w,
          //   width: double.infinity,
          //   child: const Padding(
          //     padding: EdgeInsets.all(10.0),
          //     child: Center(
          //       child: Text(
          //         'Add Your Favorite Items to the Cart',
          //         style: TextStyle(
          //           fontSize: 12,
          //           fontWeight: FontWeight.w300,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => placeorder(
          //               callBack: (bool value) async {
          //                 if (value) {
          //                   await _getItemData();
          //                   await widget.callBack(true);
          //                 }
          //               },
          //             )));
          //   },
          //   child: Container(
          //     width: double.infinity,
          //     height: 60.w,
          //     color: Colors.white,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: const Color(0xFF128C7E),
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //         height: 35.w,
          //         width: 200.w,
          //         child: const Center(
          //           child: Text(
          //             'Add to Cart',
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 16.0,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
