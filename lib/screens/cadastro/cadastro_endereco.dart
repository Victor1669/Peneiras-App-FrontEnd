import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/layout/screen_frame.dart';
import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/widgets/form/dynamic_form.dart';

class CadastroEnderecoScreen extends StatelessWidget {
  const CadastroEnderecoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
        title: "Endereço",
        onBack: () {
          context.go("/");
        },
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Informe seu endereco completo",
                textAlign: TextAlign.center,
              ),
            ),
            CadastroEnderecoForm()
          ],
        ));
  }
}

class CadastroEnderecoForm extends StatelessWidget {
  const CadastroEnderecoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
        submitText: "Finalizar",
        inputs: const [
          InputConfig(
              key: "endereco",
              label: "Endereço",
              placeholder: "Insira seu endereço (CEP)",
              icon: Icons.location_pin),
          InputConfig(
            key: "numero",
            label: "Número",
          ),
          InputConfig(
            key: "complemento",
            label: "Complemento",
          ),
        ],
        onSubmit: (data) {
          context.go("/cadastro/sucesso");
        });
  }
}
