import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/providers/picture_provider.dart';
import 'package:gallery/screens/picture_screen.dart';
import 'package:gallery/widgets/pictures_grid.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pictures = ref.watch(picturesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('All images'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: PicturesGrid(
        pictures: pictures,
        onPictureSelected: (picture) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PictureScreen(picture: picture),
            ),
          );
        },
      ),
    );
  }
}
