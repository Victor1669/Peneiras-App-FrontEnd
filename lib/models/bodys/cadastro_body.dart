class CadastroPlayerBody {
  final String name;
  final String email;
  final String password;
  final String birthDate;
  final String position;
  final String dominantFoot;
  final String category;
  final int heightCm;

  CadastroPlayerBody({
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.position,
    required this.dominantFoot,
    required this.category,
    required this.heightCm,
  });

  factory CadastroPlayerBody.fromMap(Map<String, String> map) {
    return CadastroPlayerBody(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      birthDate: map['birthDate'] ?? '',
      position: map['position'] ?? '',
      dominantFoot: map['dominantFoot'] ?? '',
      category: map['category'] ?? '',
      heightCm: int.tryParse(map['heightCm'] ?? '0') ?? 0,
    );
  }
}

class CadastroClubBody {
  final String name;
  final String email;
  final String password;
  final String category;
  final String phone;
  final String whatsapp;
  final String instagramAccount;

  CadastroClubBody({
    required this.name,
    required this.email,
    required this.password,
    required this.category,
    required this.phone,
    required this.whatsapp,
    required this.instagramAccount,
  });

  factory CadastroClubBody.fromMap(Map<String, String> map) {
    return CadastroClubBody(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      category: map['category'] ?? '',
      phone: map['phone'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      instagramAccount: map['instagramAccount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'category': category,
      'phone': phone,
      'whatsapp': whatsapp,
      'instagramAccount': instagramAccount,
    };
  }
}
