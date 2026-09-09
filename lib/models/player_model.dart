class PlayerModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String birthDate;
  final String position;
  final String dominantFoot;
  final String category;
  final int heightCm;

  const PlayerModel({
    this.id = "",
    required this.name,
    required this.email,
    this.password = '',
    required this.birthDate,
    required this.position,
    required this.dominantFoot,
    required this.category,
    required this.heightCm,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json["id"] ?? "",
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      birthDate: json['birthDate'] ?? '',
      position: json['position'] ?? '',
      dominantFoot: json['dominantFoot'] ?? '',
      category: json['category'] ?? '',
      heightCm: int.tryParse(json['heightCm']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'birthDate': birthDate,
      'position': position,
      'dominantFoot': dominantFoot,
      'category': category,
      'heightCm': heightCm,
    };
  }
}
