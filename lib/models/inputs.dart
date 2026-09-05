import 'package:flutter/material.dart';
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

InputConfig playerNameInput = InputConfig(
  key: "name",
  label: "Nome completo",
  icon: Icons.person,
  validator: (value) => (value?.length ?? 0) < 1 ? "Nome é obrigatório" : null,
);

InputConfig teamNameInput = InputConfig(
  key: "name",
  label: "Nome do clube",
  placeholder: "Insira o nome do seu clube",
  icon: Icons.shield_outlined,
  validator: (value) => (value?.length ?? 0) < 1 ? "Nome é obrigatório" : null,
);

InputConfig emailInput = InputConfig(
  key: "email",
  label: "E-mail",
  placeholder: "Insira seu e-mail",
  keyboardType: TextInputType.emailAddress,
  icon: Icons.email,
  validator: (value) {
    if (value == null || !value.contains('@')) {
      return "E-mail inválido";
    }
    return null;
  },
);

InputConfig passwordInput = InputConfig(
  key: "password",
  label: "Senha",
  isPassword: true,
  icon: Icons.lock,
  validator: (value) => (value?.length ?? 0) < 6 ? "Senha muito curta" : null,
);

InputConfig categoryInput = InputConfig(
  key: "category",
  label: "Categoria Principal",
  placeholder: "Selecione sua categoria",
  type: InputType.select,
  items: CategoryType.values.map((e) => e.toOption()).toList(),
);

InputConfig heightInput = const InputConfig(
  key: "heightCm",
  label: "Altura em centímetros",
  placeholder: "Ex: 180",
  keyboardType: TextInputType.number,
);

InputConfig birthDateInput = InputConfig(
  key: "birthDate",
  label: "Data de nascimento",
  placeholder: "AAAA-MM-DD",
  type: InputType.date,
  icon: Icons.calendar_view_month,
  validator: (value) =>
      (value?.length ?? 0) < 1 ? "Data de nascimento é obrigatória" : null,
);

InputConfig dateInput = InputConfig(
  key: "date",
  label: "Data",
  placeholder: "AAAA-MM-DD",
  type: InputType.date,
  icon: Icons.calendar_today,
  validator: (value) => (value?.length ?? 0) < 1 ? "Data é obrigatória" : null,
);

InputConfig hourInput = InputConfig(
  key: "hour",
  label: "Horário",
  placeholder: "HH:mm",
  type: InputType.time,
  icon: Icons.access_time,
  validator: (value) =>
      (value?.length ?? 0) < 1 ? "Horário é obrigatório" : null,
);

InputConfig positionInput = InputConfig(
  key: "position",
  label: "Posição",
  placeholder: "Selecione sua posição",
  type: InputType.select,
  items: PositionType.values.map((e) => e.toOption()).toList(),
);
