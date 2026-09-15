import 'package:peneiras/models/enums.dart';

class PeneiraModel {
  final String id;
  final CategoryType category;
  final ModalityType modality;
  final String date;
  final String hour;
  final List<UniformType> uniforms;
  final DocumentType documents;
  final String about;

  const PeneiraModel({
    this.id = "",
    required this.about,
    required this.category,
    required this.date,
    required this.documents,
    required this.hour,
    required this.modality,
    required this.uniforms,
  });

  factory PeneiraModel.fromJson(Map<String, dynamic> json) {
    return PeneiraModel(
      id: json['id']?.toString() ?? '',
      about: json['about']?.toString() ?? '',
      category: CategoryType.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => CategoryType.values.first,
      ),
      date: json['date']?.toString() ?? '',
      documents: DocumentType.values.firstWhere(
        (e) => e.value == json['documents'],
        orElse: () => DocumentType.values.first,
      ),
      hour: json['hour']?.toString() ?? '',
      modality: ModalityType.values.firstWhere(
        (e) => e.value == json['modality'],
        orElse: () => ModalityType.values.first,
      ),
      uniforms: (json['uniforms'] as List<dynamic>? ?? [])
          .map((item) => UniformType.values.firstWhere(
                (e) => e.value == item,
                orElse: () => UniformType.values.first,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'about': about,
      'category': category.value,
      'date': date,
      'documents': documents.value,
      'hour': hour,
      'modality': modality.value,
      'uniforms': uniforms.map((u) => u.value).toList(),
    };
  }
}

class PeneiraCardModel extends PeneiraModel {
  // Campos de outras tabelas
  final String clubeNome;
  final String? clubeImagem;
  final String? endereco;

  const PeneiraCardModel({
    required super.id,
    required super.about,
    required super.category,
    required super.date,
    required super.documents,
    required super.hour,
    required super.modality,
    required super.uniforms,
    // Campos de outras tabelas
    required this.clubeNome,
    required this.clubeImagem,
    required this.endereco,
  });

  factory PeneiraCardModel.fromJson(Map<String, dynamic> json) {
    final parent = PeneiraModel.fromJson(json);

    return PeneiraCardModel(
      id: parent.id,
      about: parent.about,
      category: parent.category,
      date: parent.date,
      documents: parent.documents,
      hour: parent.hour,
      modality: parent.modality,
      uniforms: parent.uniforms,
      // Campos de outras tabelas
      clubeImagem: json['clubeImagem']?.toString() ?? '',
      clubeNome: json['clubeNome']?.toString() ?? '',
      endereco: json['endereco']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'PeneiraModel(id: $id, category: $category, modality: $modality, date: $date, hour: $hour, uniforms: $uniforms, documents: $documents, about: $about, clubeNome: $clubeNome, clubeImagem: $clubeImagem, endereco: $endereco)';
  }
}
