import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  final void Function(File? image) onImageSelected;

  const ImagePickerField({super.key, required this.onImageSelected});

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  File? _selectedImage;

  void _takePhoto(ImageSource source) async {
    final imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      maxWidth: 1024,
    );

    if (image == null) {
      return;
    }

    final imageFile = File(image.path);

    setState(() {
      _selectedImage = imageFile;
    });
    widget.onImageSelected(imageFile);
  }

  void _clearPhoto() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.camera_alt),
          label: Text('Take a photo'),
          onPressed: () => _takePhoto(ImageSource.camera),
        ),
        SizedBox(height: 8),
        ElevatedButton.icon(
          icon: Icon(Icons.image_search),
          label: Text('Choose from gallery'),
          onPressed: () => _takePhoto(ImageSource.gallery),
        ),
      ],
    );

    if (_selectedImage != null) {
      content = Stack(
        children: [
          Image.file(
            _selectedImage!,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: IconButton(
              onPressed: _clearPhoto,
              style: IconButton.styleFrom(
                backgroundColor: theme.primaryColor.withValues(alpha: 0.3),
              ),
              icon: Icon(Icons.clear),
            ),
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return Container(
          width: width,
          height: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: content,
        );
      },
    );
  }
}
