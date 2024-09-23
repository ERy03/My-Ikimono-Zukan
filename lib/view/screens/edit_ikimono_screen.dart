import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ikimono_zukan/view/components/file_upload_widget.dart';
import 'package:my_ikimono_zukan/view/components/ikimono_edit_form.dart';

class EditIkimonoScreen extends StatefulWidget {
  const EditIkimonoScreen({
    required this.id,
    required this.ikimonoUrl,
    required this.name,
    required this.location,
    required this.description,
    required this.tag,
    required this.capturedDate,
    super.key,
  });

  final int id;
  final String name;
  final String location;
  final String description;
  final String tag;
  final DateTime capturedDate;
  final String ikimonoUrl;

  @override
  State<EditIkimonoScreen> createState() => _EditIkimonoScreenState();
}

class _EditIkimonoScreenState extends State<EditIkimonoScreen> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.name}'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            Center(
              child: selectedImage != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.file(
                              File(selectedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedImage = null;
                                });
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: widget.ikimonoUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            FileUploadWidget(
              pickImageFromCamera: pickImageFromCamera,
              pickImageFromGallery: pickImageFromGallery,
            ),
            const SizedBox(height: 8),
            IkimonoEditForm(
              selectedImage: selectedImage,
              id: widget.id,
              name: widget.name,
              location: widget.location,
              description: widget.description,
              tag: widget.tag,
              capturedDate: widget.capturedDate,
              ikimonoUrl: widget.ikimonoUrl,
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
