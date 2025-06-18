import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/providers/picture_provider.dart';
import 'package:gallery/screens/new_picture_screen.dart';
import 'package:gallery/screens/picture_screen.dart';
import 'package:gallery/widgets/pictures_grid.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  void _goToNewPictureScreen(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => NewPictureScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pictures = ref.watch(picturesProvider);
    Widget content = Center(child: Text('No images yet.'));

    if (pictures.isNotEmpty) {
      content = PicturesGrid(
        pictures: pictures,
        onPictureSelected: (picture) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PictureScreen(picture: picture),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('All images'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _goToNewPictureScreen(context);
            },
          ),
        ],
      ),
      body: content,
    );
  }
}
