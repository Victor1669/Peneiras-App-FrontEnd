import 'package:peneiras/models/peneira_model.dart';

class PeneiraEnrollModel {
  final String id;
  final PeneiraCardModel peneira;
  final String enrolledAt;

  const PeneiraEnrollModel(
      {required this.id, required this.peneira, required this.enrolledAt});

  factory PeneiraEnrollModel.fromJson(Map<String, dynamic> json) {
    return PeneiraEnrollModel(
      id: json["id"] ?? '',
      peneira: PeneiraCardModel.fromJson(json["peneira"]),
      enrolledAt: json["enrolledAt"] ?? '',
    );
  }
}
