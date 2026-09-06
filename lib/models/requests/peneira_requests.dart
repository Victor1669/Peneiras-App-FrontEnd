import 'package:peneiras/models/inputs.dart';
import 'package:peneiras/models/requests/serializable.dart';

class CreatePeneiraRequest implements Serializable {
  final CategoryType category;
  final ModalityType modality;
  final String date;
  final String hour;
  final List<UniformType> uniforms;
  final DocumentType documents;
  final String about;

  const CreatePeneiraRequest({
    required this.about,
    required this.category,
    required this.date,
    required this.documents,
    required this.hour,
    required this.modality,
    required this.uniforms,
  });

  factory CreatePeneiraRequest.fromJson(Map<String, dynamic> json) {
    return CreatePeneiraRequest(
      about: json['about'] ?? '',
      category: CategoryType.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => CategoryType.values.first,
      ),
      date: json['date'] ?? '',
      documents: DocumentType.values.firstWhere(
        (e) => e.value == json['documents'],
        orElse: () => DocumentType.values.first,
      ),
      hour: json['hour'] ?? '',
      modality: ModalityType.values.firstWhere(
        (e) => e.value == json['modality'],
        orElse: () => ModalityType.values.first,
      ),
      uniforms: (json['uniforms'] as List<dynamic>? ?? [])
          .map((e) => UniformType.values.firstWhere(
                (type) => type.value == e,
                orElse: () => UniformType.values.first,
              ))
          .toList(),
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

class CreatePeneiraResponse extends CreatePeneiraRequest {
  final String id;

  const CreatePeneiraResponse({
    required this.id,
    required super.about,
    required super.category,
    required super.date,
    required super.documents,
    required super.hour,
    required super.modality,
    required super.uniforms,
  });

  factory CreatePeneiraResponse.fromJson(Map<String, dynamic> json) {
    return CreatePeneiraResponse(
      id: json['id'] ?? '',
      about: json['about'] ?? '',
      category: CategoryType.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => CategoryType.values.first,
      ),
      date: json['date'] ?? '',
      documents: DocumentType.values.firstWhere(
        (e) => e.value == json['documents'],
        orElse: () => DocumentType.values.first,
      ),
      hour: json['hour'] ?? '',
      modality: ModalityType.values.firstWhere(
        (e) => e.value == json['modality'],
        orElse: () => ModalityType.values.first,
      ),
      uniforms: (json['uniforms'] as List<dynamic>? ?? [])
          .map((e) => UniformType.values.firstWhere(
                (type) => type.value == e,
                orElse: () => UniformType.values.first,
              ))
          .toList(),
    );
  }
}
