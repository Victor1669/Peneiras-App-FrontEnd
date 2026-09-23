import 'package:peneiras/models/peneira_enroll_model.dart';

class PeneiraEnrollResponse extends PeneiraEnrollModel {
  const PeneiraEnrollResponse(
      {required super.id, required super.enrolledAt, required super.peneira});

  factory PeneiraEnrollResponse.fromJson(Map<String, dynamic> json) {
    final parent = PeneiraEnrollModel.fromJson(json);

    return PeneiraEnrollResponse(
        id: parent.id, enrolledAt: parent.enrolledAt, peneira: parent.peneira);
  }
}
