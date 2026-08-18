import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/widgets/dynamic_form.dart';
import 'package:peneiras/layout/multi_step_scaffold.dart';

class CadastroTimeScreen extends StatefulWidget {
  const CadastroTimeScreen({super.key});

  @override
  State<CadastroTimeScreen> createState() => _CadastroTimeScreenState();
}

class _CadastroTimeScreenState extends State<CadastroTimeScreen> {
  int _currentStep = 0;
  final Map<String, String> _formData = {};

  final List<String> _subtitles = [
    "Dados pessoais\npreencha seus dados basicos.",
    "Dados pessoais\npreencha seus dados basicos.",
    "Contato\npreencha seus dados de contato.",
  ];

  void _goToPreviousStep() {
    if (_currentStep == 0) {
      context.pop();
    } else {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _handleDadosPessoais(Map<String, String> data) {
    _formData.addAll(data);
    setState(() {
      _currentStep = 1;
    });
  }

  void _handleEndereco(Map<String, String> data) {
    _formData.addAll(data);
    setState(() {
      _currentStep = 2;
    });
  }

  Future<void> _handleFinalizar(Map<String, String> data) async {
    _formData.addAll(data);
    print(_formData);
    context.go("/cadastro/upload-photo");
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return DadosPessoaisTimeStep(onSubmit: _handleDadosPessoais);
      case 1:
        return EnderecoTimeStep(onSubmit: _handleEndereco);
      default:
        return ContatoTimeStep(onSubmit: _handleFinalizar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiStepScaffold(
      title: "Criar conta (Clube)",
      subtitle: _subtitles[_currentStep],
      totalSteps: 3,
      currentStep: _currentStep,
      onBack: _goToPreviousStep,
      child: _buildCurrentStep(),
    );
  }
}

class DadosPessoaisTimeStep extends StatelessWidget {
  final Function(Map<String, String>) onSubmit;

  const DadosPessoaisTimeStep({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        InputConfig(
          key: "clubName",
          label: "Nome do clube",
          placeholder: "Insira o nome do seu clube",
          icon: Icons.shield_outlined,
          validator: (value) =>
              (value?.length ?? 0) < 1 ? "Nome é obrigatório" : null,
        ),
        InputConfig(
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
        ),
        InputConfig(
          key: "password",
          label: "Senha",
          placeholder: "sua senha",
          isPassword: true,
          icon: Icons.lock,
          validator: (value) =>
              (value?.length ?? 0) < 6 ? "Senha muito curta" : null,
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}

class EnderecoTimeStep extends StatelessWidget {
  final Function(Map<String, String>) onSubmit;

  const EnderecoTimeStep({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        InputConfig(
          key: "category",
          label: "Categoria Principal",
          placeholder: "Selecione sua categoria",
        ),
        InputConfig(
          key: "cep",
          label: "CEP",
          placeholder: "Insira seu endereço (CEP)",
        ),
        InputConfig(
          key: "number",
          label: "Numero",
          keyboardType: TextInputType.number,
        ),
        InputConfig(
          key: "complement",
          label: "Complemento",
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}

class ContatoTimeStep extends StatelessWidget {
  final Function(Map<String, String>) onSubmit;

  const ContatoTimeStep({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Finalizar",
      inputs: [
        InputConfig(
          key: "phone",
          label: "Telefone",
          placeholder: "(00) 00000-0000",
          keyboardType: TextInputType.phone,
          icon: Icons.phone,
        ),
        InputConfig(
          key: "whatsapp",
          label: "WhatsApp",
          placeholder: "(00) 00000-0000",
          keyboardType: TextInputType.phone,
          icon: Icons.chat_bubble_outline,
        ),
        InputConfig(
          key: "instagram",
          label: "Instagram",
          placeholder: "@seuclube",
          icon: Icons.camera_alt_outlined,
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}
