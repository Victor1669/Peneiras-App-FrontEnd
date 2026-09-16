import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:peneiras/providers/player_controller.dart';
import 'package:peneiras/providers/club_controller.dart';

import 'package:peneiras/models/input_config.dart';
import 'package:peneiras/models/requests/clube_requests.dart';
import 'package:peneiras/models/requests/player_requests.dart';
import 'package:peneiras/models/inputs.dart';

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

class EditarPerfilScreen extends ConsumerStatefulWidget {
  final bool isClub;

  const EditarPerfilScreen({super.key, this.isClub = true});

  @override
  ConsumerState<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends ConsumerState<EditarPerfilScreen> {
  late final String tipo;
  File? _selectedImage;
  Uint8List? _webImage;
  late final List<InputConfig> _inputs;
  String? _userImgUrl;

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
      final nestedData = Map<String, dynamic>.from(data);

      nestedData['address'] = {
        'id': "",
        'cep': nestedData.remove('cep'),
        'numero': nestedData.remove('numero'),
        'complemento': nestedData.remove('complemento'),
      };

      if (tipo == "jogador") {
        await ref.read(playerControllerProvider.notifier).updatePlayer(
              dto: PlayerWithAddressRequest.fromJson(nestedData),
              photo: _selectedImage,
            );
      } else {
        await ref.read(clubControllerProvider.notifier).updateClub(
              dto: ClubWithAddressRequest.fromJson(nestedData),
              photo: _selectedImage,
            );
      }

      if (mounted) {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go("/home/perfil");
        }
      }
    } catch (_) {}
  }

  Map<String, dynamic> _prepareInitialValues(dynamic data) {
    final dataMap = data.toJson();
    final flatData = Map<String, dynamic>.from(dataMap);

    setState(() {
      _userImgUrl = flatData['userImg'] as String?;
    });

    final address = flatData.remove('address');

    if (address != null) {
      final addressMap =
          address is Map<String, dynamic> ? address : address.toJson();
      flatData['cep'] = addressMap['cep'];
      flatData['numero'] = addressMap['numero'];
      flatData['complemento'] = addressMap['complemento'];
    }

    return flatData;
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = tipo == "jogador"
        ? ref.watch(playerControllerProvider)
        : ref.watch(clubControllerProvider);

    return asyncData.when(
      data: (entity) {
        final initialValues = _prepareInitialValues(entity);
        return _buildFormScaffold(initialValues);
      },
      loading: () => ScreenFrame(
        title: "Atualizar informações",
        headerFontSize: 20,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => ScreenFrame(
        title: "Atualizar informações",
        headerFontSize: 20,
        child: Center(
            child: Text("Erro ao carregar dados",
                style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildFormScaffold(Map<String, dynamic> initialValues) {
    return ScreenFrame(
      title: "Atualizar informações",
      headerFontSize: 20,
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                tipo == "jogador"
                    ? "Dados pessoais\npreencha seus dados basicos."
                    : "Dados do clube\npreencha as informações básicas.",
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
                    imageUrl: _userImgUrl,
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
              submitText: "Atualizar perfil",
              inputs: _inputs,
              initialValues: initialValues,
              onSubmit: _handleSubmit,
            ),
            TransparentButton(
                onPressed: () {}, child: const Text("Excluir conta")),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
