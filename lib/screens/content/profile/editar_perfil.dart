import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:peneiras/layout/screen_frame.dart';
import 'package:peneiras/models/input_config.dart';

import 'package:peneiras/widgets/form/dynamic_form.dart';
import 'package:peneiras/models/inputs.dart';
import 'package:peneiras/widgets/photo_container.dart';
import 'package:peneiras/widgets/transparent_button.dart';

final List<InputConfig> inputsJogador = [
  playerNameInput,
  positionInput,
  heightInput,
];
final List<InputConfig> inputsClube = [
  teamNameInput,
  categoryInput,
  passwordInput,
];

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final String tipo = "jogador";
  File? _selectedImage;
  Uint8List? _webImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        var bytes = await image.readAsBytes();
        setState(() {
          _webImage = bytes;
        });
      } else {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
        title: "Atualizar informações",
        headerFontSize: 20,
        onBack: () => context.go("/"),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Dados pessoais\npreencha seus dados basicos.",
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: _pickImage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PhotoContainer(
                      size: 100,
                      selectedImage: _selectedImage,
                      webImage: _webImage,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Foto de perfil\nAltere sua foto de perfil",
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              DynamicForm(
                  submitText: "Continuar",
                  inputs: tipo == "clube" ? inputsClube : inputsJogador,
                  onSubmit: (data) async {
                    print(data);
                  }),
              TransparentButton(
                  onPressed: () {}, child: const Text("Excluir conta")),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
