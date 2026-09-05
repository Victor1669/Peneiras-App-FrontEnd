/// Classe base para todos os modelos que precisam ser serializados para JSON
abstract class Serializable {
  Map<String, dynamic> toJson();
}
