

const String itemTable = 'item';
class ItemFields {
  static final List<String> values = [
    /// Add all fields
    id,
    name,
    rate,
    piece,
    image,
    totalRate,
    cartCount,
    isFavourite,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String rate = 'rate';
  static const String piece = 'piece';
  static const String image = 'image';
  static const String totalRate = 'totalRate';
  static const String cartCount = 'cartCount';
  static const String isFavourite ='isFavourite';
}

class Item  {
  final int? id;
  final String name;
  final num rate;
  final String piece;
  final String image;
  final num totalRate;
  final int cartCount;
  final bool isFavourite;

  const Item({
    this.id,
    required this.name,
    required this.rate,
    required this.piece,
    required this.image,
    required this.totalRate,
    required this.cartCount,
    required this.isFavourite,
  });

  Item copy({
    int? id,
    String? name,
    num? rate,
    String? piece,
    String? image,
    num? totalRate,
    int? cartCount,
    bool? isFavourite,
  }) =>
      Item(
        id: id ?? this.id,
        name: name ?? this.name,
        rate: rate ?? this.rate,
        piece: piece ?? this.piece,
        image: image ?? this.image,
        totalRate: totalRate ?? this.totalRate,
        cartCount: cartCount ?? this.cartCount,
        isFavourite: isFavourite ?? this.isFavourite,
      );

  static Item fromJson(Map<String, Object?> json) => Item(
    id: json[ItemFields.id] as int?,
    name: json[ItemFields.name] as String,
    rate: json[ItemFields.rate] as num,
    piece: json[ItemFields.piece] as String,
    image: json[ItemFields.image] as String,
    totalRate: json[ItemFields.totalRate] as num,
    cartCount: json[ItemFields.cartCount] as int,
    isFavourite: (json[ItemFields.isFavourite] is bool)
        ? json[ItemFields.isFavourite] as bool
        : (json[ItemFields.isFavourite] == 1),
  );

  Map<String, Object?> toJson() => {
    ItemFields.id: id,
    ItemFields.name: name,
    ItemFields.rate: rate,
    ItemFields.piece: piece,
    ItemFields.image: image,
    ItemFields.totalRate: totalRate,
    ItemFields.cartCount: cartCount,
    ItemFields.isFavourite: isFavourite ? 1 : 0,
  };
}
