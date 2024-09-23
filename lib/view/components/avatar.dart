import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ikimono_zukan/main.dart';
import 'package:my_ikimono_zukan/view/components/file_upload_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Avatar extends StatefulWidget {
  const Avatar({
    required this.imageUrl,
    required this.onUpload,
    super.key,
  });

  final String? imageUrl;
  final void Function(String) onUpload;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.imageUrl == null || widget.imageUrl!.isEmpty)
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            width: 150,
            height: 150,
            child: const Center(
              child: Text('No Image'),
            ),
          )
        else
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        const SizedBox(height: 8),
        FileUploadWidget(
          pickImageFromCamera: () {
            _isLoading ? null : _upload(pickImageFromCamera);
          },
          pickImageFromGallery: () {
            _isLoading ? null : _upload(pickImageFromGallery);
          },
        ),
      ],
    );
  }

  Future<XFile?> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    return image;
  }

  Future<XFile?> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
      maxHeight: 300,
    );
    return image;
  }

  Future<void> _upload(Future<XFile?> Function() pickImageFromCamera) async {
    final imageFile = await pickImageFromCamera();
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${supabase.auth.currentUser!.id}_avatar.$fileExt';
      final filePath = fileName;
      await supabase.storage.from('avatars').remove([fileName]);
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );
      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        context.showSnackBar(error.message, isError: true);
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    }

    setState(() => _isLoading = false);
  }
}
