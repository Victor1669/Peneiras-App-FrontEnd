import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/models/requests/serializable.dart';

class CreatePeneiraRequest extends PeneiraModel implements Serializable {
  const CreatePeneiraRequest({
    required super.about,
    required super.category,
    required super.date,
    required super.documents,
    required super.hour,
    required super.modality,
    required super.uniforms,
  });

  factory CreatePeneiraRequest.fromJson(Map<String, dynamic> json) {
    final model = PeneiraCardModel.fromJson(json);
    return CreatePeneiraRequest(
      about: model.about,
      category: model.category,
      date: model.date,
      documents: model.documents,
      hour: model.hour,
      modality: model.modality,
      uniforms: model.uniforms,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'about': about,
      'category': category.value,
      'date': date,
      'documents': documents.value,
      'hour': hour,
      'modality': modality.value,
      'uniforms': uniforms.map((e) => e.value).toList(),
    };
  }
}
