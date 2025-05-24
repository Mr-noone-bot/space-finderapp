class Classroom {
  final String id;
  final String name;
  final String block;
  final String floor;
  final List<String> availableSlots;

  Classroom({
    required this.id,
    required this.name,
    required this.block,
    required this.floor,
    required this.availableSlots,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'],
      name: json['name'],
      block: json['block'],
      floor: json['floor'],
      availableSlots: List<String>.from(json['availableSlots']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'block': block,
      'floor': floor,
      'availableSlots': availableSlots,
    };
  }

  Classroom copyWith({
    String? id,
    String? name,
    String? block,
    String? floor,
    List<String>? availableSlots,
  }) {
    return Classroom(
      id: id ?? this.id,
      name: name ?? this.name,
      block: block ?? this.block,
      floor: floor ?? this.floor,
      availableSlots: availableSlots ?? this.availableSlots,
    );
  }
}
