import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({
    super.key,
    required this.size,
    this.selectedImage,
    this.webImage,
    this.imageUrl,
  });

  final File? selectedImage;
  final Uint8List? webImage;
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.greenAccent,
          width: 2,
        ),
        image: _getImageProvider(),
      ),
      child: (selectedImage == null &&
              webImage == null &&
              (imageUrl == null || imageUrl!.isEmpty))
          ? Icon(
              Icons.camera_alt,
              size: size * 0.4,
              color: Colors.white54,
            )
          : null,
    );
  }

  DecorationImage? _getImageProvider() {
    if (kIsWeb && webImage != null) {
      return DecorationImage(
        image: MemoryImage(webImage!),
        fit: BoxFit.cover,
      );
    } else if (!kIsWeb && selectedImage != null) {
      return DecorationImage(
        image: FileImage(selectedImage!),
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return DecorationImage(
        image: NetworkImage(imageUrl!),
        fit: BoxFit.cover,
      );
    }
    return null;
  }
}
