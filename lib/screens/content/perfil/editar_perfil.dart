import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/models/requests/clube_requests.dart';
import 'package:peneiras/models/requests/player_requests.dart';
import 'package:peneiras/models/inputs.dart';

import 'package:peneiras/services/player_service.dart';
import 'package:peneiras/services/club_service.dart';

import 'package:peneiras/layout/screen_frame.dart';

import 'package:peneiras/widgets/form/dynamic_form.dart';
import 'package:peneiras/widgets/photo_container.dart';
import 'package:peneiras/widgets/transparent_button.dart';

List<InputConfig> buildInputsJogador() => [
      getPlayerNameInput(),
      getEmailInput(),
      getBirthDateInput(),
      getPositionInput(),
      getDominantFootInput(),
      getHeightInput(),
      getCepInput(),
      getNumeroInput(),
      getComplementoInput(),
    ];

List<InputConfig> buildInputsClube() => [
      getTeamNameInput(),
      getEmailInput(),
      getCategoryInput(),
      getPhoneInput(),
      getWhatsappInput(),
      getInstagramInput(),
      getCepInput(),
      getNumeroInput(),
      getComplementoInput(),
    ];

class EditarPerfilScreen extends StatefulWidget {
  final bool isClub;

  const EditarPerfilScreen({super.key, this.isClub = false});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  late final String tipo;
  File? _selectedImage;
  Uint8List? _webImage;
  late final List<InputConfig> _inputs;

  @override
  void initState() {
    super.initState();
    tipo = widget.isClub ? "clube" : "jogador";
    _inputs = widget.isClub ? buildInputsClube() : buildInputsJogador();
  }

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

  Future<void> _handleSubmit(Map<String, dynamic> data) async {
    try {
      if (tipo == "jogador") {
        PlayerService playerService = PlayerService();

        await playerService.edit(
            dto: UpdatePlayerRequest.fromJson(data), photo: _selectedImage);
      } else {
        ClubService clubeService = ClubService();

        await clubeService.edit(
            dto: UpdateClubRequest.fromJson(data), photo: _selectedImage);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Perfil de $tipo criado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );

        if (context.canPop()) {
          context.pop();
        } else {
          context.go("/home/perfil");
        }
      }
    } catch (_) {}
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
                  inputs: _inputs,
                  onSubmit: _handleSubmit),
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
