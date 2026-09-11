import 'package:peneiras/models/input_config.dart';

enum CategoryType {
  futebol("Futebol", "FUTEBOL"),
  futsal("Futsal", "FUTSAL");

  final String label;
  final String value;
  const CategoryType(this.label, this.value);

  SelectOption toOption() => SelectOption(label: label, value: value);
}

enum DocumentType {
  rg("RG", "RG"),
  cpf("CPF", "CPF"),
  certidaoNascimento("Certidão de Nascimento", "CERTIDAO_NASCIMENTO"),
  comprovanteResidencia("Comprovante de Residência", "COMPROVANTE_RESIDENCIA"),
  documentoResponsavel("Documento do Responsável", "DOCUMENTO_RESPONSAVEL"),
  autorizacaoResponsavel(
      "Autorização do Responsável", "AUTORIZACAO_RESPONSAVEL"),
  atestadoMedico("Atestado Médico", "ATESTADO_MEDICO"),
  registroAtleta("Registro Atleta", "REGISTRO_ATLETA");

  final String label;
  final String value;
  const DocumentType(this.label, this.value);

  SelectOption toOption() => SelectOption(label: label, value: value);
}

enum DominantFootType {
  direito("Direito", "DIREITO"),
  esquerdo("Esquerdo", "ESQUERDO"),
  ambos("Ambos", "AMBOS");

  final String label;
  final String value;
  const DominantFootType(this.label, this.value);

  SelectOption toOption() => SelectOption(label: label, value: value);
}

enum ModalityType {
  campo("Campo", "CAMPO"),
  society("Society", "SOCIETY"),
  quadra("Quadra", "QUADRA");

  final String label;
  final String value;
  const ModalityType(this.label, this.value);

  SelectOption toOption() => SelectOption(label: label, value: value);
}

enum PositionType {
  goleiro("Goleiro", "GOLEIRO"),
  zagueiro("Zagueiro", "ZAGUEIRO"),
  lateral("Lateral", "LATERAL"),
  volante("Volante", "VOLANTE"),
  meia("Meia", "MEIA"),
  ponta("Ponta", "PONTA"),
  centroAvante("Centro Avante", "CENTRO_AVANTE"),
  fixo("Fixo", "FIXO"),
  ala("Ala", "ALA"),
  pivo("Pivô", "PIVO");

  final String label;
  final String value;
  const PositionType(this.label, this.value);

  SelectOption toOption() => SelectOption(label: label, value: value);
}

enum UniformType {
  camisa("Camisa", "CAMISA"),
  shorts("Shorts", "SHORTS"),
  meias("Meias", "MEIAS"),
  caneleira("Caneleira", "CANELEIRA"),
  luvasDePedreiro("Luvas de Goleiro", "LUVAS_DE_GOLEIRO");

  final String label;
  final String value;
  const UniformType(this.label, this.value);

  SelectOption toOption() => SelectOption(label: label, value: value);
}
