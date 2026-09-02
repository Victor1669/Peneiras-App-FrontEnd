import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:peneiras/layout/screen_frame.dart';
import 'package:peneiras/layout/responsive_width.dart';

import 'package:peneiras/widgets/photo_container.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
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
    return ResponsiveWidth(
      child: ScreenFrame(
        title: "Foto de Perfil",
        onBack: () => context.pop(),
        footer: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_selectedImage != null || _webImage != null)
                ? () => context.go("/cadastro/endereco")
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text("Continuar"),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Faça o upload da sua foto de perfil",
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhotoContainer(
                    size: 180,
                    selectedImage: _selectedImage,
                    webImage: _webImage,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.upload),
                    label: const Text("Upload foto"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
