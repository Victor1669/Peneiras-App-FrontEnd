import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/models/input_config.dart';

import 'package:peneiras/services/auth_service.dart';
import 'package:peneiras/widgets/form/dynamic_form.dart';
import 'package:peneiras/layout/multi_step_scaffold.dart';
import 'package:peneiras/models/inputs.dart';

class CadastroTimeScreen extends StatefulWidget {
  const CadastroTimeScreen({super.key});

  @override
  State<CadastroTimeScreen> createState() => _CadastroTimeScreenState();
}

class _CadastroTimeScreenState extends State<CadastroTimeScreen> {
  int _currentStep = 0;
  final Map<String, dynamic> _formData = {};

  final List<String> _subtitles = [
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

  void _handleDadosPessoais(Map<String, dynamic> data) {
    _formData.addAll(data);
    setState(() {
      _currentStep = 1;
    });
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _DadosPessoaisTimeStep(onSubmit: _handleDadosPessoais);
      default:
        return _ContatoTimeStep(onSubmit: (data) async {
          _formData.addAll(data);

          print(_formData);

          final Map<String, dynamic> dataParaEnvio = Map.from(_formData);

          try {
            final authService = AuthService();

            final clubBody = CreateClubRequest.fromJson(dataParaEnvio);

            await authService.createClub(clubBody);

            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Clube criado com sucesso!"),
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
      title: "Criar conta (Clube)",
      subtitle: _subtitles[_currentStep],
      totalSteps: 2,
      currentStep: _currentStep,
      onBack: _goToPreviousStep,
      child: _buildCurrentStep(),
    );
  }
}

class _DadosPessoaisTimeStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const _DadosPessoaisTimeStep({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        teamNameInput,
        categoryInput,
        emailInput,
        passwordInput,
      ],
      onSubmit: onSubmit,
    );
  }
}

class _ContatoTimeStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const _ContatoTimeStep({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Finalizar",
      inputs: const [
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
          key: "instagramAccount",
          label: "Instagram",
          placeholder: "@seuclube",
          icon: Icons.camera_alt_outlined,
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}
