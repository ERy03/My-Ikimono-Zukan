import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ikimono_zukan/data/repositories/ikimono_repository.dart';
import 'package:my_ikimono_zukan/main.dart';
import 'package:my_ikimono_zukan/view/screens/bottom_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IkimonoEditForm extends ConsumerStatefulWidget {
  const IkimonoEditForm({
    required this.id,
    required this.ikimonoUrl,
    required this.name,
    required this.location,
    required this.description,
    required this.tag,
    required this.capturedDate,
    required this.selectedImage,
    super.key,
  });

  final XFile? selectedImage;
  final int id;
  final String name;
  final String location;
  final String description;
  final String tag;
  final DateTime capturedDate;
  final String ikimonoUrl;

  @override
  ConsumerState<IkimonoEditForm> createState() => _IkimonoEditFormState();
}

class _IkimonoEditFormState extends ConsumerState<IkimonoEditForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  String? _selectedLocation;
  String? _selectedTag;
  DateTime? _selectedDate;
  var _loading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _descriptionController.text = widget.description;
    _dateController.text =
        '${widget.capturedDate.year}-${widget.capturedDate.month}-${widget.capturedDate.day}';
    _selectedLocation = widget.location;
    _selectedTag = widget.tag;
    _selectedDate = widget.capturedDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _upload() async {
    setState(() {
      _loading = true;
    });

    try {
      if (widget.selectedImage != null) {
        final bytes = await widget.selectedImage!.readAsBytes();
        final fileExt = widget.selectedImage!.path.split('.').last;
        final fileName =
            '${supabase.auth.currentUser!.id}_${_nameController.text}.$fileExt';
        await supabase.storage.from('ikimono').uploadBinary(
              fileName,
              bytes,
              fileOptions:
                  FileOptions(contentType: widget.selectedImage!.mimeType),
            );
        final imageUrlResponse = await supabase.storage
            .from('ikimono')
            .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10);
        await _onUpdate(imageUrlResponse);
      } else {
        await _onUpdate(widget.ikimonoUrl);
      }

      if (mounted) {
        _nameController.clear();
        _descriptionController.clear();
        _dateController.clear();
        ref.invalidate(fetchIkimonosProvider);
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const BottomNavigation()),
          (route) => false,
        );
      }
    } on StorageException catch (error) {
      if (mounted) {
        context.showSnackBar(error.message, isError: true);
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    }

    setState(() => _loading = false);
  }

  Future<void> _onUpdate(String imageUrl) async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final date = _selectedDate;
    final location = _selectedLocation;
    final tag = _selectedTag;
    final user = supabase.auth.currentUser;

    final upsertIkimono = {
      'id': widget.id,
      'name': name,
      'description': description,
      'user': user!.id,
      'location': location,
      'tag': tag,
      'captured_date': DateFormat.yMd().format(date!),
      'ikimono_url': imageUrl,
    };
    setState(() {
      _loading = true;
    });
    try {
      await supabase.from('ikimono').upsert(upsertIkimono);
      if (mounted) context.showSnackBar('Successfully Updated ikimono!');
    } on PostgrestException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    }
    setState(() => _loading = false);
  }

  final List<String> _locations = [
    'city',
    'mountain',
    'park',
    'beach',
    'river',
    'sea',
    'aquarium',
    'zoo',
    'other',
  ];

  final List<String> _tags = [
    'insect',
    'bird',
    'animal',
    'fish',
    'reptile',
    'plant',
    'other',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${picked.year}-${picked.month}-${picked.day}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IkimonoTextFormField(
          controller: _nameController,
          labelText: 'Name',
        ),
        const SizedBox(height: 8),

        // Dropdown for Location
        DropdownButtonFormField<String>(
          value: _selectedLocation,
          decoration: const InputDecoration(
            labelText: 'Location',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc9f082)),
            ),
          ),
          items: _locations.map((location) {
            return DropdownMenuItem<String>(
              value: location,
              child: Text(location),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedLocation = value;
            });
          },
        ),
        const SizedBox(height: 8),

        // Dropdown for Tag
        DropdownButtonFormField<String>(
          value: _selectedTag,
          decoration: const InputDecoration(
            labelText: 'Tag',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc9f082)),
            ),
          ),
          items: _tags.map((tag) {
            return DropdownMenuItem<String>(
              value: tag,
              child: Text(tag),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedTag = value;
            });
          },
        ),
        const SizedBox(height: 8),

        // Captured Date (Date Picker)
        IkimonoTextFormField(
          controller: _dateController,
          labelText: 'Captured Date',
          keyboardType: TextInputType.datetime,
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
        const SizedBox(height: 8),

        // Description Field
        SizedBox(
          height: 120,
          child: IkimonoTextFormField(
            controller: _descriptionController,
            labelText: 'Description',
            keyboardType: TextInputType.multiline,
            expands: true,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            width: 150,
            child: TextButton(
              onPressed: _loading ? null : _upload,
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(Color(0xffc9f082)),
              ),
              child: _loading
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      'Update',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class IkimonoTextFormField extends StatelessWidget {
  const IkimonoTextFormField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.expands = false,
    this.onTap,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final bool expands;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: expands ? null : 1,
      expands: expands,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffc9f082),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
