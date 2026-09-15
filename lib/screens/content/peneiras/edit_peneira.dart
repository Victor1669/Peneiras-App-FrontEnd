import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/models/requests/peneira_requests.dart';
import 'package:peneiras/models/inputs.dart';
import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/services/peneira_service.dart';
import 'package:peneiras/widgets/form/dynamic_form.dart';
import 'package:peneiras/layout/screen_frame.dart';

class EditPeneiraScreen extends StatefulWidget {
  final String peneiraId;

  const EditPeneiraScreen({super.key, required this.peneiraId});

  @override
  State<EditPeneiraScreen> createState() => _EditPeneiraScreenState();
}

class _EditPeneiraScreenState extends State<EditPeneiraScreen> {
  final PeneiraService _peneiraService = PeneiraService();
  late Future<PeneiraModel> _peneiraFuture;

  @override
  void initState() {
    super.initState();
    _peneiraFuture = _peneiraService.getById(widget.peneiraId);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      title: "Editar Peneira",
      headerFontSize: 20,
      onBack: () => {context.go("/home")},
      child: FutureBuilder<PeneiraModel>(
        future: _peneiraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
                child: Text("Erro ao carregar dados da peneira"));
          }

          return _EditPeneiraFormView(
            peneiraId: widget.peneiraId,
            initialData: snapshot.data!.toJson(),
            peneiraService: _peneiraService,
          );
        },
      ),
    );
  }
}

class _EditPeneiraFormView extends StatelessWidget {
  final String peneiraId;
  final Map<String, dynamic> initialData;
  final PeneiraService peneiraService;

  const _EditPeneiraFormView({
    required this.peneiraId,
    required this.initialData,
    required this.peneiraService,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Informações básicas e documentos\npreencha os dados para atualizar a peneira.",
                textAlign: TextAlign.center,
              ),
            ),
            DynamicForm(
              key: ValueKey(peneiraId),
              initialValues: initialData,
              submitText: "Salvar Alterações",
              inputs: [
                getCategoryInput(),
                getModalityInput(),
                getDateInput(),
                getHourInput(),
                getDocumentInput(),
                getUniformInput(),
                getAboutInput(),
              ],
              onSubmit: (data) async {
                final PeneiraRequest dataParaEnvio =
                    PeneiraRequest.fromJson(data);

                try {
                  await peneiraService.update(dataParaEnvio, peneiraId);

                  if (context.mounted) {
                    context.go("/home");
                  }
                } catch (_) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
