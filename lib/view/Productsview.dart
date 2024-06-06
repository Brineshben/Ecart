
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../sqflite_db/item_db.dart';
import '../sqflite_db/item_model.dart';
import 'Placeorder.dart';

class Productsview extends StatefulWidget {
  final Item itemdata;
  final Function(bool) callBack;
  const Productsview({Key? key, required this.itemdata, required this.callBack})
      : super(key: key);

  @override
  State<Productsview> createState() => _ProductsviewState();
}

class _ProductsviewState extends State<Productsview> {
  int _cartCount = 0;
  int totalCount = 0;
  Item itemDetails = const Item(
      name: "",
      rate: 0,
      piece: "",
      image: "",
      totalRate: 0,
      cartCount: 0,
      isFavourite: false,
  );

  @override
  void initState() {
    _getCartCount();
    super.initState();
  }

  Future<void> _getCartCount() async {
    totalCount = 0;
    Item? data = await ItemDatabase.instance.readData(widget.itemdata.id!);
    if(data != null) {
      itemDetails = data;
    }
    if (itemDetails != null) {
      _cartCount = itemDetails.cartCount;
    }
    List<Item> itemData = await ItemDatabase.instance.readAllItemhData();
    for (var item in itemData) {
      totalCount = totalCount + item.cartCount;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
     // _toggleFavourite();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.black38,
                Colors.black12,
                Colors.white10,
              ],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
             Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => placeorder(
                    callBack: (bool value) async {
                      await widget.callBack(true);
                      await _getCartCount();
                    },
                  )));
            },
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          if (totalCount != 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  '$totalCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              final snackBar = SnackBar(
                content: Row(
                  children: const [
                    Icon(Icons.cancel, color: Colors.white),
                    SizedBox(width: 10),
                    Text('The feature is not in use.'),
                  ],
                ),
                backgroundColor: const Color(0xFF128C7E),
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(5),
                duration: const Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
      body: SafeArea(
        child:
        //     Center(
        //   child: Container(
        //     width: double.infinity,
        //     height: double.infinity,
        //     color: Colors.white,
        //   ),
        // )
             Column(
          children: [
            _buildImageSection(),
            _buildDetailsSection(),
            _buildMessageButton(),
            const Spacer(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 300.0.w,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.w),
            bottomRight: Radius.circular(20.w)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF128C7E).withOpacity(0.2.w),
            spreadRadius: 2.w,
            blurRadius: 3.w,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.w),
            bottomRight: Radius.circular(20.w)),
        child: Image.network(
          itemDetails.image,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 100.w,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemDetails.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await _toggleFavourite();
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Icon(
                        Icons.favorite_rounded,
                        color: itemDetails.isFavourite ? Colors.red : Colors.grey,
                        size: 25.w,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "\u20B9 ${itemDetails.rate}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              itemDetails.piece,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          final snackBar = SnackBar(
            content: Row(
              children: const [
                Icon(Icons.cancel, color: Colors.white),
                SizedBox(width: 10),
                Text('The feature is not in use.'),
              ],
            ),
            backgroundColor: const Color(0xFF128C7E),
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(5),
            duration: const Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          height: 40.w,
          child: const Center(
            child: Text(
              'Message Business',
              style: TextStyle(
                color: Color(0xFF128C7E),
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      width: double.infinity,
      height: 60.w,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCartButton(),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => placeorder(
                      callBack: (bool value) async {
                        await widget.callBack(true);
                        await _getCartCount();
                      },
                    )));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF128C7E),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: 35.w,
                width: 200.w,
                child: Center(
                  child: Text(
                    'View Cart ($totalCount)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartButton() {
    return Container(
      height: 35.w,
      width: 130.w,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _cartCount > 0
                ? () async {
              await _updateCartCount(_cartCount - 1);
            }
                : null,
          ),
          Container(
            height: 25.w,
            width: 25.w,
            decoration: BoxDecoration(
              color: const Color(0xFF128C7E),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: FittedBox(
              child: Text(
                _cartCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await _updateCartCount(_cartCount + 1);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFavourite() async {
    Item updatedItem = itemDetails.copy(
      isFavourite: !itemDetails.isFavourite,
    );
    await ItemDatabase.instance.update(updatedItem);
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            itemDetails.isFavourite ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            itemDetails.isFavourite ? 'Item Removed from your Wishlist' : 'Item Added to your Wishlist',
          ),
        ],
      ),
      backgroundColor: const Color(0xFF128C7E),
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    await widget.callBack(true);
    await _getCartCount();
  }

  Future<void> _updateCartCount(int newCount) async {
    Item updatedItem = itemDetails.copy(
      cartCount: newCount,
      totalRate: newCount * itemDetails.rate,
    );
    await ItemDatabase.instance.update(updatedItem);
    await widget.callBack(true);
    await _getCartCount();
  }
}