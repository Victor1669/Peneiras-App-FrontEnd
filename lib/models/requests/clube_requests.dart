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

class UpdateClubRequest extends ClubeModel implements Serializable {
  final String cep;
  final String numero;
  final String complemento;

  UpdateClubRequest(
      {required super.name,
      required super.email,
      required super.category,
      required super.instagramAccount,
      required super.phone,
      required super.whatsapp,
      required this.cep,
      required this.complemento,
      required this.numero});

  factory UpdateClubRequest.fromJson(Map<String, dynamic> json) {
    final parent = ClubeModel.fromJson(json);
    return UpdateClubRequest(
      name: parent.name,
      email: parent.email,
      category: parent.category,
      instagramAccount: parent.instagramAccount,
      phone: parent.phone,
      whatsapp: parent.whatsapp,
      cep: json["cep"] ?? "",
      complemento: json["complemento"] ?? "",
      numero: json["numero"] ?? "",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'category': category,
      'phone': phone,
      'whatsapp': whatsapp,
      'instagramAccount': instagramAccount,
      "cep": cep,
      "complemento": complemento,
      "numero": numero
    };
  }
}
