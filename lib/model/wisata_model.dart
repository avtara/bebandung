class WisataModel {
  int? id;
  String? name;
  String? image;
  String? rating;
  String? location;
  String? description;

  WisataModel(
      {this.id,
      this.name,
      this.image,
      this.rating,
      this.location,
      this.description});

  factory WisataModel.fromMap(map) {
    return WisataModel(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        rating: map['rating'],
        location: map['location'],
        description: map['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'location': location,
      'description': description
    };
  }
}
