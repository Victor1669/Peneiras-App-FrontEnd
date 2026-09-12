class AddressModel {
  final String id;
  final String cep;
  final String numero;
  final String complemento;

  const AddressModel({
    this.id = "",
    required this.cep,
    required this.numero,
    this.complemento = "",
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"] ?? "",
      cep: json["cep"] ?? "",
      numero: json["numero"] ?? "",
      complemento: json["complemento"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'cep': cep,
      'numero': numero,
      'complemento': complemento,
    };
  }
}
