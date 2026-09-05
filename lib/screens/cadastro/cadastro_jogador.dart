import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/services/auth_service.dart';
import 'package:peneiras/utils/app_date_utils.dart';
import 'package:peneiras/layout/multi_step_scaffold.dart';

import 'package:peneiras/widgets/form/dynamic_form.dart';
import 'package:peneiras/models/inputs.dart';

class CadastroJogadorScreen extends StatefulWidget {
  const CadastroJogadorScreen({super.key});

  @override
  State<CadastroJogadorScreen> createState() => _CadastroJogadorScreenState();
}

class _CadastroJogadorScreenState extends State<CadastroJogadorScreen> {
  int _currentStep = 0;
  final Map<String, dynamic> _formData = {};

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

  void _handleDadosPessoais(Map<String, dynamic> data) {
    _formData.addAll(data);
    setState(() {
      _currentStep = 1;
    });
  }

  void _handlePosicao(Map<String, dynamic> data) {
    _formData.addAll(data);
    setState(() {
      _currentStep = 2;
    });
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _DadosPessoaisStep(onSubmit: _handleDadosPessoais);
      case 1:
        return _PosicaoStep(onSubmit: _handlePosicao);
      default:
        return _CategoriaStep(onSubmit: (data) async {
          _formData.addAll(data);

          final Map<String, dynamic> dataParaEnvio = Map.from(_formData);
          if (dataParaEnvio.containsKey('birthDate')) {
            dataParaEnvio['birthDate'] =
                AppDateUtils.toApiFormat(dataParaEnvio['birthDate']!);
          }

          try {
            final authService = AuthService();

            final playerBody = CreatePlayerRequest.fromJson(dataParaEnvio);

            await authService.createPlayer(playerBody);

            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Jogador criado com sucesso!"),
                backgroundColor: Colors.green,
              ),
            );

            context.go("/cadastro/upload-photo");
          } catch (e) {
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString().replaceAll('Exception: ', '')),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        });
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

class _DadosPessoaisStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const _DadosPessoaisStep({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        playerNameInput,
        emailInput,
        passwordInput,
      ],
      onSubmit: onSubmit,
    );
  }
}

class _PosicaoStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const _PosicaoStep({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        birthDateInput,
        positionInput,
        InputConfig(
          key: "dominantFoot",
          label: "Pé dominante",
          type: InputType.select,
          items: DominantFootType.values.map((e) => e.toOption()).toList(),
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}

class _CategoriaStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const _CategoriaStep({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Finalizar",
      inputs: [
        categoryInput,
        heightInput,
      ],
      onSubmit: onSubmit,
    );
  }
}
