import 'package:peneiras/models/player_model.dart';
import 'package:peneiras/models/requests/serializable.dart';

class CreatePlayerRequest extends PlayerModel implements Serializable {
  const CreatePlayerRequest({
    required super.name,
    required super.email,
    required super.password,
    required super.birthDate,
    required super.position,
    required super.dominantFoot,
    required super.category,
    required super.heightCm,
  });

  factory CreatePlayerRequest.fromJson(Map<String, dynamic> json) {
    final model = PlayerModel.fromJson(json);
    return CreatePlayerRequest(
      name: model.name,
      email: model.email,
      password: model.password,
      birthDate: model.birthDate,
      position: model.position,
      dominantFoot: model.dominantFoot,
      category: model.category,
      heightCm: model.heightCm,
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

class UpdatePlayerRequest extends PlayerModel implements Serializable {
  final String cep;
  final String numero;
  final String complemento;

  const UpdatePlayerRequest({
    required super.id,
    required super.name,
    required super.email,
    required super.birthDate,
    required super.position,
    required super.dominantFoot,
    required super.category,
    required super.heightCm,
    required this.cep,
    required this.complemento,
    required this.numero,
  });

  factory UpdatePlayerRequest.fromJson(Map<String, dynamic> json) {
    final model = PlayerModel.fromJson(json);
    return UpdatePlayerRequest(
      id: model.id,
      name: model.name,
      email: model.email,
      birthDate: model.birthDate,
      position: model.position,
      dominantFoot: model.dominantFoot,
      category: model.category,
      heightCm: model.heightCm,
      cep: json["cep"] ?? "",
      complemento: json["complemento"] ?? "",
      numero: json["numero"] ?? "",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'position': position,
      'dominantFoot': dominantFoot,
      'category': category,
      'heightCm': heightCm,
      "cep": cep,
      "complemento": complemento,
      "numero": numero
    };
  }
}
