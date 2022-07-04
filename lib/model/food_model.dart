class FoodModel {
  int? id;
  String? name;
  List? restaurantName;
  int? price;
  String? image;
  String? rating;
  int? discount;
  String? description;

  FoodModel(
      {this.id,
      this.name,
      this.restaurantName,
      this.price,
      this.image,
      this.rating,
      this.discount,
      this.description});

  factory FoodModel.fromMap(map) {
    return FoodModel(
        id: map['id'],
        name: map['name'],
        restaurantName: map['restaurantName'],
        price: map['price'],
        image: map['image'].toString(),
        rating: map['rating'].toString(),
        discount: map['discount'],
        description: map['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'restaurantName': restaurantName,
      'price': price,
      'image': image,
      'rating': rating,
      'discount': discount,
      'description': description
    };
  }
}
