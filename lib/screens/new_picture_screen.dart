import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/models/picture.dart';
import 'package:gallery/providers/picture_provider.dart';
import 'package:gallery/widgets/image_picker_field.dart';

class NewPictureScreen extends ConsumerStatefulWidget {
  const NewPictureScreen({super.key});

  @override
  ConsumerState<NewPictureScreen> createState() => _NewPictureScreenState();
}

class _NewPictureScreenState extends ConsumerState<NewPictureScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePicture() {
    final title = _titleController.text;
    if (title.trim().isEmpty || _selectedImage == null) {
      return;
    }

    final newPicture = Picture(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: _selectedImage!,
    );

    ref.read(picturesProvider.notifier).addPicture(newPicture);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(onPressed: _savePicture, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
