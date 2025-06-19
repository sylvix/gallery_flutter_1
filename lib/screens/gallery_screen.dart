import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/providers/picture_provider.dart';
import 'package:gallery/screens/new_picture_screen.dart';
import 'package:gallery/screens/picture_screen.dart';
import 'package:gallery/widgets/pictures_grid.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  void _goToNewPictureScreen(BuildContext context, WidgetRef ref) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => NewPictureScreen()));
    ref.invalidate(picturesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picturesState = ref.watch(picturesProvider);
    Widget content = Center(child: Text('No images yet.'));

    if (picturesState.hasValue) {
      content = PicturesGrid(
        pictures: picturesState.value!,
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
              _goToNewPictureScreen(context, ref);
            },
          ),
        ],
      ),
      body: content,
    );
  }
}
