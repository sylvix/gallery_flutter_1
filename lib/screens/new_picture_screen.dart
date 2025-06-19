import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/providers/picture_provider.dart';
import 'package:gallery/providers/picture_upload_provider.dart';
import 'package:gallery/widgets/image_picker_field.dart';
import 'package:path/path.dart' as path;

class NewPictureScreen extends ConsumerStatefulWidget {
  const NewPictureScreen({super.key});

  @override
  ConsumerState<NewPictureScreen> createState() => _NewPictureScreenState();
}

class _NewPictureScreenState extends ConsumerState<NewPictureScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePicture() async {
    final title = _titleController.text;

    if (title.trim().isEmpty || _selectedImage == null) {
      return;
    }

    final now = DateTime.now();
    final image = _selectedImage!;
    final fileName =
        '${now.microsecondsSinceEpoch}${path.extension(image.path)}';

    await ref.read(pictureUploadProvider.notifier).uploadImage(image, fileName);
    await ref
        .read(createPictureProvider.notifier)
        .createPicture(title, fileName);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(pictureUploadProvider);
    final createState = ref.watch(createPictureProvider);
    final isLoading = uploadState.isLoading || createState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('New Picture')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            SizedBox(height: 16),
            ImagePickerField(
              onImageSelected: (image) {
                _selectedImage = image;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _savePicture,
              child:
                  isLoading
                      ? SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(),
                      )
                      : Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
