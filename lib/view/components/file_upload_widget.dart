import 'package:flutter/material.dart';

class FileUploadWidget extends StatelessWidget {
  const FileUploadWidget({
    required this.pickImageFromCamera,
    required this.pickImageFromGallery,
    super.key,
  });

  final VoidCallback pickImageFromCamera;
  final VoidCallback pickImageFromGallery;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                style: const ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Color(0xffc9f082)),
                ),
                onPressed: pickImageFromCamera,
                icon: const Icon(
                  Icons.camera_alt,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: IconButton(
                style: const ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Color(0xffc9f082)),
                ),
                onPressed: pickImageFromGallery,
                icon: const Icon(Icons.upload),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
