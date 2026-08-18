import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:peneiras/widgets/header_stack.dart';
import 'package:peneiras/widgets/responsive_width.dart';

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                HeaderStack(
                  onBack: () {
                    context.pop();
                  },
                  title: "Foto de Perfil",
                ),
                const SizedBox(height: 20),
                const Text(
                  "Faça o upload da sua foto de perfil",
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.greenAccent,
                            width: 2,
                          ),
                          image: _getImageProvider(),
                        ),
                        child: (_selectedImage == null && _webImage == null)
                            ? const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white54,
                              )
                            : null,
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_selectedImage != null || _webImage != null)
                        ? () {
                            context.go("/cadastro/endereco");
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Continuar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DecorationImage? _getImageProvider() {
    if (kIsWeb && _webImage != null) {
      return DecorationImage(
        image: MemoryImage(_webImage!),
        fit: BoxFit.cover,
      );
    } else if (!kIsWeb && _selectedImage != null) {
      return DecorationImage(
        image: FileImage(_selectedImage!),
        fit: BoxFit.cover,
      );
    }
    return null;
  }
}
