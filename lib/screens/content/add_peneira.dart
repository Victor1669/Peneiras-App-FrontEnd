import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/models/requests/peneira_requests.dart';

import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/services/peneira_service.dart';
import 'package:peneiras/widgets/form/dynamic_form.dart';
import 'package:peneiras/layout/multi_step_scaffold.dart';
import 'package:peneiras/models/inputs.dart';

class AddPeneiraScreen extends StatefulWidget {
  const AddPeneiraScreen({super.key});

  @override
  State<AddPeneiraScreen> createState() => _AddPeneiraScreenState();
}

class _AddPeneiraScreenState extends State<AddPeneiraScreen> {
  int _currentStep = 0;
  final Map<String, dynamic> _formData = {};

  final List<String> _subtitles = [
    "Informações básicas\npreencha os dados da peneira.",
    "Documentos e detalhes\nfinalize e publique a peneira.",
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

  void _handleStep1(Map<String, dynamic> data) {
    _formData.addAll(data);
    setState(() {
      _currentStep = 1;
    });
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _DadosBasicosPeneiraStep(onSubmit: _handleStep1);
      default:
        return _DocumentosPeneiraStep(onSubmit: (data) async {
          _formData.addAll(data);

          print(_formData);

          final CreatePeneiraRequest dataParaEnvio =
              CreatePeneiraRequest.fromJson(_formData);

          try {
            final peneiraService = PeneiraService();

            await peneiraService.createPeneira(dataParaEnvio);

            if (!mounted) return;

            // Sucesso
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Peneira publicada com sucesso!"),
                backgroundColor: Colors.green,
              ),
            );

            context.go("/home");
          } catch (_) {}
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiStepScaffold(
      title: "Nova Peneira",
      subtitle: _subtitles[_currentStep],
      totalSteps: 2,
      currentStep: _currentStep,
      onBack: _goToPreviousStep,
      child: SingleChildScrollView(
        child: _buildCurrentStep(),
      ),
    );
  }
}

class _DadosBasicosPeneiraStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const _DadosBasicosPeneiraStep({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Continuar",
      inputs: [
        categoryInput,
        InputConfig(
          key: "modality",
          label: "Modalidade",
          placeholder: "Selecione a modalidade",
          icon: Icons.sports_soccer_outlined,
          type: InputType.select,
          items: ModalityType.values.map((e) => e.toOption()).toList(),
        ),
        dateInput,
        hourInput,
      ],
      onSubmit: onSubmit,
    );
  }
}

class _DocumentosPeneiraStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const _DocumentosPeneiraStep({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      submitText: "Publicar Peneira",
      inputs: [
        InputConfig(
          key: "documents",
          label: "Documentos",
          placeholder: "Selecione os documentos",
          icon: Icons.description_outlined,
          type: InputType.select,
          items: DocumentType.values.map((e) => e.toOption()).toList(),
        ),
        InputConfig(
          key: "uniforms",
          label: "Uniforme",
          placeholder: "Selecione o uniforme",
          icon: Icons.checkroom_outlined,
          type: InputType.select,
          isMultiple: true,
          items: UniformType.values.map((e) => e.toOption()).toList(),
        ),
        const InputConfig(
          key: "about",
          label: "Sobre",
          placeholder: "Descreva a peneira (informações adicionais)",
          icon: Icons.info_outline,
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}
