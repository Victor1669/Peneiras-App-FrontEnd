class ClubeModel {
  final String? id;
  final String name;
  final String email;
  final String? password;
  final String category;
  final String phone;
  final String whatsapp;
  final String instagramAccount;
  final String? userImg;

  ClubeModel(
      {this.id,
      required this.name,
      required this.email,
      this.password,
      required this.category,
      required this.phone,
      required this.whatsapp,
      required this.instagramAccount,
      this.userImg});

  factory ClubeModel.fromJson(Map<String, dynamic> json) {
    return ClubeModel(
      id: json["id"] ?? "",
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      category: json['category'] ?? '',
      phone: json['phone'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      instagramAccount: json['instagramAccount'] ?? '',
      userImg: json['userImg'] ?? '',
    );
  }
}
