import 'package:peneiras/models/clube_model.dart';
import 'package:peneiras/models/requests/serializable.dart';

class CreateClubRequest extends ClubeModel implements Serializable {
  CreateClubRequest({
    required super.name,
    required super.email,
    required super.password,
    required super.category,
    required super.phone,
    required super.whatsapp,
    required super.instagramAccount,
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
