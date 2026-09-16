import 'package:peneiras/models/address_model.dart';
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

class ClubWithAddressRequest extends ClubeModel implements Serializable {
  final AddressModel? address;

  ClubWithAddressRequest({
    required super.name,
    required super.email,
    required super.category,
    required super.instagramAccount,
    required super.phone,
    required super.whatsapp,
    required super.userImg,
    this.address,
  });

  factory ClubWithAddressRequest.fromJson(Map<String, dynamic> json) {
    final parent = ClubeModel.fromJson(json);
    return ClubWithAddressRequest(
      name: parent.name,
      email: parent.email,
      category: parent.category,
      instagramAccount: parent.instagramAccount,
      phone: parent.phone,
      whatsapp: parent.whatsapp,
      userImg: parent.userImg,
      address: json["address"] != null
          ? AddressModel.fromJson(json["address"])
          : null,
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
      'userImg': userImg,
      'address': address?.toJson(),
    };
  }
}
