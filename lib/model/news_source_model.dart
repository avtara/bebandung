import 'package:equatable/equatable.dart';

class Sources extends Equatable {
  String? id;
  String? name;

  Sources({this.id, this.name});

  factory Sources.fromMap(map) {
    return Sources(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id!, name!];
}
