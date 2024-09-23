import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ikimono_zukan/view/components/file_upload_widget.dart';
import 'package:my_ikimono_zukan/view/components/ikimono_register_form.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            Center(
              child: selectedImage != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.file(
                          File(selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.grey,
                      ),
                      height: 150,
                      width: 150,
                    ),
            ),
            const SizedBox(height: 8),
            FileUploadWidget(
              pickImageFromCamera: pickImageFromCamera,
              pickImageFromGallery: pickImageFromGallery,
            ),
            const SizedBox(height: 8),
            IkimonoRegisterForm(
              selectedImage: selectedImage,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      selectedImage = image;
    });
  }

  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      selectedImage = image;
    });
  }
}
