import 'package:flutter/material.dart';
import 'package:peneiras/models/input_config.dart';

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
    });

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
    items: ["FUTEBOL", "FUTSAL"]);

InputConfig heightInput = InputConfig(
  key: "heightCm",
  label: "Altura em centímetros",
  placeholder: "Ex: 180",
  keyboardType: TextInputType.number,
);

InputConfig dateInput = InputConfig(
  key: "birthDate",
  label: "Data de nascimento",
  placeholder: "DD/MM/AAAA",
  keyboardType: TextInputType.datetime,
  validator: (value) => (value?.length ?? 0) < 1 ? "Data é obrigatória" : null,
);

InputConfig positionInput = InputConfig(
    key: "position",
    label: "Posição",
    placeholder: "Selecione sua posição",
    type: InputType.select,
    items: [
      "GOLEIRO",
      "ZAGUEIRO",
      "LATERAL",
      "VOLANTE",
      "MEIA",
      "PONTA",
      "CENTRO_AVANTE",
      "FIXO",
      "ALA",
      "PIVO"
    ]);
