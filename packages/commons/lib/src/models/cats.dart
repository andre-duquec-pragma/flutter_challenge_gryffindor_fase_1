import 'dart:convert';

class Cat {
  final String id;
  final String breedName;
  final String origin;
  final int affectionLevel;
  final int intelligence;
  final String imageId;
  final String description;

  const Cat({
    required this.id,
    required this.breedName,
    required this.origin,
    required this.affectionLevel,
    required this.intelligence,
    required this.imageId,
    required this.description,
  });

  Cat copyWith({
    String? id,
    String? breedName,
    String? origin,
    int? affectionLevel,
    int? intelligence,
    String? imageId,
    String? description,
  }) {
    return Cat(
      id: id ?? this.id,
      breedName: breedName ?? this.breedName,
      origin: origin ?? this.origin,
      affectionLevel: affectionLevel ?? this.affectionLevel,
      intelligence: intelligence ?? this.intelligence,
      imageId: imageId ?? this.imageId,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(covariant Cat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.breedName == breedName &&
        other.origin == origin &&
        other.affectionLevel == affectionLevel &&
        other.intelligence == intelligence &&
        other.imageId == imageId &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        breedName.hashCode ^
        origin.hashCode ^
        affectionLevel.hashCode ^
        intelligence.hashCode ^
        imageId.hashCode ^
        description.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'breedName': breedName,
      'origin': origin,
      'affectionLevel': affectionLevel,
      'intelligence': intelligence,
      'imageId': imageId,
      'description': description,
    };
  }

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      id: map['id'] as String,
      breedName: map['breedName'] as String,
      origin: map['origin'] as String,
      affectionLevel: map['affectionLevel'] as int,
      intelligence: map['intelligence'] as int,
      imageId: map['imageId'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cat.fromJson(String source) => Cat.fromMap(json.decode(source) as Map<String, dynamic>);
}
