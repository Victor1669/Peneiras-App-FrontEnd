import 'package:peneiras/models/inputs.dart';
import 'package:peneiras/models/requests/serializable.dart';

class CreatePeneiraRequest implements Serializable {
  final String id;
  final CategoryType category;
  final ModalityType modality;
  final String date;
  final String hour;
  final List<UniformType> uniforms;
  final DocumentType documents;
  final String about;

  const CreatePeneiraRequest({
    required this.id,
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
      id: json['id']?.toString() ?? '',
      about: json['about']?.toString() ?? '',
      category: CategoryType.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => CategoryType.values.first,
      ),
      date: json['date']?.toString() ?? '',
      documents: DocumentType.values.firstWhere(
        (e) => e.name == json['documents'],
        orElse: () => DocumentType.values.first,
      ),
      hour: json['hour']?.toString() ?? '',
      modality: ModalityType.values.firstWhere(
        (e) => e.name == json['modality'],
        orElse: () => ModalityType.values.first,
      ),
      uniforms: (json['uniforms'] as List<dynamic>? ?? [])
          .map((item) => UniformType.values.firstWhere(
                (e) => e.name == item,
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
