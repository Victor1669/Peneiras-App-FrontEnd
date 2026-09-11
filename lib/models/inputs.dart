import 'package:flutter/material.dart';
import 'package:peneiras/models/enums.dart';
import 'package:peneiras/models/input_config.dart';

InputConfig getPlayerNameInput() => InputConfig(
      key: "name",
      label: "Nome completo",
      icon: Icons.person,
      validator: (value) =>
          (value?.length ?? 0) < 1 ? "Nome é obrigatório" : null,
    );

InputConfig getTeamNameInput() => InputConfig(
      key: "name",
      label: "Nome do clube",
      placeholder: "Insira o nome do seu clube",
      icon: Icons.shield_outlined,
      validator: (value) =>
          (value?.length ?? 0) < 1 ? "Nome é obrigatório" : null,
    );

InputConfig getEmailInput() => InputConfig(
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

InputConfig getPasswordInput() => InputConfig(
      key: "password",
      label: "Senha",
      isPassword: true,
      icon: Icons.lock,
      validator: (value) =>
          (value?.length ?? 0) < 6 ? "Senha muito curta" : null,
    );

InputConfig getCategoryInput() => InputConfig(
      key: "category",
      label: "Categoria Principal",
      placeholder: "Selecione sua categoria",
      type: InputType.select,
      items: CategoryType.values.map((e) => e.toOption()).toList(),
    );

InputConfig getHeightInput() => InputConfig(
      key: "heightCm",
      label: "Altura em centímetros",
      placeholder: "Ex: 180",
      keyboardType: TextInputType.number,
    );

InputConfig getBirthDateInput() => InputConfig(
      key: "birthDate",
      label: "Data de nascimento",
      placeholder: "AAAA-MM-DD",
      type: InputType.date,
      icon: Icons.calendar_view_month,
      validator: (value) =>
          (value?.length ?? 0) < 1 ? "Data de nascimento é obrigatória" : null,
    );

InputConfig getDateInput() => InputConfig(
      key: "date",
      label: "Data",
      placeholder: "AAAA-MM-DD",
      type: InputType.date,
      icon: Icons.calendar_today,
      validator: (value) =>
          (value?.length ?? 0) < 1 ? "Data é obrigatória" : null,
    );

InputConfig getHourInput() => InputConfig(
      key: "hour",
      label: "Horário",
      placeholder: "HH:mm",
      type: InputType.time,
      icon: Icons.access_time,
      validator: (value) =>
          (value?.length ?? 0) < 1 ? "Horário é obrigatório" : null,
    );

InputConfig getPositionInput() => InputConfig(
      key: "position",
      label: "Posição",
      placeholder: "Selecione sua posição",
      type: InputType.select,
      items: PositionType.values.map((e) => e.toOption()).toList(),
    );

InputConfig getPhoneInput() => InputConfig(
      key: "phone",
      label: "Telefone",
      placeholder: "(00) 00000-0000",
      keyboardType: TextInputType.phone,
      icon: Icons.phone,
    );

InputConfig getWhatsappInput() => InputConfig(
      key: "whatsapp",
      label: "WhatsApp",
      placeholder: "(00) 00000-0000",
      keyboardType: TextInputType.phone,
      icon: Icons.chat_bubble_outline,
    );

InputConfig getInstagramInput() => InputConfig(
      key: "instagramAccount",
      label: "Instagram",
      placeholder: "@seu_usuario",
      icon: Icons.camera_alt_outlined,
    );

InputConfig getCepInput() => InputConfig(
      key: "cep",
      label: "CEP",
      placeholder: "Ex: 00000001",
      icon: Icons.numbers_rounded,
    );

InputConfig getNumeroInput() => InputConfig(
      key: "numero",
      label: "Número",
      placeholder: "Ex: 7",
      icon: Icons.house_rounded,
    );

InputConfig getComplementoInput() => InputConfig(
      key: "complemento",
      label: "Complemento",
      placeholder: "Ex: casa",
      icon: Icons.streetview,
    );

InputConfig getDominantFootInput() => InputConfig(
      key: "dominantFoot",
      label: "Pé dominante",
      type: InputType.select,
      items: DominantFootType.values.map((e) => e.toOption()).toList(),
    );
