import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/models/requests/peneira_requests.dart';
import 'package:peneiras/models/inputs.dart';

import 'package:peneiras/services/peneira_service.dart';
import 'package:peneiras/widgets/form/dynamic_form.dart';
import 'package:peneiras/layout/screen_frame.dart';

class AddPeneiraScreen extends StatelessWidget {
  const AddPeneiraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      title: "Nova Peneira",
      headerFontSize: 20,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Informações básicas e documentos\npreencha os dados para publicar a peneira.",
                textAlign: TextAlign.center,
              ),
            ),
            DynamicForm(
              submitText: "Publicar Peneira",
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
                  final peneiraService = PeneiraService();

                  await peneiraService.create(dataParaEnvio);

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
