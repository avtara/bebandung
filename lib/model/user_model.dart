class Users {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? password;
  List? favouriteFoods;
  List? favouriteWisata;

  Users(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.password,
      this.favouriteFoods,
      this.favouriteWisata});

  factory Users.fromMap(map) {
    return Users(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        password: map['password'],
        phone: map['phone'],
        favouriteFoods: map['favouriteFoods'],
        favouriteWisata: map['favouriteWisata']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'phone': phone,
      'favouriteFoods': favouriteFoods,
      'favouriteWisata': favouriteWisata
    };
  }
}
