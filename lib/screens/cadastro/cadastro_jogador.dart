import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/widgets/dynamic_form.dart';
import 'package:peneiras/widgets/multi_step_scaffold.dart';

class CadastroJogadorScreen extends StatefulWidget {
  const CadastroJogadorScreen({super.key});

  @override
  State<CadastroJogadorScreen> createState() => _CadastroJogadorScreenState();
}

class _CadastroJogadorScreenState extends State<CadastroJogadorScreen> {
  int _currentStep = 0;
  final Map<String, String> _formData = {};

  final List<String> _subtitles = [
    "Dados pessoais\npreencha seus dados basicos.",
    "Dados pessoais\npreencha seus dados basicos.",
    "Dados pessoais\npreencha seus dados basicos.",
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

  void _handlePosicao(Map<String, String> data) {
    _formData.addAll(data);
    setState(() {
      _currentStep = 2;
    });
  }

  Future<void> _handleFinalizar(Map<String, String> data) async {
    _formData.addAll(data);
    print(_formData);
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return DadosPessoaisStep(onSubmit: _handleDadosPessoais);
      case 1:
        return PosicaoStep(onSubmit: _handlePosicao);
      default:
        return CategoriaStep(onSubmit: _handleFinalizar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiStepScaffold(
      title: "Criar conta (Jogador)",
      subtitle: _subtitles[_currentStep],
      totalSteps: 3,
      currentStep: _currentStep,
      onBack: _goToPreviousStep,
      child: _buildCurrentStep(),
    );
  }
}

class DadosPessoaisStep extends StatelessWidget {
  final Function(Map<String, String>) onSubmit;

  const DadosPessoaisStep({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        InputConfig(
          key: "name",
          label: "Nome completo",
          icon: Icons.person,
          validator: (value) =>
              (value?.length ?? 0) < 1 ? "Nome é obrigatório" : null,
        ),
        InputConfig(
          key: "email",
          label: "E-mail",
          placeholder: "exemplo@email.com",
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

class PosicaoStep extends StatelessWidget {
  final Function(Map<String, String>) onSubmit;

  const PosicaoStep({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        InputConfig(
          key: "birthDate",
          label: "Data de nascimento",
          placeholder: "DD/MM/AAAA",
          keyboardType: TextInputType.datetime,
          validator: (value) =>
              (value?.length ?? 0) < 1 ? "Data é obrigatória" : null,
        ),
        InputConfig(
          key: "position",
          label: "Posição",
          placeholder: "Selecione sua posição",
        ),
        InputConfig(
          key: "dominantFoot",
          label: "Pé dominante",
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}

class CategoriaStep extends StatelessWidget {
  final Function(Map<String, String>) onSubmit;

  const CategoriaStep({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Finalizar",
      inputs: [
        InputConfig(
          key: "category",
          label: "Categoria Principal",
          placeholder: "Selecione sua categoria",
        ),
        InputConfig(
          key: "height",
          label: "Altura",
          placeholder: "Ex: 180",
          keyboardType: TextInputType.number,
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}
