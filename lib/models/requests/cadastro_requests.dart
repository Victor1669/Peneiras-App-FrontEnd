import 'package:peneiras/models/requests/serializable.dart';

class CreatePlayerRequest implements Serializable {
  final String name;
  final String email;
  final String password;
  final String birthDate;
  final String position;
  final String dominantFoot;
  final String category;
  final int heightCm;

  const CreatePlayerRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.position,
    required this.dominantFoot,
    required this.category,
    required this.heightCm,
  });

  factory CreatePlayerRequest.fromJson(Map<String, dynamic> json) {
    return CreatePlayerRequest(
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

  @override
  Map<String, dynamic> toJson() {
    return {
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

class CreateClubRequest implements Serializable {
  final String name;
  final String email;
  final String password;
  final String category;
  final String phone;
  final String whatsapp;
  final String instagramAccount;

  CreateClubRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.category,
    required this.phone,
    required this.whatsapp,
    required this.instagramAccount,
  });

  factory CreateClubRequest.fromJson(Map<String, dynamic> json) {
    return CreateClubRequest(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      category: json['category'] ?? '',
      phone: json['phone'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      instagramAccount: json['instagramAccount'] ?? '',
    );
  }

  @override
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

class CreateUsersResponse {
  CreateUsersResponse();

  factory CreateUsersResponse.fromJson(Map<String, dynamic> json) {
    return CreateUsersResponse();
  }
}

class UploadPhotoRequest extends Serializable {
  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

class UploadPhotoResponse {
  UploadPhotoResponse();

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) {
    return UploadPhotoResponse();
  }
}
