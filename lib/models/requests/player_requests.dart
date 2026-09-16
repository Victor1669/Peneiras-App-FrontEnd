import 'package:peneiras/models/address_model.dart';
import 'package:peneiras/models/player_model.dart';
import 'package:peneiras/models/requests/serializable.dart';

class CreatePlayerRequest extends PlayerModel implements Serializable {
  const CreatePlayerRequest(
      {required super.name,
      required super.email,
      required super.password,
      required super.birthDate,
      required super.position,
      required super.dominantFoot,
      required super.category,
      required super.heightCm,
      super.userImg = ''});

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

class PlayerWithAddressRequest extends PlayerModel implements Serializable {
  final AddressModel? address;

  const PlayerWithAddressRequest({
    required super.id,
    required super.name,
    required super.email,
    required super.birthDate,
    required super.position,
    required super.dominantFoot,
    required super.category,
    required super.heightCm,
    required super.userImg,
    this.address,
  });

  factory PlayerWithAddressRequest.fromJson(Map<String, dynamic> json) {
    final parent = PlayerModel.fromJson(json);
    return PlayerWithAddressRequest(
      id: parent.id,
      name: parent.name,
      email: parent.email,
      birthDate: parent.birthDate,
      position: parent.position,
      dominantFoot: parent.dominantFoot,
      category: parent.category,
      heightCm: parent.heightCm,
      userImg: parent.userImg,
      address: json["address"] != null
          ? AddressModel.fromJson(json["address"])
          : null,
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
      'userImg': userImg,
      'category': category,
      'heightCm': heightCm,
      'address': address?.toJson(),
    };
  }
}
